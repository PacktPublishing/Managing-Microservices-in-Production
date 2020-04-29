# Use and Deploy

Get Familiar with the fundamentals of microservices management in Kubernetes, here you will use the core tools and get acquainted with the key concepts of a cluster.

- Video 1: Familiarise yourself with `kubectl`
- Video 2: Starting Small: deploying a pod
- Video 3: How to talk to your pod: exposing a service
- Video 4: Create a deployment
- Video 5: Scale your deployment with HPA

We'll leverage the examples from Section 1 to create our first pod in Kubernetes using `kubectl`:

```bash
kubectl run --image microsoft/mssql-server-linux --env=['ACCEPT_EULA=Y','SA_PASSWORD=<CreateAPassword>'] --port=1433 --label='app=mssql'
```

If you were to expose this as a service, you would be able to do that using:

```bash
kubectl run --image microsoft/mssql-server-linux --env=['ACCEPT_EULA=Y','SA_PASSWORD=<CreateAPassword>'] --port=1433 --label='app=mssql' --expose=true
```

To save the configuration once the pod is deployed, simply use `kubectl get pod <pod name> -o yaml` and redirect the output to a file.
