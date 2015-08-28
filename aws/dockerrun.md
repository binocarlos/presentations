```
docker run \
    -d \
    --name mycontainer \
    -p 8045:80 \
    -v /path/on/host:/path/in/container \
    -e MY_ENV_VAR=thevalue \
    dockerhubuser/containername \
    --container-arg1=10 \
    --container-arg2=20
```