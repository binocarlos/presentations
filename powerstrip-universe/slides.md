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

#### Set out to fail

Design your code so that if services fail - they will not dissapoint.

http://www.use.com/images/s_2/disappointed_baby_b6e4dafcf9726ab94579_1.jpg

## Servers

