### powerstrip-flocker

Adapter that can mount flocker volumes to containers when the volume starts with `/flocker`

```bash
$ docker run \
    -v /flocker/data:/data \
    mycontainer
```

https://github.com/clusterhq/powerstrip-flocker