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

#MongoDB
from pymongo import MongoClient,errors

from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#threading
from threading import Thread

#queuing
from queue import Queue

#redislock
#pip install python-redis-lock
import redis_lock

class QueueWorker(threading.Thread):
       
    def threadfunction(self,redisnonce,channel,method, properties, body):
     txparam = self.txparam
     starttime=int(round(time.time()))
     txparame={
      'chainId':int(txparam.get('chainId')),
      'from':str(txparam.get('from')),
      'nonce':self.web3.toHex(redisnonce),
      'gas':self.gashex,
      'gasPrice':self.gaspricehex,
      'to':str(txparam.get('to')),
      'data':str(txparam.get('data'))
        }
     methodrpc = 'eth_sendTransaction'
     request=dict(jsonrpc="2.0",
            method = methodrpc,
            params = [txparame],
            id = 1)
     self.ws.send(json.dumps(request))
     response = self.ws.recv()
     endtime=int(round(time.time()))
     jsonresponse = json.loads(response)
     #print(jsonresponse)

     #channel.basic_publish(exchange='',
                     #routing_key=properties.reply_to,
                     #properties=pika.BasicProperties(correlation_id = \
                                                         #properties.correlation_id),
                     #body=str(jsonresponse['result']))
     
     if 'result' not in jsonresponse:
        resulterror={'Transactionid':jsonresponse['error'],'Start':starttime,'End':endtime,'Count':self.nodetype+str(redisnonce),'host':str(self.host)+str(self.workertype)}
        try:
         self.errors.insert_one(resulterror)
        except errors.ServerSelectionTimeoutError as err:
         # catch pymongo.errors.ServerSelectionTimeoutError
         print ("pymongo ERROR:", err)
     else:
        resultdocument={'Transactionid':str(jsonresponse['result']),'Start':str(starttime),'End':str(endtime),'Count':str(self.nodetype+str(redisnonce)),'host':str(str(self.host)+str(self.workertype))}
        print(resultdocument)
        try:
         self.results.insert_one(resultdocument)
         #MongoDB Read Statements
         #print(self.results.count_documents({}))
         #for result in self.results.find({}):
           #print(result)
        except errors.ServerSelectionTimeoutError as err:
         # catch pymongo.errors.ServerSelectionTimeoutError
         print ("pymongo ERROR:", err)

    def readAbiData(self):
     with open('main.json') as jsonfile:
       abidata = json.load(jsonfile)
       return abidata

    def callback(self,channel,method, properties, body):
      mileage = body.decode()
      try:
          with redis_lock.Lock(self.redisserver,"noncelock") as lock:
            noncevar = int(self.redisserver.get('nonce').decode('utf-8'))
            self.redisserver.set('nonce',noncevar+1)
            #lock.release()
            channel.basic_ack(delivery_tag=method.delivery_tag)
            self.threadfunction(noncevar,channel,method,properties,body)
      except Exception as e:
          print('lock wasnt acquired'+str(e))       
        
    def __init__(self):
        threading.Thread.__init__(self)
        self.geth_ws = "ws://localhost:2200"
        self.host="localhost"
        self.workertype="A"
        self.maincontractaddress="0x47049a977274eaeddcf11bf7af62615421d55500"
        self.mongodbhost='localhost'
        self.mongodbport='27017'
        self.redishost='localhost'
        self.redisinstance=[(self.redishost,6379)]
        self.rabbithost='localhost'
        self.rabbitport='5672'
        self.nonce=0
        self.nodetype="Node1"

        #websocket
        self.ws = websocket.WebSocket()
        #threadqueue
        self.totalresult=[] 
        self.web3 = Web3(Web3.WebsocketProvider(self.geth_ws))
        self.account = self.web3.eth.accounts[0]
        self.contract = self.web3.eth.contract(address=Web3.toChecksumAddress(self.maincontractaddress),abi=self.readAbiData())
        self.gashex = self.web3.toHex(5000000)
        self.gaspricehex = self.web3.toHex(1)
        self.ws.connect(self.geth_ws)
        self.txparam=self.contract.functions.createTest(100).buildTransaction({
           'from': self.account
           })

        
        self.pool = redis.ConnectionPool(host=self.redishost, port=6379, db=0)
        self.redisserver = redis.Redis(connection_pool=self.pool)
        if self.redisserver.get('nonce')==None:
          try:
           with redis_lock.Lock(self.redisserver,"noncelock") as lock:
            walletnonce = self.web3.eth.getTransactionCount(self.account)
            self.redisserver.set('nonce',walletnonce)
            #lock.release()
          except Exception as e:
            print('lock wasnt acquired'+str(e))       
        
        #print mongodb
        try:
         self.client=MongoClient(host=[str(self.mongodbhost)+':'+str(self.mongodbport)],serverSelectionTimeoutMS=3000,username='guest',password='guest')
         self.db = self.client.resultdb
         self.results = self.db.results
         self.errors = self.db.errors
        except errors.ServerSelectionTimeoutError as err:
         # catch pymongo.errors.ServerSelectionTimeoutError
         print ("pymongo ERROR:", err)
    

        self.credentials = pika.PlainCredentials('guest', 'guest')
        self.connection = pika.BlockingConnection(pika.ConnectionParameters(self.rabbithost,self.rabbitport,'/',self.credentials))
        self.channel = self.connection.channel()
        self.channel.queue_declare(queue='transactionqueue', durable=True)
        self.channel.basic_qos(prefetch_count=1)
        self.channel.basic_consume(queue='transactionqueue',on_message_callback=self.callback)

        
        
    def run(self):
      self.channel.start_consuming()
      

for i in range(9):
    t = QueueWorker()
    t.start()





