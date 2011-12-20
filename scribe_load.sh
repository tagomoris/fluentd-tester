#!/bin/bash

target_host="worker101.analysis"

echo 'throughput(msgs/sec)'
echo ''
date
echo 'target 4000 msg/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 100 40 45
sleep 900

echo ''
date
echo 'target 8000 msg/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 133 60 45
sleep 900

echo ''
date
echo 'target 16000 msg/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 200 80 45
sleep 900

echo ''
date
echo 'target 24000 msg/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 240 100 45
sleep 900

echo 'throughput(Mbps)'
echo ''
date
echo '10000msg/s, 200bytes/msg, 200msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 200 200 50 45
sleep 900

echo ''
date
echo '10000msg/s, 400bytes/msg, 200msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 400 200 50 45
sleep 900

echo ''
date
echo '10000msg/s, 800bytes/msg, 200msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 800 200 50 45
sleep 900

echo ''
date
echo '10000msg/s, 1200bytes/msg, 200msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 1200 200 50 45
sleep 900

echo ''
date
echo '15000msg/s, 200bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 200 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 400bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 400 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 800bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 800 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 1200bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 1200 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 1200bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 1200 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 2400bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 2400 300 50 45
sleep 900

echo ''
date
echo '15000msg/s, 4800bytes/msg, 300msg/call'
ruby scribe_load.rb $target_host 1463 TESTING 2400 300 50 45
sleep 900

# 15 hours
