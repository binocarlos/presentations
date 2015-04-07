#### running an adapter

 * adapters can be containers
 * by mounting the docker socket - they can speak to docker

```
$ docker run -d --name powerstrip-weave \
    --expose 80 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    binocarlos/powerstrip-weave launch
```