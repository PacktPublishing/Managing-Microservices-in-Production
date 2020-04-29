#!/bin/bash

# This will update helm and install chaoskube into your cluster
# and will set dryRun = false to ensure it works, along with other settings

helm repo update
helm install chaos stable/chaoskube --set dryRun=false \
--set metrics.enabled=true \
--set rbac.create=true \
--set interval=2m \
--set namespaces="sock-shop"
