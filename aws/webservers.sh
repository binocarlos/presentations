#!/usr/bin/env bash
baseport=8000
for i in `seq 1 50`;
do
    port=`expr $baseport + $i`
    echo $port
    docker run -p $port:80 -e SERVER_COUNT=$i -d binocarlos/webserver-ubuntu
done
for i in `seq 51 100`;
do
    port=`expr $baseport + $i`
    echo $port
    docker run -p $port:80 -e SERVER_COUNT=$i -d binocarlos/webserver-centos
done