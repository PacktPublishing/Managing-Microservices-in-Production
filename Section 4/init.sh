#!/bin/bash

# Start minikube using defaults from Istio setup
minikube start --memory=16384 --cpus=4

# Create the new namespace and stand up a simple NGINX app
kubectl create ns section4
kubectl apply -f nginx-deployment-s4.yml
kubectl expose deployment nginx -n section4
# You could use Helm to install an NGINX ingress controller
# helm repo update
# helm install nginx-ingress stable/nginx-ingress -n section4

# You could also use minikube addons to install
# This creates the NGINX ingress in the kube-system namespace
minikube addons enable ingress
# Add the ingress object
kubectl apply -f service-ingress.yaml
# Add the Helm repo for cert-manager (SSL Certificates)
kubectl apply --validate=false -f \
https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.1/deploy/manifests/00-crds.yaml

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.13.1