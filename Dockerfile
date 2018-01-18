FROM centos:latest
ENV zoo_ver=3.4.11
RUN yum install -y bash && \
    yum install -y git go wget tar make gcc gcc-c++ && \
	yum clean all && \
	cd /root && \
	mkdir src && \
	mkdir soft && \
	cd src && \
	git clone https://github.com/Terry-Mao/gopush-cluster.git && \
	cd /root/soft && \
	wget http://www-us.apache.org/dist/zookeeper/zookeeper-$zoo_ver/zookeeper-$zoo_ver.tar.gz && \
	tar -xzf zookeeper-$zoo_ver.tar.gz -C ./ && \
	\cp -rf /root/soft/zookeeper-$zoo_ver/conf/zoo_sample.cfg /root/soft/zookeeper-$zoo_ver/conf/zoo.cfg && \
	rm -rf zookeeper-$zoo_ver.tar.gz && \
	wget http://download.redis.io/releases/redis-stable.tar.gz && \
	tar -xzf redis-stable.tar.gz && \
	cd redis-stable && \
	make -j4 && \
	find . -name '*.c' -type f -exec rm -rf {} \; && \
	find . -name '*.o' -type f -exec rm -rf {} \; && \
	find . -name '*.h' -type f -exec rm -rf {} \; && \
	find . -name '*.cpp' -type f -exec rm -rf {} \; && \
	find . -name '*.hpp' -type f -exec rm -rf {} \; && \
	find . -type d -empty -delete && \
	cd /root/src/gopush-cluster && \
	./dependencies.sh && \
	mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
	cd /root/go/src/github.com/Terry-Mao/gopush-cluster/message && \
	go build && \
	mkdir /root/soft/message && \
	mkdir /root/config && \
	\cp -rf message /root/soft/message/ && \
	\cp -rf message-example.conf /root/config/message.conf && \
	ln -s /root/config/message.conf /root/soft/message/message.conf && \
	\cp -rf log.xml /root/soft/message/message_log.xml && \
	cd /root/go/src/github.com/Terry-Mao/gopush-cluster/comet && \
	go build && \
	mkdir /root/soft/comet && \
	\cp -rf comet /root/soft/comet/ && \
	\cp -rf comet-example.conf /root/config/comet.conf && \
	ln -s /root/config/comet.conf /root/soft/comet/comet.conf && \
	\cp -rf log.xml /root/soft/comet/comet_log.xml && \
	cd /root/go/src/github.com/Terry-Mao/gopush-cluster/web && \
	go build && \
	mkdir /root/soft/web && \
	\cp -rf web /root/soft/web/ && \
	\cp -rf web-example.conf /root/config/web.conf && \
	ln -s /root/config/web.conf /root/soft/web/web.conf && \
	\cp -rf log.xml /root/soft/web/web_log.xml && \
	yum autoremove -y git go wget tar make gcc gcc-c++ kernel-headers && \
	rm -rf /root/src && \
	rm -rf /root/go && \
	mkdir /root/shell && \
	mkdir /root/logs
CMD /bin/bash -c "while true;do sleep 1;done"