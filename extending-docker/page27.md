#### example of docker run
 
```
$ socat -v UNIX-LISTEN:/tmp/docker.sock,fork UNIX-CONNECT:/var/run/docker.sock
```

```
$ DOCKER_HOST=unix:///tmp/docker.sock docker run ubuntu echo hello
```