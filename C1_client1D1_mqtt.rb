require 'mqtt'

MQTT::Client.connect(:remote_host => '127.0.0.1', :client_id => 'client1Device1Queue') do |c|
  c.get('chat.client1ID') do |topic,message|
    puts "#{topic}: #{message}"
  end
end
