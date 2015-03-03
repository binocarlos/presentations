# slides

The running order of slides:

## Intro

Powerstrip and multi-host docker clusters

A journey into the world of extending docker and multi-host architectures.

## Micro-services

Complex applications that are composed of small, independent processes which are language agnostic and communicate over the network.

http://abdullin.com/storage/uploads/2014/01/sample.jpg

#### Popularity

They have gained lots of attention in the past 12 months.

http://www.google.co.uk/trends/explore#q=microservices

#### Any language

Each service can be a totally different language.

http://3.bp.blogspot.com/-KiXBBW7TtFk/UNQuZ9Uh3aI/AAAAAAAAAck/Uwo2R9D3DL8/s1600/languages.png

#### Orchestration

A developer needs to describe WHAT services to run.  This means they can define a **manifest** of somekind.

```yaml
helloworld:
  image: binocarlos/hello
  cmd: echo "hello world!"
backflip:
  image: binocarlos/backflip
  cmd: jump --count 3
```

#### Scheduling

Something needs to decide WHERE the services run.  In a multi-host environment this means a **scheduler** must make informed decisions.

https://www.colourbox.com/preview/4998342-timetable-at-the-ukrainian-railway-station.jpg

#### Monitoring

Something needs to KEEP the services running.  This means continously watching your services to ensure they are healthy and restarted them if they fail.

http://www.scorebuddy.co.uk/images/stories/monitoring-quality-in-call-center.jpg

## Servers

Services have to run SOMEWHERE!

If we could run everything on a single server - it would be easy.

http://eracks.com/images/rackmount-servers/zope_closed600.jpeg

#### Multiple hosts

In reality - production systems need multiple physical servers.  Scalability & high availability are 2 reasons why.

http://www.extremetech.com/wp-content/uploads/2012/10/google-datacenter-tech-21.jpg

#### Servers fail

Design your code so that if servers fail - they will not dissapoint.

http://www.use.com/images/s_2/disappointed_baby_b6e4dafcf9726ab94579_1.jpg

#### Pets

Pets are valued individuals:

 * they have names
 * they are missed if they go away

http://spenglercounseling.com/wp-content/uploads/2013/01/cute_puppy-1920x1200.jpg

#### Cattle

Cattle are an anonymous resource:

 * they do not have names
 * they can be replaced if they go away

http://media.bestofmicro.com/1/J/426439/gallery/cattle-vs-pets_w_500.jpg

#### Cattle NOT pets!

We want our servers to behave like cattle not pets.  If a server breaks, it should be replacable with another server.

https://gratefultothedead.files.wordpress.com/2013/11/broken-laptop-500x375.jpg

## Tools

To run a micro-service architecture across multiple hosts - we need some tools yo.

http://expeditionworkshed.org/assets/toolbox.jpg

## Networking

Microservices are chatty.  They need networking together.  There are lots of connections.

http://thealbanyjournal.com/wp-content/uploads/2011/04/Phone-company.jpg

#### port mapping

Port mapping can get messy - running multiple web servers means each server wants port 80 on the host.

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/scrum.jpg

#### virtual overlay networks

http://focus.forsythe.com/clients/22/assets/200/Slide1.JPG

#### IP per container

Because the network is **virtual** - we can allocate an IP address per container - they are no longer a scarce resource.

#### Layer 2

Overylay networks work at layer 2 - they route using MAC addresses.

https://github.com/binocarlos/presentations/blob/master/powerstrip-weave/images/osi-model.gif

#### IP addresses can move

IP addresses can MOVE with containers.  This is like moving house by actually moving your house!

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/house-move.jpg

#### This is cattle not pets

http://media.bestofmicro.com/1/J/426439/gallery/cattle-vs-pets_w_500.jpg

## Storage

Lets talk about state, baby.

http://www.bbkingblues.com/inc/artists/1933-3.jpg

#### Microservices need state too

Most applications have SOME state.  They have to save this state SOMEWHERE.

http://static.panoramio.com/photos/large/30766728.jpg

#### Stateless services

The EASY part is running a stateless service - start it anywhere, start multiple copies

http://www.profitguide.com/wp-content/uploads/2014/10/drones.jpg

#### Docker can run databases too!

Turn up the volume!

http://cdn2.hubspot.net/hub/207654/file-1629235112-gif/Take_It_To_Eleven.gif?t=1420231424000

#### Mount a volume

Volumes mean the data is seperated from the process manager.  This means the data is persisted to a single host:

```
$ docker run -v /srv/data:/data mydatabaseimage
```

#### This is pets not cattle

http://spenglercounseling.com/wp-content/uploads/2013/01/cute_puppy-1920x1200.jpg

#### Moving stateful containers

Data cannot BELONG to a physical host.  We must be able to move containers AND their volumes.

https://raw.githubusercontent.com/ClusterHQ/powerstrip-flocker/master/resources/flying_books.jpg

## Flocker

Flocker is an open source tool that manages the VOLUMES attached to a container.

https://drive.google.com/a/clusterhq.com/#folders/0B5eaNKW-S4JMdjBTanZ4Zmp1a2M

#### Network aware volumes

Flocker makes volumes **network aware**.  This means you can move volumes between physical hosts and have high availability.

https://websmp203.sap-ag.de/~sapidp/012002523100002079152015E/Frame/images/272068.jpg

#### Storage drivers

It has pluggable backend storage drivers.  This means that you can change the implementation of the underlying storage the volume uses on the host.

http://www.eprovided.com/data-recovery-blog/wp-content/uploads/2014/07/Depositphotos_6066630_xs1.jpg

#### ZFS

http://zfsonlinux.org/images/zfs-linux.png

#### ZFS for data migration

When you need more memory on your DB server - you need to migrate your data

http://www.agiledatamigration.com/wp-content/uploads/2013/08/FreeGreatPicture.com-1216-jumping-goldfish-700x300.jpg

#### Flocker 2 phase push

 * step 1: initiate the copy of the zfs snapshots whilst database is still live
 * step 2: block new connections and copy the last zfs snapshot

Step 2 often takes < 1 second because it is a small amount of data.

#### Block device

Attach block device storage to your docker containers!

http://www.nature.com/nature/journal/v433/n7024/images/433369a-f1.2.jpg

#### Block device for high availability

The data in a block device backend is available even if the server dies.

http://www.linuxjournal.com/files/linuxjournal.com/ufiles/imagecache/large-550px-centered/u1002061/11723f1.png

#### Works with cloud (tm)

The flocker block device backend will work with your favorite cloud provider block storage.

http://knackforge.com/sites/default/files/amazon.png
http://techmeetups.com/wp-content/uploads/2013/03/RackspaceLOGO.jpg
http://www.cloudtp.com/wp-content/uploads/2014/03/CloudPlatform_HorizontalLockup-1-1024x246.png

#### Proprietory storage backends

We are working with some of the top industry storage providers to create custom storage drivers for flocker.

http://www.zenlifesolutions.com/wp-content/uploads/2013/01/question-mark.jpg

#### With portable volumes

servers are CATTLE not PETS

http://media.bestofmicro.com/1/J/426439/gallery/cattle-vs-pets_w_500.jpg

## Composition

I want Storage AND Networking for a single container

http://www.tec-wi.com.br/wp-content/uploads/2013/10/021010.jpg

AND

http://upload.wikimedia.org/wikipedia/commons/2/29/Hard_disk_Western_Digital_WD740_1_(dark1).jpg

#### Tools WRAP docker

Existing tools "wrap" docker somehow - wrapping is bad.

https://thelegacybuilder.files.wordpress.com/2012/12/badly-wrapped-gift.png

#### Idea needed

We need a way to COMBINE extensions - we need an IDEA

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/lightbulb.jpg

## Powerstrip

Presenting Powerstrip - docker extensions that are:

 * late-bound
 * composable
 * optional

#### Docker Speaks HTTP

The docker client sends HTTP requests to the Docker server.  This means that we can present a HTTP proxy that **intercepts** the requests before they hit the docker server.

#### Powerstrip

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/powerstrip.png

#### Pre-hooks

Can modify containers BEFORE they hit the real docker server.

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/ps-create.png

#### Post-hooks

Can react to containers AFTER they hit the real docker server.

https://raw.githubusercontent.com/binocarlos/presentations/master/powerstrip-weave/images/ps-start.png

#### Adapters are HTTP endpoints

Powerstrip adapters are HTTP servers - they can be written in any language.

#### Adapters are containers

Powerstrip adapters are containers - this means installing them is easy.

#### Configuration

You configure powerstrip using a YAML file - you can chain MULTIPLE adapters!

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

## Demo

Powerstrip presents a standard docker API - this means any tool that speaks Docker can speak Powerstrip!

We can now have Networking AND Storage AND Orchestration ftw

#### powerstrip-universe

IMAGE

#### Swarm DEMO

We are going to run a fig file for database stack that has flocker and weave combined