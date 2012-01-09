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
messages = []
while selected_lines.length > 0
  messages.push(LogEntry.new(:category => 'test', :message => selected_lines.shift(25).join()))
end
message_num = messages.length

send_times = 0

starts = Time.now.to_i
ends = starts + seconds

while (now = Time.now.to_i) < ends
  pos = 0
  while pos < message_num
    next_pos = 50 + rand(50)
    client.Log(messages[pos...next_pos])
    pos = next_pos
  end
  send_times += 1
  while starts + send_times > Time.now.to_i
    sleep 0.05
  end
end

transport.close

puts "send 1/#{rate} lines of testdata, #{send_times} times in #{seconds} seconds."
