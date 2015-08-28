* Storage
    * Some containers will want to write state to disk
    * What if we want to move the container or the host dies?
    * This becomes pets not cattle
    * EBS offers Block storage attached to the VM
    * We need a way to manage these block devices and attach them to containers