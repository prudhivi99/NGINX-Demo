#!/bin/bash

set -e

NAMESPACE="myapp-ns"
RELEASE_NAME="nginx-demo"
CHART_DIR="./../helmcharts"
TLS_CERT="./../tls/tls.crt"
TLS_KEY="./../tls/tls.key"
NODE_PORT=30443

# Step 1: Create namespace if it doesn't exist
if ! kubectl get namespace $NAMESPACE > /dev/null 2>&1; then
  echo "🔧 Creating namespace $NAMESPACE..."
  kubectl create namespace $NAMESPACE
else
  echo "ℹ️ Namespace $NAMESPACE already exists"
fi

# Step 2: Create TLS secret
echo "🔐 Creating TLS secret..."
kubectl create secret tls nginx-tls-secret \
  --cert=$TLS_CERT \
  --key=$TLS_KEY \
  -n $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Step 3: Deploy Helm chart
echo "🚀 Installing/Upgrading Helm chart..."
helm upgrade --install $RELEASE_NAME $CHART_DIR -n $NAMESPACE --create-namespace

# Step 4: Wait for NGINX pod to be ready
echo "⏳ Waiting for nginx-proxy pod to be ready..."
kubectl wait --for=condition=ready pod -l app=nginx-proxy -n $NAMESPACE --timeout=120s

# Step 5: Get external IP of a node
EXTERNAL_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [[ -z "$EXTERNAL_IP" ]]; then
  echo "❌ Failed to get external IP of any node."
  exit 1
fi
echo "🌐 External IP: $EXTERNAL_IP"

# Step 6: Test HTTPS endpoint
echo "🔍 Testing HTTPS access..."
curl -k https://$EXTERNAL_IP:$NODE_PORT || echo "⚠️ curl failed"

echo "✅ Deployment complete."

