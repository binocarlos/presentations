### docker run

The steps of a (simple) docker run request:

```bash
$ docker run ubuntu echo hello
```

 * `POST /containers/create`
 * `POST /containers/(id)/start`