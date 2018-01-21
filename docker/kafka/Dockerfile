FROM centos:latest
RUN yum install -y wget java-1.8.0-openjdk && \
    yum clean all && \
ENV kafka_ver=2.12
RUN cd /root && \
    wget http://www-us.apache.org/dist/kafka/1.0.0/kafka_$kafka_ver-1.0.0.tgz && \
    tar -xzf kafka_$kafka_ver-1.0.0.tgz && \
    rm -rf kafka_$kafka_ver-1.0.0.tgz
ADD shell /root
EXPOSE 2181
EXPOSE 9092
CMD /bin/bash -c /root/start.sh