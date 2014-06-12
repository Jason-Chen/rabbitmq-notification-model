require 'amqp'
# server.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exVaildChat = channel.topic("vaildChat", :durable => true)

  # DB
  channel.queue("chatDB").bind(exVaildChat, :routing_key => "chat.#")

  # client1
  channel.queue("client1Device1Queue").bind(exVaildChat, :routing_key => "chat.client1ID")
  channel.queue("client1Device2Queue").bind(exVaildChat, :routing_key => "chat.client1ID")

  # client2
  channel.queue("client2Device1Queue").bind(exVaildChat, :routing_key => "chat.client2ID")
end
