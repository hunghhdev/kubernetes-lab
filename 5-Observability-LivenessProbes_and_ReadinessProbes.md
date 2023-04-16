## Probes:
- A probe is a diagnostic performed periodically by the kubelet on a container.
- Liveness probe: The kubelet uses liveness probes to know when to restart a container.
- Readiness probe: The kubelet uses readiness probes to know when a container is ready to start  accepting traffic.
# Pratice
### Example:1 
> vi my-livenessprobe.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-liveness-pod
spec:
  containers:
  - name: my-busybox-lp
    image: busybox
    command: ['sh', '-c', "echo Hello, Kubernetes! && sleep 3600"]
    livenessProbe:
      exec:
        command:
        - echo
        - check busybox container health
      initialDelaySeconds: 5
      periodSeconds: 5

> kubectl create -f my-livenessprobe.yaml

> kubectl get pods

> kubectl describe po my-liveness-pod

### Example:2 
> vi my-readinessprobe.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-readiness-pod
spec:
  containers:
  - name: my-nginx-container-rp
    image: nginx
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5

> kubectl create -f my-readinessprobe.yaml

> kubectl describe pod my-readiness-pod
