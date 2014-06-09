require 'amqp'
# P1_send_client2.rb
EventMachine.run do
  connection = AMQP.connect(:host => '127.0.0.1')
  channel    = AMQP::Channel.new(connection)

  # Root
  exCheckVaild = channel.fanout("checkVaild")
  EventMachine.add_periodic_timer(1) do
    exCheckVaild.publish('hello client2 ' + Time.now.to_s, :routing_key => "chat.client2ID", :persistent => true, :nowait => false)
  end
end
