#### fig.yml - with weave

```yaml
api:
  build: api
  command: node /srv/app/index.js
  environment:
   - WEAVE_CIDR=10.255.0.10/8
   - REMOTE_VALUE=oranges
server:
  build: server
  command: node /srv/app/index.js
  ports:
   - "8082:80"
  environment:
   - WEAVE_CIDR=10.255.0.11/8
   - API_IP=10.255.0.10

```
