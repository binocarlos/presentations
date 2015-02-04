#### fig demo

```bash
$ cd fig-example
$ cat fig.yml
$ fig build
$ DOCKER_HOST=tcp://127.0.0.1:2375 fig up &
$ curl -L http://127.0.0.1:8082
```