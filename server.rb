require 'amqp'
# server.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exVaildChat = channel.topic("vaildChat", :durable => true)

  # DB
  channel.queue("ChatDB").bind(exVaildChat, :routing_key => "chat.#")
  
  # client1
  exClient1Fanout = channel.fanout("client1Fanout")
  exClient1Fanout.bind(exVaildChat, :routing_key => "chat.client1ID")
  channel.queue("client1Device1Queue").bind(exClient1Fanout)
  channel.queue("client1Device2Queue").bind(exClient1Fanout)

  # client2
  exClient2Fanout = channel.fanout("client2Fanout")
  exClient2Fanout.bind(exVaildChat, :routing_key => "chat.client2ID")
  channel.queue("client2Device1Queue").bind(exClient2Fanout)
end
