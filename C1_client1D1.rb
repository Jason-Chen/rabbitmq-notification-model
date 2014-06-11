require 'amqp'
# C1_client1.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # client1 device1
  queue = channel.queue("client1Device1Queue")
  queue.subscribe do |header, body|
    puts " [x] #{header.routing_key}:#{body}"
  end
end
