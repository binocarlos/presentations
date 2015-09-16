#### Mesos

 * kernel of the datacentre
 * origins in Twitter - powers Apple's Siri, AirBnB and many others
 * has a master/slave architecture
 * keeps state in zookeeper (which uses Paxos)
 * slaves make "resource offers" to the master
 * frameworks accept or reject these offers
 