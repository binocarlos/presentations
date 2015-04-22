### wrap Docker

Tools that wrap docker cannot work together.

For example - we want a single container to:

 * be deployed using **Kubernetes**
 * have networking setup by **Socketplane**
 * have a volume created by **Flocker**


