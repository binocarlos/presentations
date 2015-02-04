#### post-hook

We have a POST-HOOK for this endpoint:

```
POST /v1.16/containers/1234567/start
```

(1234567) is the container id we just created

In the hook we load the container ENV to ask for the **WEAVE_CIDR** setting.