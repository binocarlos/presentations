#### you can run servers inside a container - like node, redis etc

 * you run containers using the "docker run" command
 * using a base image, you can pass arguments to the "entrypoint"
 
```
$ docker run myapp foo bar
FOO BAR
```