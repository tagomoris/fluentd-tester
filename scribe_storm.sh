#!/bin/bash

echo "start at " `date`
echo "process: 1"
./scribe_storm.rb worker101.analysis 14631 1800 16 testdata.19.log &

sleep 3600

echo "start at " `date`
echo "process: 2"
./scribe_storm.rb worker101.analysis 14631 1800 16 testdata.20.log &
./scribe_storm.rb worker101.analysis 14632 1800 16 testdata.20.log &

sleep 3600

echo "start at " `date`
echo "process: 3"
./scribe_storm.rb worker101.analysis 14631 1800 16 testdata.21.log &
./scribe_storm.rb worker101.analysis 14632 1800 16 testdata.21.log &
./scribe_storm.rb worker101.analysis 14633 1800 16 testdata.21.log &

sleep 3600

echo "start at " `date`
echo "process: 4"
./scribe_storm.rb worker101.analysis 14631 1800 16 testdata.22.log &
./scribe_storm.rb worker101.analysis 14632 1800 16 testdata.22.log &
./scribe_storm.rb worker101.analysis 14633 1800 16 testdata.22.log &
./scribe_storm.rb worker101.analysis 14634 1800 16 testdata.22.log &

sleep 3600

echo "start at " `date`
echo "process: 4, weak"
./scribe_storm.rb worker101.analysis 14631 1800 20 testdata.23.log &
./scribe_storm.rb worker101.analysis 14632 1800 20 testdata.23.log &
./scribe_storm.rb worker101.analysis 14633 1800 20 testdata.23.log &
./scribe_storm.rb worker101.analysis 14634 1800 20 testdata.23.log &

sleep 3600

echo "start at " `date`
echo "process: 4, strong"
./scribe_storm.rb worker101.analysis 14631 1800 12 testdata.00.log &
./scribe_storm.rb worker101.analysis 14632 1800 12 testdata.00.log &
./scribe_storm.rb worker101.analysis 14633 1800 12 testdata.00.log &
./scribe_storm.rb worker101.analysis 14634 1800 12 testdata.00.log &

echo "start at " `date`
echo "process: 5"
./scribe_storm.rb worker101.analysis 14631 1800 15 testdata.01.log &
./scribe_storm.rb worker101.analysis 14632 1800 15 testdata.01.log &
./scribe_storm.rb worker101.analysis 14633 1800 15 testdata.01.log &
./scribe_storm.rb worker101.analysis 14634 1800 15 testdata.01.log &
./scribe_storm.rb worker101.analysis 14635 1800 15 testdata.01.log &

sleep 3600
