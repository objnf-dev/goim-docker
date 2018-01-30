#!/bin/sh
echo "Stoping Proxy"
killall -9 httpx-static
echo "Stoping job"
killall -9 job
echo "Stoping comet"
killall -9 comet
echo "Stoping logic"
killall -9 logic
echo "Stoping router"
killall -9 router
echo "Stoping Zookeeper and Kafka"
killall -9 java
echo "Done"
exit