#### configuration

```yaml
version: 1
endpoints:
  "POST /*/containers/create":
    pre: [flocker, weave]
  "POST /*/containers/*/start":
    post: [weave]
adapters:
  weave: http://weave/extension
  flocker: http://flocker/flocker-adapter
```