### Volumes to the rescue

```bash
$ docker run -d -v /var/mysql:/data mysql
```

We can write data to **/data** and it will persist on the host (at **/var/mysql**).