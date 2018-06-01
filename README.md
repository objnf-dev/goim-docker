# Goim Docker Image 
A [goim](https://github.com/Terry-mao/goim) image on docker.Using CentOS as the base image.

### Usage  
First,pull the image:

```
$ docker pull zhouweitong/goim-docker 
```  
Then create a container using the image:
```
$ docker run -d \
		 -p 1999:1999 \
		 -p 2181:2181 \
		 -p 6971:6971 \
		 -p 6972:6972 \
		 -p 7170:7170 \
		 -p 7171:7171 \
		 -p 7172:7172 \
		 -p 7270:7270 \
		 -p 7271:7271 \
		 -p 7371:7371 \
		 -p 7372:7372 \
		 -p 7373:7373 \
		 -p 7374:7374 \
		 -p 8080:8080 \
		 -p 8090:8090 \
		 -p 8092:8092 \
		 zhouweitong/goim-docker
```   
Or,you can use Docker Compose as well.See `docker-compose.yml`   

### Volume Settings:  
`/root/config` contains the config files for router,logic,comet,job and client.  
`/root/logs` contains the log files for router,logic,comet,job,zookeeper and kafka.  
`/root/soft/example` is the folder of goim examples.  
  
**Container startup failed.Here's the reason and solution:**  
The starting script of the image uses `sleep 5;` statement to keep the startup order of the programs.  
If your computer,for example,cannot start Apache Zookeeper in 5 seconds,will cause the container fail to start.  
To solve the problem,simply run the container in the interactive mode,and then modify the startup script manually. 