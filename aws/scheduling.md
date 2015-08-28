* Scheduling
    * what if we want more than one VM?
    * something needs to decide what will run where
    * we want to write a manifest that describes our stack
    * then pass the manifest to a scheduler and it will allocate containers
    * if a VM dies - the scheduler should re-schedule onto another machine
    * stop thinking about individual servers - cattle not pets!
    * Kubernetes,Mesosphere,Swarm,CloudFoundry,CloudSoft,ECS