### The big picture

Combine a Docker extension mechanism and pluggable storage backends.

```
                    Kubernetes, Mesos, Swarm
                               |
                               |
                             Docker
                               |
                               |
                            Flocker
                               |
                               |
                          Storage Backend
                  (ZFS, Block Device, VMWare, EMC)

```