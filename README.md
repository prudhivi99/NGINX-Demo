# NGINX-Demo

# Go App with NGINX Ingress on Kubernetes

## Features
- Load balancing
- SSL termination (self-signed)
- Caching

## Load Balancing Testing
```
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ kubectl get pods -n myapp-ns -o wide
NAME                           READY   STATUS    RESTARTS   AGE   IP             NODE                   NOMINATED NODE   READINESS GATES
app-service-54c49b9fc5-fxncx   1/1     Running   0          19m   10.108.1.82    pool-kwg9xuua2-t739p   <none>           <none>
app-service-54c49b9fc5-w76tq   1/1     Running   0          19m   10.108.0.172   pool-kwg9xuua2-t7392   <none>           <none>
nginx-proxy-8684c46d48-9ljcv   1/1     Running   0          14m   10.108.0.100   pool-kwg9xuua2-t739l   <none>           <none>
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ 
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ 
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ kubectl get nodes -o wide
NAME                   STATUS   ROLES    AGE    VERSION   INTERNAL-IP   EXTERNAL-IP       OS-IMAGE                         KERNEL-VERSION   CONTAINER-RUNTIME
pool-kwg9xuua2-t7392   Ready    <none>   115m   v1.32.2   10.122.0.6    64.227.171.246    Debian GNU/Linux 12 (bookworm)   6.1.0-32-amd64   containerd://1.6.33
pool-kwg9xuua2-t739l   Ready    <none>   115m   v1.32.2   10.122.0.7    134.209.147.69    Debian GNU/Linux 12 (bookworm)   6.1.0-32-amd64   containerd://1.6.33
pool-kwg9xuua2-t739p   Ready    <none>   115m   v1.32.2   10.122.0.5    143.244.137.182   Debian GNU/Linux 12 (bookworm)   6.1.0-32-amd64   containerd://1.6.33
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ 
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ 
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ 
prawin_junk@prawin-dev:~/git/NGINX-Demo/helmcharts$ cd ..
prawin_junk@prawin-dev:~/git/NGINX-Demo$ cd scripts/
prawin_junk@prawin-dev:~/git/NGINX-Demo/scripts$ ./loadbalancer_testing.sh 
Hello from app-service-54c49b9fc5-w76tq!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-fxncx!
Hello from app-service-54c49b9fc5-w76tq!
Hello from app-service-54c49b9fc5-fxncx!
```
