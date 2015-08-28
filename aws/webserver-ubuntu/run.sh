#!/usr/bin/env bash
while true; do { 
    echo -e 'HTTP/1.1 200 OK\r\n';
    echo "Hello! - I am server number ${SERVER_COUNT} running on Ubuntu";
} | nc -l 80; done
