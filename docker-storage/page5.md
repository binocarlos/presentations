### Volumes to the rescue

Docker volumes enable us to write data to the **host** filesystem from inside the container.

```bash
$ docker run -d -v /var/mysql:/data mysql
```