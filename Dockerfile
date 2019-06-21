# Define the base image.
FROM centos:7.4.1708
# Set environment variables.
ENV kafka_rel=2.2.1
ENV kafka_ver=2.12
ENV golang_url=https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
ENV golang_name=go1.12.6.linux-amd64.tar.gz
# Create dirs.
RUN cd /root && \
    mkdir src && \
    mkdir soft && \
    mkdir shell && \
    mkdir logs && \
    mkdir /root/soft/example
# Add files
ADD shell /root/shell
ADD example /root/soft/example
# Set up the environment.
# Install tools.
RUN yum install -y bash sudo psmisc git wget gcc gcc-c++ java-1.8.0-openjdk tcpdump && \
    yum clean all && \
# Clone goim
    cd /root/src && \
    git clone -b master https://github.com/zhouweitong3/goim.git && \
# Download&Install Apache Kafka
    cd /root/soft && \
    wget http://www-us.apache.org/dist/kafka/$kafka_rel/kafka_$kafka_ver-$kafka_rel.tgz && \
    tar -xzvf kafka_$kafka_ver-$kafka_rel.tgz && \
    rm -rf kafka_$kafka_ver-$kafka_rel.tgz && \
    cd /root/soft/kafka_$kafka_ver-$kafka_rel && \
    mkdir /root/config && \
    mv ./config/zookeeper.properties /root/config/ && \
    ln -s /root/config/zookeeper.properties ./config/zookeeper.properties && \
    mv ./config/server.properties /root/config/ && \
    ln -s /root/config/server.properties ./config/server.properties && \
# Download&Install golang
    cd /root/soft && \
    wget $golang_url && \
    tar -C /usr/local -xzvf $golang_name && \
    export PATH=$PATH:/usr/local/go/bin && \
    export GOPATH=$HOME/go && \
    source ~/.bash_profile && \
# Download the dependences.
    cd /root/src && \
    go get -u github.com/thinkboy/log4go && \
    go get -u github.com/Terry-Mao/goconf && \
    go get -u github.com/gorilla/websocket && \
    cd /root/go/src/github.com/gorilla/websocket && \
    git checkout 6656ddce919367f4c4090b0f89a45854d26da020 && \
    cd /root/src && \
    go get -u github.com/Shopify/sarama && \
    go get -u github.com/wvanbergen/kazoo-go && \
    \cp -rf goim /root/go/src/ && \
    # cd /root/go/src/golang.org/x && \
    # git clone https://github.com/golang/net.git && \
    cd /root/go/src/github.com/wvanbergen && \
    git clone https://github.com/wvanbergen/kafka.git && \
# Start compiling
# Building router
    cd /root/go/src/goim/router && \
    go build && \
    mkdir /root/soft/router && \
    \cp -rf router /root/soft/router/ && \
    \cp -rf router-example.conf /root/config/router.conf && \
    ln -s /root/config/router.conf /root/soft/router/router.conf && \
    \cp -rf router-log.xml /root/soft/router/router-log.xml && \
# Building comet
    cd /root/go/src/goim/comet && \
    go build && \
    mkdir /root/soft/comet && \
    \cp -rf comet /root/soft/comet/ && \
    \cp -rf comet-example.conf /root/config/comet.conf && \
    ln -s /root/config/comet.conf /root/soft/comet/comet.conf && \
    \cp -rf comet-log.xml /root/soft/comet/comet-log.xml && \
# Building job
    cd /root/go/src/goim/logic/job && \
    go build && \
    mkdir /root/soft/job && \
    \cp -rf job /root/soft/job/ && \
    \cp -rf job-example.conf /root/config/job.conf && \
    ln -s /root/config/job.conf /root/soft/job/job.conf && \
    \cp -rf job-log.xml /root/soft/job/job-log.xml && \
# Building logic
    cd /root/go/src/goim/logic && \
    go build && \
    mkdir /root/soft/logic && \
    \cp -rf logic /root/soft/logic/ && \
    \cp -rf logic-example.conf /root/config/logic.conf && \
    ln -s /root/config/logic.conf /root/soft/logic/logic.conf && \
    \cp -rf logic-log.xml /root/soft/logic/logic-log.xml && \
# Building client
    cd /root/go/src/goim/comet/client && \
    go build && \
    mkdir /root/soft/client && \
    \cp -rf client /root/soft/client/ && \
    \cp -rf client-example.conf /root/config/client.conf && \
    ln -s /root/config/client.conf /root/soft/client/client.conf && \
    \cp -rf log.xml /root/soft/client/log.xml && \
# Building example&benchmark
    cd /root/go/src/goim && \
    \cp -rf examples /root/soft && \
    \cp -rf benchmark /root/soft && \
    cd /root/soft/examples/javascript && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/benchmark/client && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/benchmark/multi_push && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/benchmark/push && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/benchmark/push_room && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/benchmark/push_rooms && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/soft/example && \
    go build main.go && \
    rm -rf main.go && \
    cd /root/src && \
# Cleaning up
    yum autoremove -y git go wget && \
    rm -rf /root/src && \
    rm -rf /root/go && \
# Permission setting up
    chmod -R 777 /root/shell && \
    ln -s /root/shell/start.sh /root/start.sh && \
    ln -s /root/shell/stop.sh /root/stop.sh
# Volume settings
VOLUME ["/root/logs","/root/config","/root/soft/example"]
# Port settings
EXPOSE 1999
EXPOSE 2181
EXPOSE 6971
EXPOSE 6972
EXPOSE 7170
EXPOSE 7171
EXPOSE 7172
EXPOSE 7270
EXPOSE 7271
EXPOSE 7371
EXPOSE 7372
EXPOSE 7373
EXPOSE 7374
EXPOSE 8080
EXPOSE 8090
EXPOSE 8092
# Startup command
CMD /bin/bash -c /root/start.sh
