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
   #print(results.count_documents({}))
   #{'_id': ObjectId('5ee8bdaca4735d23d7da8e65'), 
   #'Transactionid': '0x35e87f6be157b4870fa207f236af86c002cfd8de9a42a62e395fdf36417ee2d2', 
   #'Start': '1592311212', 'End': '1592311212', 'Node': 'Node1', 'Count': '2', 'host': '10.214.226.36', 'Worker': 'A'}

   #que=results.find({ "Count": { "$gt": 116893 , "$lt": 136894 } })
   #print(que.count())
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
   #gettransactiondetails
   #print(iteration)
   transactiondata=web3.eth.getTransactionReceipt(timestampsorteddata.iloc[0].Transactionid)
   startblocknumber=int(transactiondata.get('blockNumber'))-10
   blocknos=[]
   verifiedtxs =0
   print(len(filterdataiteration))
   while verifiedtxs < len(filterdataiteration):
    blocktxs=int(web3.eth.getBlockTransactionCount(startblocknumber))
    if blocktxs > 0:
     verifiedtxs = verifiedtxs + blocktxs
     blocknos.append(startblocknumber)
    startblocknumber = startblocknumber+1
    #print(verifiedtxs) 
   #totalresult=[]
   for index in blocknos:
    result=[] 
    blockdata=web3.eth.getBlock(index)
    result.insert(0,blockdata.get('timestamp'))
    result.insert(1,blockdata.get('miner'))
    result.insert(2,blockdata.get('difficulty'))
    result.insert(3,blockdata.get('size'))
    result.insert(4,blockdata.get('gasLimit'))
    result.insert(5,blockdata.get('gasUsed'))
    result.insert(6,len(blockdata.get('transactions')))
    result.insert(7,len(blockdata.get('uncles')))
    result.insert(8,Mintxstart)
    result.insert(9,Maxtxstart)
    result.insert(10,Mintxend)
    result.insert(11,Maxtxend)
    result.insert(12,int(blockdata.get('gasUsed')/(len(blockdata.get('transactions')))))
    result.insert(13,blockdata.get('number'))
    result.insert(14,AverageLatency)
    result.insert(15,iteration)
    totalresult.append(result)
  return totalresult

def getTransaction():
   with open("primary.csv","w") as csvfile:
    fieldname=['BlockTimeStamp','BlockMiner','BlockDifficulty','BlockSize','BlockNo','BlockGasLimit','BlockGasUsed','BlockTransactions','BlockUncles','MinTxStart','MaxTxStart','MinTxEnd','MaxTxEnd','TxGasUsed','AverageLatency','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    writer.writeheader()
   txarray=readfirstData()
   with open("primary.csv","a") as csvfile:
    fieldname=['BlockTimeStamp','BlockMiner','BlockDifficulty','BlockSize','BlockNo','BlockGasLimit','BlockGasUsed','BlockTransactions','BlockUncles','MinTxStart','MaxTxStart','MinTxEnd','MaxTxEnd','TxGasUsed','AverageLatency','Iteration']
    writer=csv.DictWriter(csvfile,fieldnames=fieldname)
    for row in txarray:
        writer.writerow({'BlockTimeStamp':row[0],'BlockMiner':row[1],'BlockDifficulty':row[2],'BlockSize':row[3],'BlockNo':row[13],'BlockGasLimit':row[4],'BlockGasUsed':row[5],'BlockTransactions':row[6],'BlockUncles':row[7],'MinTxStart':row[8],'MaxTxStart':row[9],'MinTxEnd':row[10],'MaxTxEnd':row[11],'TxGasUsed':row[12],'AverageLatency':row[14],'Iteration':row[15]})


getTransaction()

