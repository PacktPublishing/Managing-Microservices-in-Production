# Operationalize Your Cluster

Now that you have a good grasp on how to provision and deploy to a cluster, it’s time to take a deeper dive into tools and resources used to manage everything in production.  You will learn about monitoring tools, setting alerts, and incorporating things you’ve learned to help ensure the application you deploy is stable as well as the cluster it runs on.

- Video 1: Monitoring with Prometheus and Grafana
- Video 2: Alerts using Prometheus and Azure Monitor
- Video 3: Liveness and Readiness Probes Revisited
- Video 4: Platform Patching and Upgrading
- Video 5: Business Continuity and Disaster Recovery

Any dashboards demonstrated within Grafana, unless otherwise specified, are included in ConfigMaps that are installed with the Istio demo profile or with kube-prometheus.

To get Velero running, execute the init-backup.sh script first, then the install-velero.sh script.  

## Related Links

- [Grafana Community Dashboards](https://grafana.com/grafana/dashboards)
- [Prometheus](https://prometheus.io/)
- [Prometheus AlertManager](https://prometheus.io/docs/alerting/alertmanager/)
- [`kube-prometheus`, with AlertManager and dashboards](https://github.com/coreos/kube-prometheus)
- [Configure Prometheus integration with Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-prometheus-integration)
- [Velero](https://velero.io)
