import time
import ssl
from datetime import datetime
import paho.mqtt.client as mqtt

client = mqtt.Client()
client.username_pw_set("test", "test")
client.tls_set(ca_certs="/etc/rabbitmq/ssl/cacert.pem",
    certfile="/home/vagrant/mqtt/rabbitC1.cert.pem",
    keyfile="/home/vagrant/mqtt/rabbitC1.key.pem")
client.connect("rails-dev-box", 1884)

while(1):
  msg = "Hello client1 " + str(datetime.now())
  client.publish("chat.client1ID", msg)
  print "publish", msg
  time.sleep(1)
