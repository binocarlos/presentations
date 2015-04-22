### Block Device HA

Uses a **block device agent** on each node.  Can speak to:

 * OpenStack Cinder
 * AWS EBS

Flocker will format the block device with a filesystem and attach it to a container.

This becomes **transparent** to the container that needs storage.