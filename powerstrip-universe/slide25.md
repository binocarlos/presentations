### Mount a volume

Volumes mean the data is seperated from the process manager.  This means the data is persisted to a single host:

```
$ docker run -v /srv/data:/data mydatabaseimage
```