### Docker storage drivers

Docker has pluggable storage drivers that use *Copy-on-write*

 * aufs
 * btrfs
 * device mapper
 * others...

*Copy-on-write* means I can write data to a container without taking a copy of the entire OS.