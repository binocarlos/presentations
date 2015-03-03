## powerstrip universe

Have meetup on Thursday - need to do blog posts about powerstrip integrating with orchestration tools.

The first blog post will be about "the powerstrip universe".

It will have a diagram like this:

```
     k8s       mesos      swarm

        \        |         /

            orchestrators

                 |

             docker api

                 |

             powerstrip

        /                  \
    storage            networking
       |       
    flocker            /    |    \

       |          calico  weave   socketplane
       |

storage backends

 - zfs
 - block device
 - vSphere

```


It will talk about the various subsystems within this universe:

 * orchestration
 * powerstrip
 * networking
 * storage
 * storage drivers

## talk

The talk is titled "deep into docker storage".  The focus is powerstrip but must be storage based.

#### Powerstrip and multi-host docker clusters

 * Micro-service Architecture
    * run lots of services across lots of hosts
    * orchestation - WHAT to run
    * scheduling - WHERE to run it
    * monitoring - KEEP it running
 * Servers
    * services need to run SOMEWHERE
    * it's best for devops to not think about servers
    * servers are CATTLE not PETS
 * Networking tools - weave, calico, socketplane
    * the point of micro-services is they are chatty over the network to each other
    * so, micro-services have lots of network connections between services
    * virtual overlay networks
    * gives an IP per container
    * Layer2 - use MAC addresses
    * IP addresses can move with the container
    * this is CATTLE not PETS
 * Storage - flocker
    * lets talk about state, baby
    * micro services are great but need to save some data SOMEWHERE
    * the EASY part is running a stateless service - start it anywhere, start multiple copies
    * docker can run databases too - turn up the volume!
    * you can mount volumes and persist the data onto a single host ( -v /host/data:/data )
    * however, this is PETS not CATTLE 
    * moving a stateless container just means run a process somewhere
    * moving a stateful container means MOVING THE DATA TOO!
    * flocker manages the volume attached to a container
    * it gives you a network aware volume not just a local one
    * this means that you can move the data between hosts and have a high availability volume
    * flocker has storage drivers - zfs, block device, others?
    * zfs - data migration - scale up a database server from low memory to high memory
    * block device - HA - disaster recovery - shoot the cattle in the head!
    * we are working with top storage providers to integrate proprietory storage backends
    * with portable volumes, servers are CATTLE not PETS
 * Composition
    * I want storage AND networking for a single container
    * tools wrap docker somehow, meaning they can't be used together
    * docker really needs a way of composing extensions
 * Powerstrip - standard docker api
    * powerstrip presents a standard docker HTTP server
    * it allows adapters to "hijack" requests
    * it has "pre" and "post" hooks
    * diagram of powerstrip
    * pre-hooks allow you to change the container details before they hit docker
    * post-hooks allow you to trigger behaviour once the container has started
    * powerstrip and the adapters are containers
 * Orchestration
    * because powerstrip presents a standard docker API - any tool that speaks docker can trigger adapters
    * this means that existing orchestration tools can trigger extra behaviour
    * they do this using environment variables and volume paths
 * powerstrip universe image
    * bring everything together in the picture and talk about the top to bottom layers
 * Demo
    * show fig triggering a local setup with a weave IP and a flocker volume
    * show fig triggering swarm with a weave IP and a flocker volume and migrating from serverA to serverB
    

