#!/bin/bash

target_host="rx30.standby"

echo 'messages per seconds'
echo ''
date
echo '1000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 50 20 60
sleep 1
echo ''
date
echo '4000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 100 40 60
sleep 1
echo ''
date
echo '11000 msgs/s (10980)'
ruby scribe_load.rb $target_host 1463 TESTING 100 183 60 60
sleep 1
echo ''
date
echo '16000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 200 80 60
sleep 1
echo ''
sleep 1800
# 4.5 hours

echo 'messages per rpc, for 16000 msgs/s'
echo ''
date
echo '50 msgs/rpc * 320 rpc/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 50 320 60
sleep 1
echo ''
date
echo '100 msgs/rpc * 160 rpc/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 100 160 60
sleep 1
echo ''
date
echo '200 msgs/rpc * 80 rpc/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 200 80 60
sleep 1
echo ''
date
echo '400 msgs/rpc * 40 rpc/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 400 40 60
sleep 1
echo ''
date
echo '800 msgs/rpc * 20 rpc/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 800 20 60
sleep 1
echo ''
sleep 1800
# 6.5 hours (+4.5=11)

echo 'throuput(bytes/sec) for 10000 msgs/s'
echo ''
date
echo '50 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 50 200 50 60
sleep 1
echo ''
date
echo '100 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 100 200 50 60
sleep 1
echo ''
date
echo '200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 200 200 50 60
sleep 1
echo ''
date
echo '400 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 400 200 50 60
sleep 1
echo ''
date
echo '800 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 800 200 50 60
sleep 1
echo ''
date
