FROM centos:latest
ENV kafka_ver=2.12
RUN yum install -y bash git go wget tar make gcc g++ linux-headers java-1.7.0-openjdk && \
	cd /root && \
	mkdir src && \
	mkdir soft && \
	cd src && \
	git clone https://github.com/Terry-Mao/goim.git && \
	cd /root/soft && \
	wget http://www-us.apache.org/dist/kafka/1.0.0/kafka_$kafka_ver-1.0.0.tgz && \
	tar -xzf kafka_$kafka_ver-1.0.0.tgz && \
	cd /root/src/goim && \
	go get -u github.com/Terry-Mao/goim && \
	mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
	cd /root/go/src/github.com/Terry-Mao/goim/router && \
	go build && \
	mkdir /root/soft/router && \
	mkdir /root/config && \
	\cp -rf router /root/soft/router/ && \
	\cp -rf router-example.conf /root/config/router.conf && \
	ln -s /root/config/router.conf /root/soft/router/router.conf && \
	\cp -rf router_log.xml /root/soft/router/router_log.xml && \
	cd /root/go/src/github.com/Terry-Mao/goim/comet && \
	go build && \
	mkdir /root/soft/comet && \
	\cp -rf comet /root/soft/comet/ && \
	\cp -rf comet-example.conf /root/config/comet.conf && \
	ln -s /root/config/comet.conf /root/soft/comet/comet.conf && \
	\cp -rf comet_log.xml /root/soft/comet/comet_log.xml && \
	cd /root/go/src/github.com/Terry-Mao/goim/logic/job && \
	go build && \
	mkdir /root/soft/job && \
	\cp -rf job /root/soft/job/ && \
	\cp -rf job-example.conf /root/config/job.conf && \
	ln -s /root/config/job.conf /root/soft/job/job.conf && \
	\cp -rf job_log.xml /root/soft/job/job_log.xml && \
	cd /root/go/src/github.com/Terry-Mao/goim/logic && \
	go build && \
	mkdir /root/soft/logic && \
	\cp -rf logic /root/soft/logic/ && \
	\cp -rf logic-example.conf /root/config/logic.conf && \
	ln -s /root/config/logic.conf /root/soft/job/logic.conf && \
	\cp -rf logic_log.xml /root/soft/job/logic_log.xml && \
	yum autoremove -y git go wget tar make gcc g++ kernel-headers && \
	rm -rf /root/src && \
	rm -rf /root/go && \
	mkdir /root/shell && \
	mkdir /root/logs
CMD /bin/bash -c "while true;do sleep 1;done"