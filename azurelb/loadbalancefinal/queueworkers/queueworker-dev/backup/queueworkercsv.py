import pika

import time

import redis

from web3 import Web3,HTTPProvider
from time import sleep
import json
import time
import csv
import threading
import websocket
#requests library
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

geth_ws = "ws://10.214.226.142:2200"
maincontractaddress="0x47049a977274eaeddcf11bf7af62615421d55500"
redishost='10.214.226.36'
rabbithost='10.214.226.36'
rabbitport='5672'
host="10.214.226.36"
workertype="1"
clientthreads=1
nonce=0
nodetype="A"

web3 = Web3(Web3.WebsocketProvider(geth_ws))
from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#threading
from threading import Thread

#queuing
from queue import Queue

pool = redis.ConnectionPool(host=redishost, port=6379, db=0)
redisserver = redis.Redis(connection_pool=pool)
credentials = pika.PlainCredentials('guest', 'guest')
connection = pika.BlockingConnection(pika.ConnectionParameters(rabbithost,rabbitport,'/',credentials))
channel = connection.channel()
channel.queue_declare(queue='transactionqueue', durable=True)

#websocket
ws = websocket.WebSocket()
#threadqueue
q=Queue()
totalresult=[]

def readAbiData():
  with open('main.json') as jsonfile:
    abidata = json.load(jsonfile)
    return abidata


account = web3.eth.accounts[0]
contract = web3.eth.contract(address=Web3.toChecksumAddress(maincontractaddress),abi=readAbiData())
gashex = web3.toHex(5000000)
gaspricehex = web3.toHex(1)
ws.connect(geth_ws)
txparam=contract.functions.createTest(100).buildTransaction({
    'from': account
    })

def sendTransaction():
   #num_worker_threads
   for i in range(clientthreads):
         t = Thread(target=worker)
         t.daemon = True
         t.start()
   q.join()

def worker():
    while True:
            nonce = q.get()
            threadfunction(nonce,txparam,gashex,gaspricehex,totalresult,ws)
            q.task_done()


def threadfunction(redisnonce,txparam,gashex,gaspricehex,totalresult,ws):
  result=[]
  starttime=int(round(time.time()))
  txparame={
    'chainId':int(txparam.get('chainId')),
    'from':str(txparam.get('from')),
    'nonce':web3.toHex(redisnonce),
    'gas':gashex,
    'gasPrice':gaspricehex,
    'to':str(txparam.get('to')),
    'data':str(txparam.get('data'))
    }
  method = 'eth_sendTransaction'
  request=dict(jsonrpc="2.0",
            method = method,
            params = [txparame],
            id = 1)
  ws.send(json.dumps(request))
  response = ws.recv()
  endtime=int(round(time.time()))
  jsonresponse = json.loads(response)
  if 'result' not in jsonresponse:
        result.insert(0,jsonresponse['error'])
  else:
        result.insert(0,jsonresponse['result'])
        result.insert(1,starttime)
        result.insert(2,endtime)
        result.insert(3,nodetype+str(redisnonce))
        
        totalresult.append(result)


def getTransaction():
   with open(str(host)+str(workertype)+".csv","w") as csvfile:
    fieldname=['Transactionid','Start','End','Count']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    writer.writeheader()
    sendTransaction()

def printResult():
   with open(str(host)+str(workertype)+".csv","a") as csvfile:
    fieldname=['Transactionid','Start','End','Count']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    for row in totalresult:
      writer.writerow({'Transactionid':row[0],'Start':row[1],'End':row[2],'Count':row[3]})


def callback(ch, method, properties, body):
 mileage = body.decode()
 if mileage =="print":
  printResult()
 else:
  try:
   with redisserver.lock('noncelock') as redislock:
    noncevar = int(redisserver.get('nonce').decode('utf-8'))
    redisserver.set('nonce',noncevar+1)
    q.put(noncevar)
    ch.basic_ack(delivery_tag=method.delivery_tag)
  except:
   print('lock wasnt acquired')

if redisserver.get('nonce')==None:
 with redisserver.lock('noncelock') as redislock:
  walletnonce = web3.eth.getTransactionCount(account)
  redisserver.set('nonce',walletnonce)
getTransaction()
channel.basic_qos(prefetch_count=1)
channel.basic_consume(queue='transactionqueue',on_message_callback=callback)
channel.start_consuming()
