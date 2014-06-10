#!/usr/bin/env ruby

require "mqtt"

c = MQTT::Client.connect(
  remote_host: "127.0.0.1",
  remote_port: 1883,
  username: "guest",
  password: "guest")

loop do
  m = "Message @ #{Time.now.to_i}"
  c.publish("chat.client1ID", m)
  puts "=> Published #{m}"
  sleep 0.2
end
