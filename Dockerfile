FROM centos:latest
ENV kafka_ver=2.12
RUN yum update -y && \
    yum install -y bash git go wget java-1.7.0-openjdk && \
    yum clean all && \
    cd /root && \
    mkdir src && \
    mkdir soft && \
    cd src && \
    git clone https://github.com/Terry-Mao/goim.git && \
    cd /root/soft && \
    wget http://www-us.apache.org/dist/kafka/1.0.0/kafka_$kafka_ver-1.0.0.tgz && \
    tar -xzf kafka_$kafka_ver-1.0.0.tgz && \
    cd /root/src && \
    go get -u github.com/thinkboy/log4go && \
    go get -u github.com/Terry-Mao/goconf && \
    go get -u github.com/gorilla/websocket && \
    go get -u github.com/Shopify/sarama && \
    go get -u github.com/wvanbergen/kazoo-go && \
    \cp -rf goim /root/go/src/ && \
    mkdir /root/go/src/golang.org && \
    mkdir /root/go/src/golang.org/x && \
    cd /root/go/src/golang.org/x && \
    git clone https://github.com/golang/net.git && \
    cd /root/go/src/github.com/wvanbergen && \
    git clone https://github.com/wvanbergen/kafka.git && \
    cd /root/go/src/goim/router && \
    go build && \
    mkdir /root/soft/router && \
    mkdir /root/config && \
    \cp -rf router /root/soft/router/ && \
    \cp -rf router-example.conf /root/config/router.conf && \
    ln -s /root/config/router.conf /root/soft/router/router.conf && \
    \cp -rf router-log.xml /root/soft/router/router-log.xml && \
    cd /root/go/src/goim/comet && \
    go build && \
    mkdir /root/soft/comet && \
    \cp -rf comet /root/soft/comet/ && \
    \cp -rf comet-example.conf /root/config/comet.conf && \
    ln -s /root/config/comet.conf /root/soft/comet/comet.conf && \
    \cp -rf comet-log.xml /root/soft/comet/comet-log.xml && \
    cd /root/go/src/goim/logic/job && \
    go build && \
    mkdir /root/soft/job && \
    \cp -rf job /root/soft/job/ && \
    \cp -rf job-example.conf /root/config/job.conf && \
    ln -s /root/config/job.conf /root/soft/job/job.conf && \
    \cp -rf job-log.xml /root/soft/job/job-log.xml && \
    cd /root/go/src/goim/logic && \
    go build && \
    mkdir /root/soft/logic && \
    \cp -rf logic /root/soft/logic/ && \
    \cp -rf logic-example.conf /root/config/logic.conf && \
    ln -s /root/config/logic.conf /root/soft/job/logic.conf && \
    \cp -rf logic-log.xml /root/soft/job/logic-log.xml && \
    cd /root/go/src/goim && \
    \cp -rf examples /root/examples && \
    cd /root/examples/javascript && \
    go build main.go && \
    rm -rf main.go && \
    yum autoremove -y git go wget && \
    rm -rf /root/src && \
    rm -rf /root/go && \
    mkdir /root/shell && \
    mkdir /root/logs
CMD /bin/bash -c "while true;do sleep 1;done"