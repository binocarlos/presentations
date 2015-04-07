# extending docker with powerstrip

 * docker is a container runtime

img:shipping containers

 * containers use some features of the linux kernel
    * cgroups allows limitation & prioritization of CPU, memory etc
    * namespaces isolate the process tree, networking, user ids and file systemss
    * this is sounding a bit like a Virtual Machine?

 * VMs (VMWare, Virtualbox etc) are "hardware virtualisation"
    * each VM has its own kernel
    * VMs can have different Operating Systems (Windows & Linux)
    * all processes share network, file system, user ids and process tree
    * VMs are chunky and slow (~20 seconds startup)

 * Containers (Docker, rkt) are "operating system virtualisation"
    * each container shares the same kernel as the host
    * containers can have different linux distributions (Ubuntu, CentOS - only linux)
    * each process has isolated network, file system, user ids and process tree
    * Containers are small and fast (~1 second startup)

 * Docker
   * Dockerfile - text file with instructions for building an image
   * image - binary files with a root file system built using a Dockerfile
   * container - an isolated process based on an image
   * orchestration - something needs to schedule and start containers on a host
   * networking - the container has its own IP address
   * storage - a mounted volume in the container that writes to the host

 * Dockerfiles
   * simple text files that create binary images
   * Dockerfiles can be based on other images
   * You can have any Operating System and install any language

 * example app.js
   * log the arguments to stdout

```js
console.log(process.argv.slice(2).join(' ').toUpperCase())
```

 * example Dockerfile

```
FROM ubuntu:14.04
MAINTAINER kai.davenport@clusterhq.com
RUN apt-get update
RUN apt-get install -y nodejs npm imagemagick curl bash
ADD . /app
ENTRYPOINT ["/usr/bin/nodejs", "/app/index.js"]
```

 * build the Dockerfile into an image

```
$ docker build -t myapp .
```

 * the image is now on the host

```
$ docker images
```

 * images can be published to the "Dockerhub"
   * many, many images uploaded by other users
   * like the github for lightweight VM images
   * https://hub.docker.com

 * container
   * you run containers using the "docker run" command
   * using a base image, you can pass arguments to the "entrypoint"

```
$ docker run myapp foo bar
FOO BAR
```

 * you can run servers inside a container - like node, redis etc

img:logos of cool servers

 * example redis
   * mounted volume
   * exposed port

```
$ docker run -d -v /tmp/data:/data -p 6379:6379 redis
```

 * the idea is to run lots of containers, on lots of machines 
   * written in different languages (node, python, ruby etc)
   * they have different OS dependencies (apt-get vs yum etc)
   * they talk to each other a lot
   * they write data to disk
   * they need scheduling and starting

 * to run a multi-host cluster of docker containers - we need:
   * networking
   * storage
   * orchestration

 * networking
   * we want our containers to communicate with each other
   * web applications talking to database servers
   * micro-services talking to each other
   * weave,socketplane,calico
   * cross host network tools that allocate an IP address per container

 * storage
   * we want some containers to be able to save data (databases)
   * a volume enables a container to write data to the host
   * we need a way of managing those volumes across a cluster
   * flocker
   * storage tool that manages volumes attached to containers

 * orchestration
   * something needs to work out what container should run where
   * kubernetes (google)
   * mesosphere
   * fleet (coreos)
   * swarm (docker)

 * weave
   * virtual overlay network
   * layer 2
   * allows an IP address per container

```
$ weave run 10.0.0.1/24 myapp foo bar
```

 * flocker
   * manages data volumes across hosts
   * uses ZFS and a "2 phase push"
   * means you can run database servers in docker

```
$ flocker-deploy myapp-deploy.yaml myapp-fig.yaml
```

 * weave and flocker and both docker extensions
   * that extend a single docker daemon
   * that both "wrap" the docker cli

 * tools that wrap docker cannot work together
   * orchestration tools cannot use these extensions
   * we need a better way of extending docker!

 * lets understand how docker run works
   * Docker runs as a daemon on a linux host

```
$ docker -d -H unix:///var/run/docker.sock -s aufs
```

 * docker is a command line client
   * it sends a HTTP request to the docker daemon
   * think of it like a REST API for **processes**

 * example of docker run

```
$ socat -v UNIX-LISTEN:/tmp/docker.sock,fork UNIX-CONNECT:/var/run/docker.sock
```

```
$ DOCKER_HOST=unix:///tmp/docker.sock docker run ubuntu echo hello
```

 * POST /v1.17/containers/create
   * the JSON describing a container

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

 * POST /v1.17/containers/(id)/start
   * post the ID of a container to start

 * socat is a HTTP proxy between the docker client and daemon
   * it captures requests BEFORE they hit the docker server
   * it captures responses AFTER they are produced by the docker server

 * Powerstrip
   * a HTTP proxy that sits between the docker client and server
   * triggers PRE hooks before requests hit the docker server
   * triggers POST hooks after responses are produced by the docker server

 * Powerstrip

img:powerstrip diagram

 * adapters
   * are HTTP endpoints
   * can run as containers
   * are blocking
   * they chain - the output of one is the input of the next

 * pre-hooks
   * are useful for changing the container configuration
   * can allocate system resources ready for the container to use

img:pre hook diagram

 * post-hooks
   * useful for triggering systems after the container is running

img:post hook diagram

 * running an adapter
   * adapters can be containers
   * by mounting the docker socket - they can speak to docker

```
$ docker run -d --name powerstrip-weave \
    --expose 80 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    binocarlos/powerstrip-weave launch
```

 * running powerstrip
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

 * configuration

```yaml
version: 1
endpoints:
  "POST /*/containers/create":
    pre: [flocker, weave]
  "POST /*/containers/*/start":
    post: [weave]
adapters:
  weave: http://weave/extension
  flocker: http://flocker/flocker-adapter
```

 * powerstrip-weave
   * an adapter that assigns weave IP addresses to containers
   * an IP can move with a container to another host

 * example
   * run a container that is connected to a weave IP address
   * wait for weave to connect the IP before starting the container

```
$ sudo docker run -e "WEAVE_CIDR=10.255.0.51/8" -ti --rm binocarlos/powerstrip-weave-example hello world
```

 * powerstrip-flocker
   * an adapter that looks for **volumes** in a container
   * it mounts each volume as a zfs dataset
   * it can migrate the data in volumes across physical hosts

 * example
   * start a container that writes data to a flocker volume on node1
   * start a container that reads from the flocker volume on node2

```
node1$ sudo docker run --rm -v /flocker/test1:/data ubuntu bash -c "echo hello > /data/file.txt"
node2$ sudo docker run --rm -v /flocker/test1:/data ubuntu bash -c "cat /data/file.txt"
hello
```

 * both commands use the docker cli
   * this means orchestration tools can now use them
   * it also means the 2 adapters can be combined
   * a single container can be orcehstrated with storage AND networking

 * combined extensions

```
$ docker run -d \
  -e "WEAVE_CIDR=10.0.0.1/24" \
  -v /flocker/dataset1:/data \
  myapp
```

 * docker swarm
   * orchestration framework from docker
   * manages multiple physical hosts
   * presents a standard docker API that multiplexes the backend hosts

 * what about a powerstrip enabled swarm cluster?

img:swarm stack diagram

 * migrate a database from one host to another
   * we want the data to move with the container (flocker)
   * we want the IP address to move with the container

 * before the migration

img:before migration

 * after the migration

img:after migration

 * run demo

```
$ vagrant ssh master
master$ sudo bash /vagrant/run.sh demo
```

 * moving forward
   * the official docker extensions mechanism is coming **soon**
   * official extensions will work very similarly to powerstrip
   * there will be volume / networking specific extensions
   * also a general API extensions mechanism (much like powerstrip!)

 * storage workshop
   * we are going to run a workshop with 10-20 in about a month
   * do you develop or manage production systems?
   * you don't have to use docker!

 * help us improve!
   * http://clusterhq.com/research
   * we give away Amazon Vouchers for your time!

 * we are hiring!
   * http://clusterhq.com/careers

 * thanks 

