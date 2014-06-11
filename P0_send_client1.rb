require 'amqp'
# P0_send_client1.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exVaildChat = channel.topic("vaildChat", :durable => true)
  EventMachine.add_periodic_timer(1) do
    msg = 'hello client1 ' + Time.now.to_s
    exVaildChat.publish(msg, :routing_key => "chat.client1ID", :persistent => true, :nowait => false)
    puts "[X] Publish: #{msg}"
  end
end
