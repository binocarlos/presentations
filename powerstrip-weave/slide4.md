### pre hooks

Pre hooks are useful for modifiying requests **BEFORE** they hit the docker server.

 * injecting env variables from etcd or consul
 * blocking requests based on some kind of auth
 * modifying the entrypoint of a container