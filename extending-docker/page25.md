#### Docker runs as a daemon on a linux host

```
$ docker -d -H unix:///var/run/docker.sock -s aufs
```