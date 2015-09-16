#### Marathon

 * provides a REST api to control desired state of long running processes
 * can run arbitrary commands on the host or containers
 * Mesos has it's own containerizer or you can use Docker
 * desired state is represented by JSON files describing "groups" and "apps"
 * groups describe collections of apps in a single unit
 * apps can be "scaled" - each instance becomes a single Mesos task
 