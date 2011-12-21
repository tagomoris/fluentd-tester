#!/usr/bin/env ruby

require 'thrift'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'ruby_extlib/thrift')

require 'fb303_types'
require 'fb303_constants'
require 'facebook_service'
require 'scribe_types'
require 'scribe_constants'
require 'scribe'

# ruby scribe_stream.rb host port category_head message_size message_num rate hours
p ARGV
(host,port,category_head,message_size,message_num,rate,minutes) = ARGV
port = port.to_i
message_size = message_size.to_i
message_num = message_num.to_i
rate = rate.to_i
minutes = minutes.to_i

end_period = Time.now + minutes * 60

socket = Thrift::Socket.new(host, port.to_i)
transport = Thrift::FramedTransport.new(socket)
protocol = Thrift::BinaryProtocol.new(transport, false, false)
client = Scribe::Client.new(protocol)
transport.open

results = {
  ResultCode::OK => 0,
  ResultCode::TRY_LATER => 0,
}
last_sent = Time.now

$counter = 0
$category_format = category_head + '%08d'
def generate_category
  $counter += 1
  sprintf($category_format, $counter)
end
categories = (0...rate).map{|i| sprintf(category_format, i)}
message_body = '=' * message_size

while (last_sent = Time.now) < end_period
  (0...rate).each do |i|
    chunk = (0...message_num).map{|i| LogEntry.new(:category => generate_category(), :message => message_body)}
    r = client.Log(chunk)
    results[r] += chunk.size
  end
  while (Time.now - last_sent) < 1.000
    sleep 0.05
  end
end

transport.close

puts "OK:#{results[ResultCode::OK]}, TRY_LATER:#{results[ResultCode::TRY_LATER]}"
puts "rate:#{(results[ResultCode::OK] + results[ResultCode::TRY_LATER]) / (minutes * 60.0)}/s"
