#!/bin/bash

target_host="rx30.standby"

echo 'throuput(bytes/sec) for 15000 msgs/s'
echo ''
date
echo '600 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 600 300 50 30
sleep 1
echo ''
date
echo '1200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 1200 300 50 30
sleep 1
echo ''
date
echo '2400 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 2400 300 50 30
sleep 1
echo ''
date
echo '4800 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 4800 300 50 30
sleep 1
echo ''
date
sleep 1800
# 2.5hours

echo 'throuput(bytes/sec) for 20000 msgs/s'
echo ''
date
echo '600 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 600 400 50 30
sleep 1
echo ''
date
echo '1200 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 1200 400 50 30
sleep 1
echo ''
date
echo '2400 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 2400 400 50 30
sleep 1
echo ''
date
echo '4800 bytes/message'
ruby scribe_load.rb $target_host 1463 TESTING 4800 400 50 30
sleep 1
echo ''
date
# 4.5hours
