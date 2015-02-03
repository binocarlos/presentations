## powerstrip architecture

 * HTTP proxy lisening on `tcp://127.0.0.1:2375`.

 * Blocking "hooks" that can modify the request.

 * pre-hooks are BEFORE the request hits docker.

 * post-hooks are AFTER the docker server responds.