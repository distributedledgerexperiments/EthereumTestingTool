
# Rabbit Mq
import pika
import uuid

import asyncio
from aiohttp import web
import itertools

rabbithost='localhost'
rabbitport='5672'


corrids=[]
#response=''
#copyresponse='' 

#def on_response(ch, method, props, body):
        #if props.correlation_id in corrids :
            #corrids.remove(props.correlation_id)
            #response = body
            #web.Response(text=str(response))
            #print(response)

#def responseobtained():
    #if response !='':
        #return True
    #else:
        #return False

async def rootResponse(request):
 return web.Response(text='Root It Works')

#def processTransaction(mileage):
 #mileage = request.match_info.get('mileage')
 #print(mileage)
 #adminserverofrabbit @ http://10.214.222.151:15672/
 #replyqueuedeclare=channel.queue_declare(queue='',exclusive=True)
 #replyqueue=replyqueuedeclare.method.queue
 #channel.basic_consume(queue=replyqueue,on_message_callback=on_response,auto_ack=True)
 #corrid = str(uuid.uuid4())
 #corrids.append(corrid)
 #channel.basic_publish(exchange='',routing_key='transactionqueue',body=mileage,properties=pika.BasicProperties(reply_to=replyqueue,correlation_id=corrid))
 
 #while True:
   #connection.process_data_events()
   #if responseobtained:
       #return
 
 #return web.Response(text='transacted succesfully')
 #copyresponse = response
 #response=''
 #print(response)
 
 #print(corrids)
 #print(str(copyresponse))

async def addTransaction(request):
  mileage = request.match_info.get('mileage')
  credentials = pika.PlainCredentials('guest', 'guest')
  connection = pika.BlockingConnection(pika.ConnectionParameters(rabbithost,rabbitport,'/',credentials))
  channel = connection.channel()
  channel.queue_declare(queue='transactionqueue',durable=True)
  channel.basic_publish(exchange='',routing_key='transactionqueue',body=mileage,properties=pika.BasicProperties(delivery_mode=2))
  return web.Response(text='transacted succesfully')
 

app = web.Application()
app.add_routes([web.get('/', rootResponse),web.get('/{mileage}', addTransaction),web.get("/addTransaction/{mileage}", addTransaction)])
#app.router.add_route("GET","/addTransaction/{mileage}",addTransaction)
if __name__ == '__main__':
    web.run_app(app,port=9090)

