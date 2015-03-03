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

http://upload.wikimedia.org/wikipedia/commons/3/3f/US_Navy_081117-N-9950J-004_Air_Traffic_Controller_2nd_Class_Erin_McHenry,_of_Wichita,_Kan.,_and_Air_Traffic_Controller_Airman_Apprentice_Adam_Minkel,_of_Pipestone,_Minn.,_track_aircraft_on_a_radar_console.jpg

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

#### docker can run databases too!

Turn up the volume!

http://cdn2.hubspot.net/hub/207654/file-1629235112-gif/Take_It_To_Eleven.gif?t=1420231424000

#### mount a volume

Volumes mean the data is seperated from the process manager.  This means the data is persisted to a single host:

```
$ docker run -v /srv/data:/data mydatabaseimage
```

#### This is pets not cattle

http://spenglercounseling.com/wp-content/uploads/2013/01/cute_puppy-1920x1200.jpg

#### Moving stateful containers

Data cannot BELONG to a physical host.  We must be able to move containers AND their volumes.

https://raw.githubusercontent.com/ClusterHQ/powerstrip-flocker/master/resources/flying_books.jpg

## flocker

Flocker is an open source tool that manages the VOLUMES attached to a container.

#### Network aware volumes
