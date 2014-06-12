import time
from datetime import datetime
import paho.mqtt.publish as publish
while(1):
  msg = "Hello client1 " + str(datetime.now())
  publish.single("chat.client1ID", msg, hostname="127.0.0.1")
  print "publish", msg
  time.sleep(0.2)
