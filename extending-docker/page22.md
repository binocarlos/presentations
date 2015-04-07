#### flocker

 * manages data volumes across hosts
 * uses ZFS and a "2 phase push"
 * means you can run database servers in docker

```
$ flocker-deploy myapp-deploy.yaml myapp-fig.yaml
```