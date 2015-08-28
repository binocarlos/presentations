* Networking
    * For a microservice application - we need containers to talk to each other
    * We also want to secure this communication from the outside world
    * Docker allows to you expose a port on the host to a container port
    * Problem - we need to expose ports on the host
    * this means applications need to know the port to connect on