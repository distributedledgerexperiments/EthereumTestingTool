from web3 import Web3,HTTPProvider
#Add Middleware for POA to transalate request between web3 py and Geth Node
#Ref: https://web3py.readthedocs.io/en/stable/middleware.html#geth-style-proof-of-authority
from web3.middleware import geth_poa_middleware

import json
import time
import csv
import pandas as pd
import numpy as np

#MongoDB
from pymongo import MongoClient,errors

from config import RPCaddress, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS,MONGO_DB_2,MONGO_PORT_2,MONGO_DB_3,MONGO_PORT_3


geth_http = RPCaddress

mongodbhost = MONGO_DB
mongodbport = MONGO_PORT

maincontractaddress = CONTRACT_ADDRESS

web3 = Web3(HTTPProvider(geth_http))
# Add PoA middleware ==> web3.exceptions.ValidationError: The field extraData is 97 bytes, but should be 32
web3.middleware_onion.inject(geth_poa_middleware, layer=0)
def readfirstData():
  mongodb_url=str(MONGO_DB)+":"+str(MONGO_PORT)
  mongodb_url_2=str(MONGO_DB_2)+":"+str(MONGO_PORT_2)
  mongodb_url_3=str(MONGO_DB_3)+":"+str(MONGO_PORT_3)
  mongodburls=[mongodb_url,mongodb_url_2,mongodb_url_3]

  resultsets=[]
  for url in mongodburls:
    print(url)
    try:
     client=MongoClient(host=[str(url)],serverSelectionTimeoutMS=3000,username='guest',password='guest')
     db = client.resultdb
     results = db.results
     errors = db.errors
    except errors.ServerSelectionTimeoutError as err:
     # catch pymongo.errors.ServerSelectionTimeoutError
      print ("pymongo ERROR:", err)
    for result in results.find():
     resultset=[]
     resultset.insert(0,result.get('Transactionid'))
     resultset.insert(1,int(result.get('Start')))
     resultset.insert(2,int(result.get('End')))
     resultset.insert(3,int(result.get('Lapse')))
     resultset.insert(4,int(result.get('Iteration')))
     resultsets.append(resultset)
  
  with open("firstresult.csv","w") as csvfile:
    fieldname=['Transactionid','Start','End','Latency','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    writer.writeheader()

  with open("firstresult.csv","a") as csvfile:
    fieldname=['Transactionid','Start','End','Latency','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    for row in resultsets:
        writer.writerow({'Transactionid':row[0],'Start':row[1],'End':row[2],'Latency':row[3],'Iteration':row[4]})

  
          
  data = pd.read_csv("firstresult.csv",low_memory=False);
  totalresult=[]
  for iteration in range (1,4):
   filterdataiteration = data[data['Iteration']==iteration]
   timestampsorteddata = filterdataiteration.sort_values('Start');
   AverageLatency=filterdataiteration["Latency"].mean()
   Mintxstart = timestampsorteddata.iloc[0].Start
   Maxtxstart = timestampsorteddata.iloc[len(timestampsorteddata)-1].Start
   Mintxend = timestampsorteddata.iloc[0].End
   Maxtxend = timestampsorteddata.iloc[len(timestampsorteddata)-1].End
   Different= Maxtxend - Mintxstart
   txs=NUMBER_OF_TRANSACTIONS
   tps=Different/txs
   result=[] 
   result.insert(0,AverageLatency)
   result.insert(1,tps)
   result.insert(2,iteration)
   totalresult.append(result)
   return totalresult

def getTransaction():
   with open("tertiary.csv","w") as csvfile:
    fieldname=['AverageLatency','TPS','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    writer.writeheader()
   txarray=readfirstData()
   with open("tertiary.csv","a") as csvfile:
    fieldname=['AverageLatency','TPS','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    for row in txarray:
        writer.writerow({'AverageLatency':row[0],'TPS':row[1],'Iteration':row[2]})


getTransaction()

