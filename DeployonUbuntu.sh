#!/bin/bash

##get the ID of the current Docker
CONTAINER_ID=$(sudo docker ps -a | grep "suanfa:v6" | awk '{print $1}' | sed -n '1p')

## start nginx
sudo docker exec $CONTAINER_ID /bin/bash -c '/usr/local/nginx/sbin/nginx'

## start mysql
sudo docker exec $CONTAINER_ID /bin/bash -c '/etc/init.d/mysqld start'

## start redis
sudo docker exec $CONTAINER_ID /bin/bash -c '/usr/local/bin/redis-server /usr/local/redis/redis.conf'

## start java
sudo docker exec $CONTAINER_ID /bin/bash -c 'nohup /usr/local/jdk/bin/java -Xms256m -Xmx512m -jar /usr/local/src/suanfa/jiyin-admin.jar > /usr/local/src/suanfa/suanfa.log 2>&1'


