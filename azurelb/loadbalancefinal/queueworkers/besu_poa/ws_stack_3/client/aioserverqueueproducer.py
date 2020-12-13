
# Rabbit Mq
import pika

import asyncio
from aiohttp import web
import sys

rabbithost=str(sys.argv[1])
#'172.25.0.102'
rabbitport='5672'

credentials = pika.PlainCredentials('guest', 'guest')
connection = pika.BlockingConnection(pika.ConnectionParameters(rabbithost,rabbitport,'/',credentials))
channel = connection.channel()
channel.queue_declare(queue='transactionqueue',durable=True)
channel.confirm_delivery()


async def rootResponse(request):
 return web.Response(text='Root It Works')

async def addTransaction(request):
  mileage = request.match_info.get('mileage')
  try:
    channel.basic_publish(exchange='',routing_key='transactionqueue',body=mileage,properties=pika.BasicProperties(delivery_mode=2),mandatory=True)
  except:
    connection = pika.BlockingConnection(pika.ConnectionParameters(rabbithost,rabbitport,'/',credentials))
    channel = connection.channel()
    channel.queue_declare(queue='transactionqueue',durable=True)
    channel.confirm_delivery()
    channel.basic_publish(exchange='',routing_key='transactionqueue',body=mileage,properties=pika.BasicProperties(delivery_mode=2),mandatory=True)
  return web.Response(text='transacted succesfully')
 

app = web.Application()
app.add_routes([web.get('/', rootResponse),web.get('/{mileage}', rootResponse),web.get("/addTransaction/{mileage}", addTransaction)])
if __name__ == '__main__':
    web.run_app(app,port=9090)

