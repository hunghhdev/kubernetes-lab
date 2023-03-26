## Kubernetes pod
- A pod is a group of one or more containers, with shared storage/network resources and a specification for how to run the containers
## 4 required fields:
- apiVersion: Indicates the release version of kubernetes object
- kind: Indicates what type of kubernetes object you want to create
- metadata: This include name, annotation, labels, namespace and other information releated to the object.
- spec: stands for specification and contains the kubernetes object specification

### Example:1 
> vi my-first-pod.yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: my-nginx-pod
spec:
  containers:
  - name: my-nginx-container
    image: nginx
    ports:
    - containerPort: 80
```

> kubectl create -f my-first-pod.yaml

> kubectl get pods

> kubectl exec -it my-nginx-pod /bin/bash

### Example:2 

> vi my-busybox.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: my-busybox-pod
spec:
  containers:
  - name: my-busybox-container
    image: radial/busyboxplus:curl
    args:
    - sleep
    - "3600"
```
> kubectl create -f my-busybox.yml

> kubectl get pods

> kubectl get pods -o wide

> kubectl exec my-busybox-pod -- curl [pod ip]

> kubectl edit pod my-nginx-pod

> kubectl get pods my-nginx-pod -o yaml

* Namespaces provides a mechanism for isolating groups of resources within a single cluster
> kubectl get namespaces

> kubectl get pods -n default

> kubectl get po -n kube-system

> kubectl create ns myns

> kubectl get namespaces

### Example:3 - Namespaces
> vi my-ns.yml
```
apiVersion: v1
kind: Pod
metadata:
  name: my-busybox-ns-pod
  namespace: myns
  labels:
    env: dev
spec:
  containers:
  - name: my-busybox-ns-container
    image: busybox
    command: ['sh', '-c', 'echo "Hello, Kubernetes!" && sleep 3600']
```
> kubectl create -f  my-ns.yml

> kubectl get pods

> kubectl get pods -n myns

> kubectl delete pod my-nginx-pod