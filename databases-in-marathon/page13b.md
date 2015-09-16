#### Run a Database on Marathon

 * using the '--volume-driver' syntax we can run containers via Marathon that have Flocker volumes attached to them
 * if the container is restarted or rescheduled - Flocker will move the volume ready for the container
 