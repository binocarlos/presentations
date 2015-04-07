#### example

 * start a container that writes data to a flocker volume on node1
 * start a container that reads from the flocker volume on node2

```
node1$ sudo docker run --rm -v /flocker/test1:/data ubuntu bash -c "echo hello > /data/file.txt"
node2$ sudo docker run --rm -v /flocker/test1:/data ubuntu bash -c "cat /data/file.txt"
hello
```