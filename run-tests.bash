#!/bin/bash -x

bundle install --path vendor/bundle
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

diff source/result_sample.utf8.txt results/result.utf8.txt
utf8result=$?

kill -KILL $fluentdpid
kill -KILL $scribedpid

sleep 5

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

diff source/result_sample.sjis.txt results/result.sjis.txt
sjisresult=$?

kill -KILL $fluentdpid
kill -KILL $scribedpid

sleep 5

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

diff source/result_sample.eucjp.txt results/result.eucjp.txt
eucjpresult=$?

kill -KILL $fluentdpid
kill -KILL $scribedpid

sleep 5

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

diff source/result_sample.utf8.txt results/result.utf8.txt
utf8result=$?

kill -KILL $fluentdpid
kill -KILL $scribedpid

sleep 5

echo '############################### RESULT ###############################'
echo "utf8:" $utf8result ", sjis:" $sjisresult ", eucjp:" $eucjpresult

[ $utf8result -eq 0 ] && [ $sjisresult -eq 0 ] && [ $eucjpresult -eq 0 ] && exit 0

exit 1
