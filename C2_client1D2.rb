require 'amqp'
# C2_client1D2.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)
  exCheckTopic = channel.topic("checkTopic", :durable => true, :auto_delete => true)

  # client1 device2
  exClient1Fanout = channel.fanout("client1Fanout")
  exClient1Fanout.bind(exCheckTopic, :routing_key => "chat.client1ID")
  queue = channel.queue("client1Device2Queue", :exclusive => true, :auto_delete => true).bind(exClient1Fanout)
  queue.subscribe do |header, body|
    puts " [x] #{header.routing_key}:#{body}"
  end
end
