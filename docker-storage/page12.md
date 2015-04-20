### flocker cli

flocker is great but it **wraps** the docker CLI

This means it cannot be used with orchestration tools (Kubernetes, Mesos, Swarm) or networking tools (Socketplane, Weave, Calico)

ALL of these tools **wrap** the docker cli.