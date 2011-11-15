#!/usr/bin/env ruby

require 'thrift'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'ruby_extlib/thrift')

require 'fb303_types'
require 'fb303_constants'
require 'facebook_service'
require 'scribe_types'
require 'scribe_constants'
require 'scribe'

# ruby scribe_load.rb host port category message_size message_num rate hours
p ARGV
(host,port,category,message_size,message_num,rate,minutes) = ARGV
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

$chars = '0123456789 abcdefg hijklmn opqrstu vwxyz __--'
def generate_entries(category,size,num)
  def random_char
    $chars[rand() * $chars.length]
  end
  def generate_message(size)
    (0...size).map{|i| random_char}.join
  end
  (0...num).map{|i| LogEntry.new(:category => category, :message => generate_message(size))}
end
chunk_list = (0...rate).map{|j| generate_entries(category, message_size, message_num)}

results = {
  ResultCode::OK => 0,
  ResultCode::TRY_LATER => 0,
}
last_sent = Time.now
while (last_sent = Time.now) < end_period
  (0...rate).each do |i|
    r = client.Log(chunk_list[i])
    results[r] += chunk_list[i].size
  end
  while (Time.now - last_sent) < 1.000
    sleep 0.05
  end
end

transport.close

puts "OK:#{results[ResultCode::OK]}, TRY_LATER:#{results[ResultCode::TRY_LATER]}"
puts "rate:#{(results[ResultCode::OK] + results[ResultCode::TRY_LATER]) / (minutes * 60.0)}/s"
