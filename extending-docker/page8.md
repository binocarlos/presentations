#### example Dockerfile

```js
FROM ubuntu:14.04
MAINTAINER kai.davenport@clusterhq.com
RUN apt-get update
RUN apt-get install -y nodejs npm imagemagick curl bash
ADD . /app
ENTRYPOINT ["/usr/bin/nodejs", "/app/index.js"]
```