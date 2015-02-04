## notes

The purpose of this presentation:

 * give background on what weave is and show the problems it solves
 * to explain a bit how weave works and how to use it with docker
 * demonstrate the problem with weave wrapping docker cli (demo of waiting for weave)
 * explore how a powerstrip adapter works
 * introduce the powerstrip-weave adapter
 * explain the way that the adapter works (hijack, mount binary etc)
 * do demo of non-waiting reqeust using adapter
 * the importance of using standard docker client
 * fig demo

## slides

#### powerstrip architecture

HTTP proxy lisening on tcp://127.0.0.1:2375

Blocking "hooks" that can modify the request BEFORE and AFTER the docker server.

 * powerstrip diagram

#### docker run
The steps of a docker run request:

 * POST /containers/create
 * POST /containers/(id)/start

#### pre hooks

Pre hooks are useful for modifiying requests BEFORE they hit the docker server.

Examples:

 * injecting env variables from etcd or consul
 * blocking requests based on some kind of auth

#### post hooks

Post hooks are useful for triggering behaviour AFTER the docker server has processed a request.

Examples:

 * registering network endpoints with service discovery systems
 * triggering tools that need the id of a running container (like weave)

#### adapters.yml

An example of an `adapters.yml` that pipes debug -> weave -> debug

```yaml
version: 1
endpoints:
  "POST /*/containers/create":
    pre: [debug, weave, debug]
  "POST /*/containers/*/start":
    post: [debug, weave, debug]
adapters:
  debug: http://debug/extension
  weave: http://weave/extension
```

#### adapters are containers
The adapters themselves are containers that expose a HTTP endpoint.

Here is the command to run the **powerstrip-debug** container:

```bash
$ docker run -d \
  --name powerstrip-debug \
  --expose 80 \
  binocarlos/powerstrip-debug
```

#### powerstrip is a container
Powerstrip itself is a container.

It can *link* to adapters that are named in the config file.

Here is the command to run the **powerstrip-debug** container:

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

#### weave

weave is a networking tool for docker.

#### multi-host networking

Networking containers across multiple hosts is hard.

 * messy cables

#### docker port mapping

Mapping ports is hard and an extra layer of complexity.

Everyone web server wants port 80.

 * rugby scrum image

#### virtual overlay network

To solve these problems, weave creates a "virtual overlay network".

 * weave virtual-network image

#### IP per container

This means each container gets it own IP address!

This is much neater than port mapping - everything of all shapes an sizes can co-exist on the same host.

 * neat and tidy image

#### Layer 2 networking

Weave operates at layer 2 - it uses MAC addresses to route traffic.

 * ISO layer image

#### portable IP addresses

Because it operates at layer 2 - an IP address can follow a container to another machine.

This is like moving house by actually moving your house.

 * house-move image

#### weave run

To start a container that is connected to a weave IP - you use the `weave run` command

 * ps-weave image

#### weave wraps docker

The problem is that weave "wraps" the docker CLI.

 * cling film wrap image

#### connection delay

This means there is a short time between the container starting and the networking being connected.

This can cause some problems with some containers.

 * mind gap image

#### weave run demo

Run the demo of normal weave run

```bash
$ ./example/example.sh weaverun
```

#### powerstrip adapter
To solve this problem - we need a powerstrip adapter!

An adapter that makes a container wait until the weave network is connected before the entrypoint is run is what we need.

 * lightbulb

#### wait-for-weave
Small golang binary that will block until weave network is connected.

 * red traffic light

Will run command line arguments once weave network connects.

https://github.com/binocarlos/wait-for-weave

#### hijack entrypoint
The only way to do this is to "hijack" the entrypoint of a container and change it to wait-for-weave.

 * hijack

#### example

```bash
$ docker run myimage hello
```

 * image entrypoint = echo
 * container arguments = hello

Entrypoint of image `myimage` is `echo`

 * final entrypoint = wait-for-weave
 * final arguments = echo hello

#### add volume
If the entrypoint now points to wait-for-weave - the container needs access that binary somehow.

To do this we mount a volume that gives access to wait-for-weave.

#### pre-hook
This all comes together in a powerstrip-weave PRE-HOOK for requests to:

```
POST /v1.16/containers/create
```

 * show adapter create image

#### post-hook - /containers/start
For weave to connect an IP, it needs a container to be running and will use the container ID to bind a network address.

We also need to know what IP address should be allocated to the container.

This exists in the `WEAVE_CIDR` environment variable.

#### access container ENV
To access the container environment variables we ask docker for the container JSON from the start hook.

#### weave attach $IP $CONTAINER
Once we have the container ID, weave IP and the container is running - we can call `weave attach $IP $CONTAINERID` and it will allocate the IP to the container.

 * show adapter start image

#### weave attach triggers wait-for-weave
As soon as wait-for-weave sees the IP assigned to the container - the original entrypoint is run!

 * green light

#### powerstrip-weave run demo
Run the demo of the request going via the adapter.

```bash
$ ./example/example.sh ps-debug
$ ./example/example.sh ps-weave
$ ./example/example.sh ps
$ ./example/example.sh ps-weaverun
$ docker logs powerstrip-debug
```

#### vanilla docker
Because powerstrip allows the vanilla docker client to communicate with adapters, it means the whole world of orchestration tools can be used.

 * vanilla

#### fig
Fig is an orchestration tool that can manage multiple containers.

 * figs

#### fig.yml - with links
It does this by using a yaml configuration file.

Here is a fig stack with 2 services - a front end web server and a backend api server.

The web-server speaks to the backend api server using the link.

```yaml
api:
  build: api
  command: node /srv/app/index.js
  environment:
   - REMOTE_VALUE=oranges
server:
  build: server
  command: node /srv/app/index.js
  links:
   - api
  ports:
   - "8082:80"

```

#### fig.yml - with weave
Lets change the link to use weave IP addresses instead.

Basically we are triggering powerstrip adapters from a fig.yml!

```yaml
api:
  build: api
  command: node /srv/app/index.js
  environment:
   - WEAVE_CIDR=10.255.0.10/8
   - REMOTE_VALUE=oranges
server:
  build: server
  command: node /srv/app/index.js
  ports:
   - "8082:80"
  environment:
   - WEAVE_CIDR=10.255.0.11/8
   - API_IP=10.255.0.10

```

#### fig run demo
Run the demo of the fig stack using weave env.

```bash
$ cd fig-example
$ cat fig.yml
$ fig build
$ DOCKER_HOST=tcp://127.0.0.1:2375 fig up &
$ curl -L http://127.0.0.1:8082
```