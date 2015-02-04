#### example hijack

```bash
$ docker run myimage hello
```

 * image entrypoint = echo
 * container arguments = hello

Entrypoint of image `myimage` is `echo`

 * final entrypoint = wait-for-weave
 * final arguments = echo hello
