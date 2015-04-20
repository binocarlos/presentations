### Docker storage drivers

If I run a MySQL container and write 10Gb of data.

It will use COW but the data is locked up inside the container.

We need a way of writing data to the **host** from inside the container.