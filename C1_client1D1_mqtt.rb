require 'mqtt'

MQTT::Client.connect('127.0.0.1') do |c|
  c.get('chat.client1ID') do |topic,message|
    puts "#{topic}: #{message}"
  end
end
