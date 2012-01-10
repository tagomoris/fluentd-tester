#!/usr/bin/env ruby

require 'thrift'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'ruby_extlib/thrift')

require 'fb303_types'
require 'fb303_constants'
require 'facebook_service'
require 'scribe_types'
require 'scribe_constants'
require 'scribe'

(host,port,seconds,rate,testdata) = ARGV
port = port.to_i
seconds = seconds.to_i
rate = rate.to_i

socket = Thrift::Socket.new(host,port)
transport = Thrift::FramedTransport.new(socket)
protocol = Thrift::BinaryProtocol.new(transport, false, false)
client = Scribe::Client.new(protocol)
transport.open

lines = File.readlines(testdata).shuffle
cnt = 1
selected_lines = []
while lines.length > 0
  if cnt % rate == 0
    selected_lines.push(lines.shift)
  else
    lines.shift
  end
  cnt += 1
end
lines_num = selected_lines.length
messages = selected_lines.map{|l| LogEntry.new(:category => 'test', :message => l.force_encoding('ASCII-8BIT'))}
message_num = messages.length

send_times = 0

starts = Time.now.to_i
ends = starts + seconds

puts "selected lines: #{lines_num}, messages: #{message_num}"
puts "start sending: #{Time.now}"

while (now = Time.now.to_i) < ends
  pos = 0
  while pos < message_num
    next_pos = 300 + rand(100)
    client.Log(messages[pos...next_pos])
    puts "sent #{next_pos - pos} messages"
    pos = next_pos
  end
  send_times += 1
  while starts + send_times > Time.now.to_i
    sleep 0.05
  end
end

transport.close

puts "end sending: #{Time.now}"
puts "send 1/#{rate} lines of testdata, #{send_times} times in #{seconds} seconds."
