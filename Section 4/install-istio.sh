#!/bin/bash

# Assuming minikube is running
minikube addons disable ingress
kubectl delete -f service-ingress.yaml
# Download and unpack istioctl
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.5.0
export PATH=$PWD/bin:$PATH

# Install Istio
# More information on profiles: 
# https://istio.io/docs/setup/additional-setup/config-profiles/
istioctl operator init
kubectl create ns istio-system
kubectl apply -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: example-istiocontrolplane
spec:
  profile: demo
EOF