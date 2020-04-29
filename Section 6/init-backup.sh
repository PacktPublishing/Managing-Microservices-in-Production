#!/bin/bash

az group create -n aks-backups -l WestUS
az storage account create -n saaksbackups -g aks-backups \
    --sku Standard_GRS \
    --encryption-services blob \
    --https-only true \
    --kind BlobStorage \
    --access-tier Hot
# Get the Velero cli and move it to your local bin
curl -Lo ~/velero-1.3.2.tar.gz https://github.com/vmware-tanzu/velero/releases/download/v1.3.2/velero-v1.3.2-linux-amd64.tar.gz
tar -zxvf ~/velero-1.3.2.tar.gz
cd ~/velero-v1.3.2-linux-amd64
sudo mv velero /usr/local/bin

