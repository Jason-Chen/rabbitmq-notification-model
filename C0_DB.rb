require 'amqp'
# C0_DB.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exCheckVaild = channel.fanout("checkVaild")

  # ChatTopic
  exCheckTopic = channel.topic("checkTopic", :durable => true, :auto_delete => true)
  exCheckTopic.bind(exCheckVaild)

  # DB
  queue = channel.queue("chatDBQueue", :exclusive => true, :auto_delete => true).bind(exCheckVaild)
  queue.subscribe do |header, body|
    puts " [x] #{header.routing_key}:#{body}"
  end
end
