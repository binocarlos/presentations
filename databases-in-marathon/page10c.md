#### Docker Plugin

 * Plugins mechanism for Docker allows external processes to handle volumes
 * Docker --volume-driver syntax means Docker will call out to Flocker to handle a volume
 * When a container starts with a Flocker volume - Docker will block until the volume is mounted