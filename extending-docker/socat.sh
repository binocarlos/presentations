#!/bin/bash
socat -v UNIX-LISTEN:/tmp/docker.sock,fork UNIX-CONNECT:/var/run/docker.sock