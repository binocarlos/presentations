#### combined extensions

```
$ docker run -d \
  -e "WEAVE_CIDR=10.0.0.1/24" \
  -v /flocker/dataset1:/data \
  myapp
```