require 'amqp'
# P0_send_client1.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exCheckVaild = channel.fanout("checkVaild")
  EventMachine.add_periodic_timer(1) do
    exCheckVaild.publish('hello client1 ' + Time.now.to_s, :routing_key => "chat.client1ID", :persistent => true, :nowait => false)
  end
end
