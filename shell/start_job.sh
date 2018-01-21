#!/bin/sh
cd /root/soft/job
nohup ./job -c job.conf 2>&1 >> /root/logs/job.log &
exit