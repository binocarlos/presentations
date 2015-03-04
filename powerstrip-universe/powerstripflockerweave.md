### powerstrip-(flocker && weave)

Combine both adapters to have portable volumes and portable IP addresses:

```bash
$ docker run \
    -v /flocker/data:/data \
    -e WEAVE_CIDR=10.255.0.1/24 \
    mycontainer
```