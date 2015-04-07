#### POST /v1.17/containers/create
 
```json
{
    "Env": [],
    "Cmd": [
        "echo",
        "hello"
    ],
    "Image": "ubuntu",
    "Volumes": {},
    "Entrypoint": null,
    "HostConfig": {
        "Binds": null,
        "PortBindings": {},
        "VolumesFrom": null,
        "NetworkMode": "bridge"
    }
}
```

```
{"Id":"a3a93c06439b54bb812ccfd5d4ee3e564d6cbd108811e6af6964834b2b8b992b","Warnings":null}
```