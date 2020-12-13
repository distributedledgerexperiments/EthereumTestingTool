from web3 import Web3,HTTPProvider
#CHECK ULIMIT
#e.g: ulimit -n 10000
import json
import time
import csv

import websocket
#requests library
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

from config import RPCaddress, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS

geth_ws = RPCaddress

mongodbhost = MONGO_DB
mongodbport = MONGO_PORT

maincontractaddress = CONTRACT_ADDRESS

mongodb_url=str(MONGO_DB)+":"+str(MONGO_PORT)
mongodburls=[mongodb_url]

web3 = Web3(Web3.WebsocketProvider(geth_ws))
from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#MongoDB
from pymongo import MongoClient,errors

#threading
from threading import Thread

#queuing
from queue import Queue

import sys

iteration_value=str(sys.argv[1])
ws = websocket.WebSocket()

def readAbiData():
  with open('main.json') as jsonfile:
    abidata = json.load(jsonfile)
    return abidata
   
def sendTransaction():
   ws.connect(geth_ws)
   
   permissionedaddress="0xf9eae0f545c0d5b1f1538df4746e46bf2c90d381"
   metadata="test"
   account = web3.eth.accounts[0]
   walletnonce = web3.eth.getTransactionCount(account)
   contract = web3.eth.contract(address=Web3.toChecksumAddress(maincontractaddress),abi=readAbiData())
   
   method = 'parity_defaultAccount'
   request=dict(jsonrpc="2.0",
            method = method,
            params = [],
            id = 1)
   ws.send(json.dumps(request))
   response = ws.recv()
   jsonresponse = json.loads(response)
   address=jsonresponse['result']

   methodnonce = 'parity_nextNonce'
   noncerequest=dict(jsonrpc="2.0",
            method = methodnonce,
            params = [address],
            id = 1)

   ws.send(json.dumps(noncerequest))
   nonceresponse = ws.recv()
   noncejsonresponse = json.loads(nonceresponse)
   nonceresult=noncejsonresponse['result']
   totalnonce=Web3.toInt(hexstr=nonceresult)

   totalresult=[]
   gashex = web3.toHex(5000000)
   gaspricehex = web3.toHex(0)
   threadsarray=[]
   txparam=contract.functions.addTest(100).buildTransaction({
    'from': account
    })
   
   q = Queue()
   howManyLeft=NUMBER_OF_TRANSACTIONS
   batchSize=int(NUMBER_OF_TRANSACTIONS/4)
   iter=0
    
   def worker():
        while True:
            item = q.get()
            threadfunction(item,txparam,totalnonce,gashex,gaspricehex,totalresult,ws)
            q.task_done()
   #num_worker_threads
   for i in range(CLIENT_THREADS):
         t = Thread(target=worker)
         t.daemon = True
         t.start()
   #print ("%d worker threads created." % 100)

  
   #print ("%d items queued." % 10)
   while howManyLeft>0:

    for index in range((iter*batchSize),(batchSize*(iter+1))):
        q.put (index)
    #print ("%d items queued." % 10)

    q.join()
    howManyLeft -= batchSize
    iter=iter+1
    
   return totalresult

#https://github.com/ethereum/wiki/wiki/JSON-RPC


def threadfunction(increment,txparam,totalnonce,gashex,gaspricehex,totalresult,ws):
  result=[]
  starttime=int(round(time.time()))

  txparame={
    'from':str(txparam.get('from')),
    'nonce':web3.toHex(totalnonce+increment),
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

  #normal mode
  #session = requests.Session()
  #response = requests.post(geth_http, json=payload, headers=headers)
  
  #retry mode
  endtime=int(round(time.time()))
  jsonresponse = json.loads(response)
  if 'result' not in jsonresponse:
        result.insert(0,jsonresponse['error'])
  else:
        result.insert(0,jsonresponse['result'])
        result.insert(1,starttime)
        result.insert(2,endtime)
        result.insert(3,endtime-starttime)
        totalresult.append(result)
  return result


def getTransaction():
    txarray=sendTransaction()
    try:
         client=MongoClient(host=[str(mongodbhost)+':'+str(mongodbport)],serverSelectionTimeoutMS=3000,username='guest',password='guest')
         db = client.resultdb
         results = db.results
         errors = db.errors
    except errors.ServerSelectionTimeoutError as err:
         # catch pymongo.errors.ServerSelectionTimeoutError
         print ("pymongo ERROR:", err)
   
    mongoresults=[]
    for row in txarray:
        resultvalue={'Transactionid':row[0],'Start':row[1],'End':row[2],'Lapse':row[3],'Iteration':iteration_value}
        mongoresults.append(resultvalue)
    try:
        results.insert_many(mongoresults)
    except errors.ServerSelectionTimeoutError as err:
      # catch pymongo.errors.ServerSelectionTimeoutError
      print ("pymongo ERROR:", err)
 


getTransaction()

