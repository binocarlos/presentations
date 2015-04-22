### dev/prod parity

When we want a copy of our production data for our dev/staging environments

```
          dev ------> CI -----> staging --> production
           |                       |             |
          data <---------------- data <-------- disk
```