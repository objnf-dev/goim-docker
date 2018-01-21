FROM centos:latest
RUN yum install -y git bash go && \
    yum clean all && \
    cd /root && \
	mkdir /root/logs && \
	go get -u github.com/thinkboy/log4go && \
    go get -u github.com/Terry-Mao/goconf && \
    go get -u github.com/gorilla/websocket && \
    go get -u github.com/Shopify/sarama && \
    go get -u github.com/wvanbergen/kazoo-go && \
	git clone https://github.com/Terry-Mao/goim.git && \
	\cp -rf goim /root/go/src/ && \
	mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
    cd /root/go/src/github.com/wvanbergen && \
    git clone https://github.com/wvanbergen/kafka.git && \
	cd /root/go/src/goim/router && \
    go build && \
    mkdir /root/config && \
    \cp -rf router /root/ && \
    \cp -rf router-example.conf /root/config/router.conf && \
    \cp -rf router-log.xml /root/router-log.xml && \
	yum autoremove -y go git && \
	rm -rf /root/go
VOLUME ["/root/config","/root/logs"]
EXPOSE 7270
EXPOSE 7271
EXPOSE 7374
CMD /bin/bash -c "sleep 5;cd /root;./router -c ./config/router.conf 2>&1 >> /root/logs/router.log"
