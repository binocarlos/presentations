### flocker-deploy

```yaml
elasticsearch:
  image: clusterhq/elasticsearch
  ports:
   - "9200:9200"
  volumes:
   - /var/lib/elasticsearch
logstash:
  image: clusterhq/logstash
  ports:
   - "5000:5000"
  links:
   - elasticsearch:es
kibana:
  image: clusterhq/kibana
  ports:
   - "80:8080"
```