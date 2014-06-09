require 'amqp'
# C3_client2D1.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)
  exCheckTopic = channel.topic("checkTopic", :durable => true, :auto_delete => true)

  # client2 device1
  exClient2Fanout = channel.fanout("client2Fanout")
  exClient2Fanout.bind(exCheckTopic, :routing_key => "chat.client2ID")
  queue = channel.queue("client2Device1Queue", :exclusive => true, :auto_delete => true).bind(exClient2Fanout)
  queue.subscribe do |header, body|
    puts " [x] #{header.routing_key}:#{body}"
  end
end
