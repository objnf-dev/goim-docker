# Define the base image.
FROM centos:latest
# Set environment variables.
# Create dirs.
RUN cd /root && \
    mkdir src && \
    mkdir logs
# Set up the environment.
# Install tools.
RUN yum update -y && \
    yum install -y bash sudo psmisc git go && \
    yum clean all && \
# Clone goim
    cd /root/src && \
    git clone -b v2.0 https://github.com/Terry-Mao/goim.git && \
# Download the dependences.
    cd /root &&\
    mkdir go/src &&\
    cd /root/src && \
    \cp -rf goim /root/go/src/ && \
    cd goim && \
    go mod tidy &&\
# Cleaning up
    yum autoremove -y git go wget
# Volume settings
VOLUME ["/root/logs","/root/config"]
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