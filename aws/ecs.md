* ECS
    * Amazons container scheduler
    * Rather than `docker run` - you write an application manifest
    * The manifest describes the containers you want to run
    * Each node has an ecs agent running
    * The nodes comminicate using a custom Paxos implementation
    * The scheduler decides which EC2 nodes each container will run on
    * If a node dies - the scheduler will kick in and start the container on another host