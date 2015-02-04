### powerstrip is a container

Powerstrip itself is a container.

It can *link* to adapters that are named in the config file.

Running the **powerstrip-debug** container:

```bash
$ docker run -d \
  --name powerstrip \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/powerstrip-demo/adapters.yml:/etc/powerstrip/adapters.yml \
  --link powerstrip-weave:weave \
  --link powerstrip-debug:debug \
  -p 2375:2375 \
  clusterhq/powerstrip
```