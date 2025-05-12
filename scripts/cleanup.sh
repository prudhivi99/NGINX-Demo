#!/bin/bash

NAMESPACE="myapp-ns"
RELEASE_NAME="nginx-demo"

echo "🧼 Uninstalling Helm release..."
helm uninstall $RELEASE_NAME -n $NAMESPACE

echo "🗑️ Deleting leftover ConfigMap, Secret, and Services..."
kubectl delete configmap nginx-config -n $NAMESPACE --ignore-not-found
kubectl delete secret nginx-tls-secret -n $NAMESPACE --ignore-not-found
kubectl delete svc nginx-service -n $NAMESPACE --ignore-not-found
kubectl delete svc app-service -n $NAMESPACE --ignore-not-found

read -p "Do you want to delete the entire namespace '$NAMESPACE'? [y/N]: " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "🔻 Deleting namespace $NAMESPACE..."
  kubectl delete namespace $NAMESPACE
else
  echo "✅ Namespace preserved."
fi
