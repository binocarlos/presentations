### adapters are containers

The adapters themselves are containers.

The interface is a HTTP endpoint.

Starting the **powerstrip-debug** container:

```bash
$ docker run -d \
  --name powerstrip-debug \
  --expose 80 \
  binocarlos/powerstrip-debug
```