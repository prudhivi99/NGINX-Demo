# NGINX-Demo

# Go App with NGINX Ingress on Kubernetes

## Features
- Load balancing
- SSL termination (self-signed)
- Caching

```
Use ConfigMap for NGINX Configuration

Instead of mounting nginx.conf directly, consider creating a ConfigMap to manage the NGINX configuration. This approach allows for dynamic updates without rebuilding the image.

Implementation Steps:

Create ConfigMap:

bash
Copy
Edit
kubectl create configmap nginx-config --from-file=nginx/nginx.conf -n myapp-ns
Update Deployment:

Modify the NGINX deployment to mount the ConfigMap:

yaml
Copy
Edit
volumes:
  - name: nginx-config
    configMap:
      name: nginx-config
volumeMounts:
  - name: nginx-config
    mountPath: /etc/nginx/nginx.conf
    subPath: nginx.conf
Implement Health Checks

Adding readiness and liveness probes ensures Kubernetes can monitor and manage the application's health effectively.

Example:

yaml
Copy
Edit
readinessProbe:
  httpGet:
    path: /
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10

livenessProbe:
  httpGet:
    path: /
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 20
Enhance Helm Chart with Values

To make the Helm chart more flexible, parameterize configurations using values.yaml.

Example:

yaml
Copy
Edit
image:
  repository: prawin24/nginx-demo
  tag: latest
Then, reference these values in your templates:

yaml
Copy
Edit
image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
Automate TLS Secret Creation

Include a script or Makefile target to automate the creation of TLS secrets, streamlining the deployment process.

Example:

makefile
Copy
Edit
tls:
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout tls.key -out tls.crt -subj "/CN=example.com/O=example.com"
  kubectl create secret tls nginx-tls-secret \
    --cert=tls.crt --key=tls.key -n myapp-ns

```
