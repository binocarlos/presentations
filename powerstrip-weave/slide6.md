### adapters.yml

An example of an `adapters.yml`.

debug -> weave -> debug

```yaml
version: 1
endpoints:
  "POST /*/containers/create":
    pre: [debug, weave, debug]
  "POST /*/containers/*/start":
    post: [debug, weave, debug]
adapters:
  debug: "http://debug/extension"
  weave: "http://weave/extension"
```