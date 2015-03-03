### Orchestration

A developer needs to describe WHAT services to run.  This means they define a **manifest** of somekind.

```yaml
helloworld:
  image: binocarlos/hello
  cmd: echo "hello world!"
backflip:
  image: binocarlos/backflip
  cmd: jump --count 3
```