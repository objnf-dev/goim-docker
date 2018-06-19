#!/bin/bash
echo "Starting Zookeeper"
cd /root/soft/kafka_$kafka_ver-1.0.1/bin
nohup ./zookeeper-server-start.sh ../config/zookeeper.properties 2>&1 >> /root/logs/zookeeper.log &
sleep 5
echo "Starting Kafka"
nohup ./kafka-server-start.sh ../config/server.properties 2>&1 >> /root/logs/kafka.log &
sleep 5
echo "Creating Topic"
./kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 24 --topic KafkaPushsTopic
cd /root/soft/router
echo "Starting router"
nohup ./router -c router.conf 2>&1 >> /root/logs/router.log &
sleep 5
echo "Starting logic"
cd /root/soft/logic
nohup ./logic -c logic.conf 2>&1 >> /root/logs/logic.log &
sleep 5
echo "Starting comet"
cd /root/soft/comet
nohup ./comet -c comet.conf 2>&1 >> /root/logs/comet.log &
sleep 5
echo "Starting job"
cd /root/soft/job
nohup sudo ./job -c job.conf 2>&1 >> /root/logs/job.log &
sleep 5
# echo "All Done.Now you can run \" nohup /root/start_job.sh & \" manually in your container."
while true;
do sleep 1;
done;