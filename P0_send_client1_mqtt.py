import time
from datetime import datetime
import paho.mqtt.client as mqtt

client = mqtt.Client()
client.username_pw_set("test", "test")
client.connect("127.0.0.1")

while(1):
  msg = "Hello client1 " + str(datetime.now())
  client.publish("chat.client1ID", msg)
  print "publish", msg
  time.sleep(1)
