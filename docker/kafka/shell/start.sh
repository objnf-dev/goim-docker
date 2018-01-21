#!/bin/bash
cd /root/kafka_$kafka_ver-1.0.0/bin
nohup ./zookeeper-server-start.sh ../config/zookeeper.properties 2>&1 >> /root/logs/zookeeper.log &
sleep 5
nohup ./kafka-server-start.sh ../config/server.properties 2>&1 >> /root/logs/kafka.log &
while true;
do sleep 10;
done;