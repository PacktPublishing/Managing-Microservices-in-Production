# Continuous Integration and Continuous Deployment

Now that you know how our Microservices will behave in your cluster, it is time to gain an understanding of how you can continually get your code tested and deployed.

- Video 1: Breakdown of CI and CD for containers
- Video 2: CI options, working with Azure DevOps
- Video 3: CD, watching your build deploy
- Video 4: Making your deployments fault-tolerant
- Video 5: Integrated Chaos Engineering

For examples related to using Azure Container Registry, you can use the Azure Portal or the Azure CLI to create a new container registry, assuming you have an Azure account.  

There are three ingresses that have been created to allow for mock DNS hostnames related to the SockShop application, Kiali, and Grafana.  To get these to work locally, you will want to edit your hosts file with the following:
```
sockshop.example.com  <<Istio Ingress IP>>
grafana.example.com   <<Istio Ingress IP>>
kiali.example.com     <<Istio Ingress IP>>
```

## Related Links

- [Liveness and Readiness Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
- [Requests and Limits](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/)
- Application Monitoring and Telemetry
  - [Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
  - [AppDynamics](https://www.appdynamics.com/)
  - [NewRelic](https://newrelic.com/)
- [Principles of Chaos Engineering](https://principlesofchaos.org/)
- Chaos Engineering Tools
  - [Simian Army (Netflix)](https://github.com/Netflix/SimianArmy)
  - [Bloomberg Powerful Seal](https://github.com/bloomberg/powerfulseal)
  - [ChaosBlade](https://github.com/chaosblade-io/chaosblade)
  - [Azure Service Fabric Chaos](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-controlled-chaos)
  - [ChaosKube](https://github.com/linki/chaoskube)