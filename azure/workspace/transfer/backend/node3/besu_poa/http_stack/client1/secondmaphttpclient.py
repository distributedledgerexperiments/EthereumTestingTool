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
from web3.middleware import geth_poa_middleware

from config import NODE_ACCOUNT, NODE_PRIVATE_KEY

from config import RPCaddress, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS

geth_http = RPCaddress

mongodbhost = MONGO_DB
mongodbport = MONGO_PORT

maincontractaddress = CONTRACT_ADDRESS

account=Web3.toChecksumAddress(NODE_ACCOUNT)

privatekey=NODE_PRIVATE_KEY

web3 = Web3(HTTPProvider(geth_http))

web3.middleware_onion.inject(geth_poa_middleware, layer=0)

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


def readAbiData():
  with open('main.json') as jsonfile:
    abidata = json.load(jsonfile)
    return abidata
   
def sendTransaction():
   permissionedaddress="0xf9eae0f545c0d5b1f1538df4746e46bf2c90d381"
   metadata="test"
   #walletnonce = web3.eth.getTransactionCount(account)
   contract = web3.eth.contract(address=Web3.toChecksumAddress(maincontractaddress),abi=readAbiData())

   session = requests.Session()
   retry = Retry(connect=3, backoff_factor=0.5)
   adapter = HTTPAdapter(max_retries=retry)
   session.mount('http://', adapter)
   session.mount('https://', adapter)

   method_pen = 'eth_getTransactionCount'
   payload_pen= {"jsonrpc" : "2.0",
            "method" : method_pen,
            "params" : [account,'latest'],
            "id"     : 1}
   headers = {'Content-type' : 'application/json'}

   response = session.post(geth_http, json=payload_pen, headers=headers)
   totalnonce=Web3.toInt(hexstr=response.json().get('result'))
   print(totalnonce)


   totalresult=[]
   gashex = web3.toHex(5000000)
   gaspricehex = web3.toHex(1)
   threadsarray=[]
   
   q = Queue()
   howManyLeft=NUMBER_OF_TRANSACTIONS
   batchSize=int(NUMBER_OF_TRANSACTIONS/4)
   iter=0
    
   def worker():
        while True:
            item = q.get()
            threadfunction(item,contract,totalnonce,gashex,gaspricehex,totalresult,session)
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


def threadfunction(increment,contract,totalnonce,gashex,gaspricehex,totalresult,session):
  result=[]
  starttime=int(round(time.time()))

  txparam=contract.functions.secondMapTest(88888888888888,9999999999).buildTransaction({
    'chainId':int(26),
    'from': account,
    'nonce':web3.toHex(totalnonce+increment),
    'gas':gashex,
    'gasPrice':gaspricehex
   })
  signedtx=web3.eth.account.signTransaction(txparam,privatekey)
  method = 'eth_sendRawTransaction'
  payload= {"jsonrpc" : "2.0",
            "method" : method,
            "params" : [web3.toHex(signedtx.rawTransaction)],
            "id"     : 1}
  headers = {'Content-type' : 'application/json'}


  #normal mode
  #session = requests.Session()
  #response = requests.post(geth_http, json=payload, headers=headers)
  
  #retry mode
  #response = session.post(geth_http, json=payload, headers=headers)
  response = session.post(geth_http, json=payload, headers=headers)

  endtime=int(round(time.time()))
  result.insert(0,response.json().get('result'))
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

