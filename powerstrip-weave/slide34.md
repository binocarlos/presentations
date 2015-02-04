#### fig.yml - with links

```yaml
api:
  build: api
  command: node /srv/app/index.js
  environment:
   - REMOTE_VALUE=oranges
server:
  build: server
  command: node /srv/app/index.js
  links:
   - api
  ports:
   - "8082:80"

```
