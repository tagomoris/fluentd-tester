#!/bin/bash -x

bundle install --path vendor/bundle
git clone git://github.com/tagomoris/fluent-plugin-test-counter.git || (cd fluent-plugin-test-counter && git pull)
git clone git://github.com/tagomoris/scribe_line scribeline || (cd scribeline && git pull)

mkdir results

### for UTF-8
echo '############################### UTF-8 ###############################'
bundle exec fluentd -c conf/fluentd.utf8.conf 2>&1 &
fluentdpid=$!
sleep 5

python scribeline/misc/scribe_server_dummy.py 11463 > ./results/result.utf8.txt &
scribedpid=$!
sleep 1

cat source/utf8.source.txt | python scribeline/misc/scribe_client_dummy.py -h localhost:11464 UTF8
sleep 3

kill  $fluentdpid
kill  $scribedpid

sleep 5

diff -B source/result_sample.utf8.txt results/result.utf8.txt
utf8result=$?

sleep 1

### for sjis
echo '############################### SHIFT-JIS ###############################'
bundle exec fluentd -c conf/fluentd.sjis.conf 2>&1 &
fluentdpid=$!
sleep 5

python scribeline/misc/scribe_server_dummy.py 12463 > ./results/result.sjis.txt &
scribedpid=$!
sleep 1

cat source/sjis.source.txt | python scribeline/misc/scribe_client_dummy.py -h localhost:12464 SJIS
sleep 3

kill $fluentdpid
kill $scribedpid

sleep 5

diff -B source/result_sample.sjis.txt results/result.sjis.txt
sjisresult=$?

sleep 1

### for eucjp
echo '############################### EUC-JP ###############################'
bundle exec fluentd -c conf/fluentd.eucjp.conf 2>&1 &
fluentdpid=$!
sleep 5

python scribeline/misc/scribe_server_dummy.py 13463 > ./results/result.eucjp.txt &
scribedpid=$!
sleep 1

cat source/eucjp.source.txt | python scribeline/misc/scribe_client_dummy.py -h localhost:13464 EUCJP
sleep 3

kill $fluentdpid
kill $scribedpid

sleep 5

diff -B source/result_sample.eucjp.txt results/result.eucjp.txt
eucjpresult=$?

sleep 1

### for ascii
echo '############################### ASCII ###############################'
bundle exec fluentd -c conf/fluentd.ascii.conf 2>&1 &
fluentdpid=$!
sleep 5

python scribeline/misc/scribe_server_dummy.py 14463 > ./results/result.ascii.txt &
scribedpid=$!
sleep 1

cat source/ascii.source.txt | python scribeline/misc/scribe_client_dummy.py -h localhost:14464 ASCII
sleep 3

kill $fluentdpid
kill $scribedpid

sleep 5

diff -B source/result_sample.ascii.txt results/result.ascii.txt
asciiresult=$?

sleep 1

### for large thrift message (100bytes 10,000 lines)
echo '############################### LARGE DATA ###############################'
[ -f results/result.large.log ] && rm -f results/result.large.log
bundle exec fluentd -c conf/fluentd.size.conf -p fluent-plugin-test-counter/lib/fluent/plugin -o results/result.large.log &
fluentdpid=$!
sleep 5
date
perl -e '$l="a"x100 . "\n"; for($i=0;$i<10000;$i++){print $l;}' | python scribeline/misc/scribe_client_dummy.py -h localhost:1463 LARGE
date
sleep 3
kill $fluentdpid
sleep 5
egrep -q 'test_counter: 201[0-9]{11} 10000$' results/result.large.log
size_large=$?
cat results/result.large.log | grep 'test_counter:'
sleep 1

### for huge thrift message (100bytes 100,000 lines)
echo '############################### HUGE DATA ###############################'
[ -f results/result.huge.log ] && rm -f results/result.huge.log
bundle exec fluentd -c conf/fluentd.size.conf -p fluent-plugin-test-counter/lib/fluent/plugin -o results/result.huge.log &
fluentdpid=$!
sleep 5
date
perl -e '$l="a"x100 . "\n"; for($i=0;$i<100000;$i++){print $l;}' | python scribeline/misc/scribe_client_dummy.py -h localhost:1463 HUGE
date
sleep 3
kill $fluentdpid
sleep 10
egrep -q 'test_counter: 201[0-9]{11} 100000$' results/result.huge.log
size_huge=$?
cat results/result.huge.log | grep 'test_counter:'
sleep 1

### for very huge thrift message (100bytes 1,000,000 lines)
echo '############################### VERY HUGE DATA ###############################'
[ -f results/result.vhuge.log ] && rm -f results/result.vhuge.log
bundle exec fluentd -c conf/fluentd.size.conf -p fluent-plugin-test-counter/lib/fluent/plugin -o results/result.vhuge.log &
fluentdpid=$!
sleep 5
date
perl -e '$l="a"x100 . "\n"; for($i=0;$i<1000000;$i++){print $l;}' | python scribeline/misc/scribe_client_dummy.py -h localhost:1463 HUGE
date
sleep 3
kill $fluentdpid
sleep 10
egrep -q 'test_counter: 201[0-9]{11} 1000000$' results/result.vhuge.log
size_vhuge=$?
cat results/result.vhuge.log | grep 'test_counter:'
sleep 1

echo '############################### RESULT ###############################'
echo "utf8:" $utf8result ", sjis:" $sjisresult ", eucjp:" $eucjpresult ", ascii:" $asciiresult ", large:" $size_large ", huge:" $size_huge ", veryhuge:" $size_vhuge

[ $utf8result -eq 0 ] && [ $sjisresult -eq 0 ] && [ $eucjpresult -eq 0 ] && [ $asciiresult -eq 0 ] && [ $size_large -eq 0 ] && [ $size_huge -eq 0 ] && [ $size_vhuge -eq 0 ] && exit 0

exit 1
