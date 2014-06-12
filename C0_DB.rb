require 'amqp'
# C0_DB.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # DB
  queue = channel.queue("chatDB")
  queue.subscribe do |header, body|
    puts " [x] #{header.routing_key}:#{body}"
  end
end
