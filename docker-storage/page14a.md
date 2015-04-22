### Flocker as a Docker extension

Flocker will work as a Docker extension.

```
$ docker run -d /flocker/mysql:/data mysql
```

The Flocker extension will allocate storage for any volume starting with the path **/flocker**