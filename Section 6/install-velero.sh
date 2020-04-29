#!/bin/bash
# Incoming args:
# $1        AKS Cluster Name
# $2        AKS Resource Group Name
# $3        Name of the subscription to use for backups (where the storage account lives)
#
AZURE_BACKUP_RESOURCE_GROUP="aks-backups"
AZURE_RESOURCE_GROUP=`az aks show -n "$1" -g "$2" --query nodeResourceGroup`
AZURE_STORAGE_ACCOUNT_ID="saaksbackups"

AZURE_BACKUP_SUBSCRIPTION_NAME="$3"
AZURE_BACKUP_SUBSCRIPTION_ID=`az account list --all --query="[?name=='$AZURE_BACKUP_SUBSCRIPTION_NAME'].id | [0]" -o tsv`

echo $AZURE_BACKUP_SUBSCRIPTION_ID
echo $AZURE_RESOURCE_GROUP


AZURE_SUBSCRIPTION_ID=`az account list --query '[?isDefault].id' -o tsv`
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
az account set -s "$3"
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "velero" --role "Contributor" --query 'password' -o tsv`
AZURE_CLIENT_ID=`az ad sp list --display-name "velero" --query '[0].appId' -o tsv`

cat << EOF  > ./credentials-velero
AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
AZURE_TENANT_ID=${AZURE_TENANT_ID}
AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
AZURE_RESOURCE_GROUP=${AZURE_RESOURCE_GROUP}
AZURE_CLOUD_NAME=AzurePublicCloud
EOF

BLOB_CONTAINER=`echo "$1" | tr '[:upper:]' '[:lower:]'`
# Run only for new storage accounts, assume that the container already exists otherwise
CONTAINER_OUTPUT=`az storage container show -n "$BLOB_CONTAINER" --account-name "$AZURE_STORAGE_ACCOUNT_ID" 2>&1 >/dev/null | grep -i ContainerNotFound`
echo $CONTAINER_OUTPUT
if [ "$CONTAINER_OUTPUT" != "" ]
then
  echo 'Creating the container as it does not exist'
  az storage container create -n $BLOB_CONTAINER --public-access off --account-name $AZURE_STORAGE_ACCOUNT_ID
fi
kubectl create ns velero
kubectl label ns velero istio-injection=enabled

helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update
helm install velero --namespace velero \
--set configuration.provider=azure \
--set-file credentials.secretContents.cloud=./credentials-velero \
--set configuration.backupStorageLocation.provider=azure \
--set configuration.backupStorageLocation.bucket=$BLOB_CONTAINER \
--set configuration.backupStorageLocation.config.storageAccount=$AZURE_STORAGE_ACCOUNT_ID \
--set configuration.backupStorageLocation.config.subscriptionId=$AZURE_BACKUP_SUBSCRIPTION_ID \
--set configuration.backupStorageLocation.config.resourceGroup=$AZURE_BACKUP_RESOURCE_GROUP \
--set configuration.volumeSnapshotLocation.provider=azure \
--set configuration.volumeSnapshotLocation.config.resourceGroup=$AZURE_BACKUP_RESOURCE_GROUP \
--set configuration.volumeSnapshotLocation.config.subscriptionId=$AZURE_BACKUP_SUBSCRIPTION_ID \
--set image.repository=velero/velero \
--set image.pullPolicy=IfNotPresent \
--set deployRestic=true \
--set initContainers[0].name=velero-plugin-for-microsoft-azure \
--set initContainers[0].image=velero/velero-plugin-for-microsoft-azure:v1.0.0 \
--set initContainers[0].volumeMounts[0].mountPath=/target \
--set initContainers[0].volumeMounts[0].name=plugins \
vmware-tanzu/velero

velero create backup initial -w
velero create schedule dailybackup --schedule "0 3 * * *" 
