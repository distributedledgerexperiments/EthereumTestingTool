import pandas as pd
import statistics as st
import csv
import numpy as np

from config import RPCaddress, NUMBER_OF_TRANSACTIONS,MONGO_DB,MONGO_PORT, CONTRACT_ADDRESS, CLIENT_THREADS


totalresult=[];
inputdata = pd.read_csv("primary.csv",low_memory=False);
resultarray=[]
for iteration in range(1,4):
 data = inputdata[inputdata['Iteration']==iteration]
 result = [];
 Total_Transaction_Time=data.iloc[0].MaxTxEnd-data.iloc[0].MinTxStart;
 Totalblocks=len(data);
 sortedblockdata = data.sort_values('BlockNo');
 blockdatalen = len(sortedblockdata);
 sortedblockdatasize = data.sort_values('BlockSize');
 minsortedblockdatasize = sortedblockdatasize.iloc[0].BlockSize
 maxsortedlockdatasize = sortedblockdatasize.iloc[blockdatalen-1].BlockSize
 sortedblockdatagaslimit = data.sort_values('BlockGasLimit');
 minsortedblockdatagaslimit = sortedblockdatagaslimit.iloc[0].BlockGasLimit
 maxsortedlockdatagaslimit = sortedblockdatagaslimit.iloc[blockdatalen-1].BlockGasLimit
 sortedblockdatagasused = data.sort_values('BlockGasUsed');
 minsortedblockdatagasused = sortedblockdatagasused.iloc[0].BlockGasUsed
 maxsortedlockdatagasused = sortedblockdatagasused.iloc[blockdatalen-1].BlockGasUsed
 minsortedblockdatatransactions = sortedblockdatagasused.iloc[0].BlockTransactions
 maxsortedlockdatatransactions = sortedblockdatagasused.iloc[blockdatalen-1].BlockTransactions
 txgasused=sortedblockdatagasused.iloc[blockdatalen-1].TxGasUsed
 #changetimeperiod
 timeperiod=2;
 totaltxs=NUMBER_OF_TRANSACTIONS;
 totaltxpersec=0;
 blocktimeinterval=(sortedblockdata.iloc[len(sortedblockdata)-1].BlockTimeStamp-sortedblockdata.iloc[0].MinTxStart)
 Totalexpectedblocks=blocktimeinterval/timeperiod
 Totaluncleblocks=Totalexpectedblocks-Totalblocks
 if (blocktimeinterval==0):
    totaltxpersec=totaltxs
 else:
    totaltxpersec=totaltxs/blocktimeinterval
 firedtxpersec=0;
 if (blocktimeinterval==0):
    firedtxpersec=totaltxs
 else:
    firedtxpersec=totaltxs/Total_Transaction_Time
 result.insert(0,blockdatalen);
 result.insert(1,minsortedblockdatasize);
 result.insert(2,maxsortedlockdatasize);
 result.insert(3,minsortedblockdatagaslimit);
 result.insert(4,maxsortedlockdatagaslimit);
 result.insert(5,minsortedblockdatagasused);
 result.insert(6,maxsortedlockdatagasused);
 result.insert(7,minsortedblockdatatransactions);
 result.insert(8,maxsortedlockdatatransactions);
 result.insert(9,timeperiod );
 result.insert(10,totaltxs );
 result.insert(11,totaltxpersec);
 result.insert(12,firedtxpersec);
 result.insert(13,Total_Transaction_Time);
 result.insert(14,blocktimeinterval)
 result.insert(15,iteration)
 result.insert(16,sortedblockdata.iloc[0].AverageLatency)
 resultarray.append(result)
with open("tertiary.csv", 'w') as csvfile:
            fieldnames = ['TotalValidblocks', 'Leastblocksize','MaxBlocksize','Leastblockgaslimit','Maxblockgaslimit','Leastblockgasused','Maxblockgasused','Leastblocktransactions','Maxblocktransactions','blocktimeperiod','totaltxs','finaltps','firedtps','totalfiredtime','totalblocktimeinterval','txgasused','TotalUncleblocks','Iteration','Latency']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

            writer.writeheader();
            for result in resultarray:
             writer.writerow({'TotalValidblocks':result[0], 'Leastblocksize':result[1],'MaxBlocksize':result[2],'Leastblockgaslimit':result[3],'Maxblockgaslimit':result[4],'Leastblockgasused':result[5],'Maxblockgasused':result[6],'Leastblocktransactions':result[7],'Maxblocktransactions':result[8],'blocktimeperiod':result[9],'totaltxs':result[10],'finaltps':result[11],'firedtps':result[12],'totalfiredtime':result[13],'totalblocktimeinterval':result[14],'txgasused':txgasused,'TotalUncleblocks':Totaluncleblocks,'Iteration':result[15],'Latency':result[16]})
