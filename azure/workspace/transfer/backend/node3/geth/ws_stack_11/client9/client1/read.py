from web3 import Web3,HTTPProvider
from time import sleep
import json
import time
import csv

import websocket
#requests library
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

import sys

from config import RPCaddress_http, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS

geth_ws = RPCaddress_http

mongodbhost = MONGO_DB
mongodbport = MONGO_PORT

maincontractaddress = CONTRACT_ADDRESS

mongodb_url=str(MONGO_DB)+":"+str(MONGO_PORT)
mongodburls=[mongodb_url]

web3 = Web3(HTTPProvider(geth_ws))
from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#threading
from threading import Thread

#queuing
from queue import Queue

#MongoDB
from pymongo import MongoClient,errors

iteration_value=str(sys.argv[1])

#websocket
ws = websocket.WebSocket()
totalnonce=0
part=0

def readAbiData():
  with open('main.json') as jsonfile:
    abidata = json.load(jsonfile)
    return abidata

def sendTransaction():
   permissionedaddress="0xf9eae0f545c0d5b1f1538df4746e46bf2c90d381"
   metadata="test"
   account = web3.eth.accounts[0]
   walletnonce = web3.eth.getTransactionCount(account)
   contract = web3.eth.contract(address=Web3.toChecksumAddress(maincontractaddress),abi=readAbiData())
   #txpool.status gets general txpool not with account specific
   #txpool.inspect & txpool.content gets for particular account
   threadsarray=[]
   q=Queue()
   totaltxs=20000
   howManyLeft=20000
   batchSize=int(totaltxs/4)
   iter=0

   def worker():
    while True:
            item = q.get()
            threadfunction(item,contract)
            q.task_done()
   #num_worker_threads
   #10,20
   starttime=int(round(time.time()))
   for i in range(1):
         t = Thread(target=worker)
         t.daemon = True
         t.start()
    #print ("%d worker threads created." % 100)
   while howManyLeft>0:
    for index in range((iter*batchSize),(batchSize*(iter+1))):
        q.put (index)
    #print ("%d items queued." % 10)

    q.join()
    howManyLeft -= batchSize
    iter=iter+1
    #q.join()
   endtime=int(round(time.time()))
   diff=endtime-starttime
   print(diff)
   print(totaltxs)
   return (totaltxs/diff)

#https://github.com/ethereum/wiki/wiki/JSON-RPC


def threadfunction(increment,contract):
  thirdMap=contract.functions.readThirdMap().call()


def getTransaction():
   txarray=sendTransaction()
   print(txarray)


getTransaction()

