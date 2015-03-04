### powerstrip-weave

Adapter that can assign weave IP addresses to containers based on an environment variable.

```bash
$ docker run \
    -e WEAVE_CIDR=10.255.0.1/24 \
    mycontainer
```

https://github.com/binocarlos/powerstrip-weave