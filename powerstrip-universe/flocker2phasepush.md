### Flocker 2 phase push

 * step 1: initiate the copy of the zfs snapshots whilst database is still live
 * step 2: block new connections and copy the last zfs snapshot

Step 2 often takes < 1 second because it is a small amount of data.