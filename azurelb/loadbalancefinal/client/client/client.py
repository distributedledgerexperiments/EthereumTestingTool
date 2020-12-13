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

#curl localhost:5000/addTransaction/14
oldloadbalanceurl = "http://10.214.222.151:5000/addTransaction/14"
loadbalanceurl = "http://10.214.226.37:8080/addTransaction/14"
#loadbalanceurl = "http://10.214.222.151:5000/addTransaction/14"


from web3._utils.abi import filter_by_name, abi_to_signature
from web3._utils.encoding import pad_hex

#threading
from threading import Thread

#queuing
from queue import Queue
   
def sendTransaction():
   totalresult=[]
   threadsarray=[]
   session = requests.Session()
   retry = Retry(connect=3, backoff_factor=0.5)
   adapter = HTTPAdapter(max_retries=retry)
   session.mount('http://', adapter)
   session.mount('https://', adapter)
   
   q = Queue()
   howManyLeft=10000
   batchSize=1000
   iter=0
   
   def worker():
        while True:
            item = q.get()
            threadfunction(item,totalresult,session)
            q.task_done()
    #num_worker_threads
   for i in range(100):
         t = Thread(target=worker)
         t.daemon = True
         t.start()
    #print ("%d worker threads created." % 100)
   while howManyLeft>0:
    iter=iter+1 
    for i in range((iter*batchSize),(batchSize*(iter+1))):
        q.put (i)
    #print ("%d items queued." % 10)

    q.join()
    howManyLeft -= batchSize 
   return totalresult

#https://github.com/ethereum/wiki/wiki/JSON-RPC


def threadfunction(increment,totalresult,session):
  result=[]
  starttime=int(round(time.time()))

  #normal mode
  #session = requests.Session()
  #response = requests.post(geth_http, json=payload, headers=headers)
  
  #retry mode
  response = session.get(loadbalanceurl)
  #print(response)
  endtime=int(round(time.time()))
  result.insert(0,response)
  result.insert(1,starttime)
  result.insert(2,endtime)
  result.insert(3,endtime-starttime)
  totalresult.append(result)
  return result


def getTransaction():
   with open("client.csv","w") as csvfile:
    fieldname=['Transactionid','Start','End','Lapse']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    writer.writeheader()
    t = time.localtime()
    current_time = time.strftime("%H:%M:%S", t)
    print('Starttime')
    print(current_time)
    txarray=sendTransaction()
    et = time.localtime()
    end_time = time.strftime("%H:%M:%S", et)
    print('Endtime')
    print(end_time)

    for row in txarray:
      writer.writerow({'Transactionid':row[0],'Start':row[1],'End':row[2],'Lapse':row[3]})

getTransaction()

