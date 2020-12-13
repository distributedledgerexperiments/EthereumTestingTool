from web3 import Web3,HTTPProvider
#CHECK ULIMIT
#e.g: ulimit -n 10000
import json
import time
import csv

#requests library
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry


from config import RPCaddress_http, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS

geth_http = RPCaddress_http

mongodbhost = MONGO_DB
mongodbport = MONGO_PORT

maincontractaddress = CONTRACT_ADDRESS

mongodb_url=str(MONGO_DB)+":"+str(MONGO_PORT)
mongodburls=[mongodb_url]

web3 = Web3(HTTPProvider(geth_http))
from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#MongoDB
from pymongo import MongoClient,errors

#threading
from threading import Thread

#queuing
from queue import Queue

import sys

iteration_value=1


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
   txpoolpending = web3.geth.txpool.inspect().get('pending').get(account)
   pendinglist=0
   if(txpoolpending==None):
    pendinglist=0
   else:
    pendinglist=len(txpoolpending)
   totalnonce=0
   if(pendinglist!=0):
    totalnonce=(walletnonce+pendinglist)
   else:
    totalnonce=walletnonce

   totalresult=[]
   gashex = web3.toHex(5000000)
   gaspricehex = web3.toHex(0)
   threadsarray=[]
   session = requests.Session()
   retry = Retry(connect=3, backoff_factor=0.5)
   adapter = HTTPAdapter(max_retries=retry)
   session.mount('http://', adapter)
   session.mount('https://', adapter)
   
   q = Queue()
   howManyLeft=1
   batchSize=1
   iter=0
    
   def worker():
        while True:
            item = q.get()
            threadfunction(item,contract,totalnonce,gashex,gaspricehex,totalresult,session)
            q.task_done()
   #num_worker_threads
   for i in range(1):
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
  addcounter=contract.functions.readAdd().call()
  print('addcounter:')
  print(addcounter)
  firstmap_firstcounter= contract.functions.firstmap_firstcounter().call()
  print('firstmap_firstcounter:')
  print(firstmap_firstcounter)
  firstMap=contract.functions.readFirstMap().call()
  print('firstMap:')
  print(firstMap)
  secondMap=contract.functions.readSecondMap().call()
  print('secondMap:')
  print(secondMap)
  thirdMap=contract.functions.readThirdMap().call()
  print('thirdMap:')
  print(thirdMap)



  #normal mode
  #session = requests.Session()
  #response = requests.post(geth_http, json=payload, headers=headers)
  
  #retry mode
  endtime=int(round(time.time()))
  result.insert(0,thirdMap)
  result.insert(1,starttime)
  result.insert(2,endtime)
  result.insert(3,endtime-starttime)
  totalresult.append(result)
  return result


def getTransaction():
    txarray=sendTransaction()


getTransaction()

