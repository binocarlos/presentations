#### running powerstrip

 * powerstrip itself is a container
 * we link the adapter containers to it
 * this means powerstrip can talk to the adapters

```
$ docker run -d --name powerstrip \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/powerstrip-demo/adapters.yml:/etc/powerstrip/adapters.yml \
    --link powerstrip-weave:weave \
    --link powerstrip-flocker:flocker \
    -p 2375:2375 \
    clusterhq/powerstrip
```