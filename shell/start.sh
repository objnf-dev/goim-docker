#!/bin/bash
echo "Start Zookeeper"
cd /root/soft/kafka_$kafka_ver-1.0.0/bin
nohup zookeeper-server-start.sh ../config/zookeeper.properties 2>&1 >> /root/logs/zookeeper.log &
echo "Starting Kafka"
nohup kafka-server-start.sh ../config/server.properties 2>&1 >> /root/logs/kafka.log &
cd /root/soft/router
echo "Starting router"
nohup router -c router.conf 2>&1 >> /root/logs/router.log &
echo "Starting logic"
cd /root/soft/logic
nohup logic -c logic.conf 2>&1 >> /root/logs/logic.log &
echo "Starting comet"
cd /root/soft/comet
nohup comet -c comet.conf 2>&1 >> /root/logs/comet.log &
echo "Starting job"
cd /root/soft/job
nohup job -c job.conf 2>&1 >> /root/logs/job.log &
while true;
do sleep 1;
done;