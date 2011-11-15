#!/bin/bash

target_host="rx30.standby"

echo '1000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 50 20 10
sleep 1
kill -HUP $pid
sleep 1

echo '2000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 50 40 10
sleep 1
kill -HUP $pid
sleep 1

echo '4000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 100 40 10
sleep 1
kill -HUP $pid
sleep 1

echo '8000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 100 80 10
sleep 1
kill -HUP $pid
sleep 1

echo '16000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 200 80 10
sleep 1
kill -HUP $pid
sleep 1

echo '32000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 400 80 10
sleep 1
kill -HUP $pid
sleep 1

echo '64000 msg/s'
python scribeline/misc/scribe_server_dummy.py -q 1463 &
pid=$!
ruby scribe_load.rb $target_host 1463 TESTING 100 800 80 10
sleep 1
kill -HUP $pid
sleep 1

