#!/bin/bash

target_host="rx30.standby"

echo 'messages per seconds'
echo ''
date
echo '4000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 100 40 60
sleep 1
echo ''
date
echo '8000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 133 60 60
sleep 1
echo ''
date
echo '16000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 200 80 60
sleep 1
echo ''
echo '24000 msgs/s'
ruby scribe_load.rb $target_host 1463 TESTING 100 240 100 60
sleep 1
echo ''
sleep 1800
# 4.5 hours

echo 'throuput(bytes/sec) for 10000 msgs/s'
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
echo '1200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 1200 200 50 60
sleep 1
echo ''
date
sleep 1800
# 4.5 hours (9hours)

echo 'throuput(bytes/sec) for 15000 msgs/s'
echo ''
date
echo '200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 200 300 50 60
sleep 1
echo ''
date
echo '400 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 400 300 50 60
sleep 1
echo ''
date
echo '800 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 800 300 50 60
sleep 1
echo ''
date
echo '1200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 1200 300 50 60
sleep 1
echo ''
date
# 13 hours