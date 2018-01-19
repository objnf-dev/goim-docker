#!/bin/bash
echo "Start Zookeeper"
cd /root/soft/kafka_$kafka_ver-1.0.0
nohup bin/zookeeper-server-start.sh config/zookeeper.properties 2>&1 >> /root/logs/zookeeper.log &
echo "Starting Kafka"
nohup bin/kafka-server-start.sh config/server.properties 2>&1 >> /root/logs/kafka.log &
cd /root/soft
echo "Starting router"
nohup router/router -c router/router.conf 2>&1 >> /root/logs/router.log &
echo "Starting logic"
nohup logic/logic -c logic/logic.conf 2>&1 >> /root/logs/logic.log &
echo "Starting comet"
nohup comet/comet -c comet/comet.conf 2>&1 >> /root/logs/comet.log &
echo "Starting job"
nohup job/job -c job/job.conf 2>&1 >> /root/logs/job.log &
while true;
do sleep 1;
done;