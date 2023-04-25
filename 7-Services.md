## Service:
- An abstract way to expose an application running on a set of Pods as a network service.

> Incoming traffic -> service -> Pod 1,2,3 
* Serivice receives the Incoming traffic and dynamically forwards that incoming traffic to set of replica pods.

## Different types of Service Types:
1. ClusterIP
- This is default Service type
- Setting Service type to ClusterIP makes the Service only exposed within the cluster.
2. NodePort
- Node port service is exposed externally therefore you'll be able to contract the NodePort Service from outside the cluster
3. Load Balancer
- Exposes the Service externally using a cloud provider's load balancer. It will work only if your cluster is on Cloud Provider
4. ExternalName
- This service type maps the Service to an external address by returning a CNAME record.

# Practice:
### Example:1 Deployment
> vi my-nginx-dep-ser.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx-dep-ser-pod
  labels:
    app: mynginx-ds
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-ds
  template:
    metadata:
      labels:
        app: nginx-ds
    spec:
      containers:
      - name: my-nginx-dep-ser-container
        image: nginx
        ports:
        - containerPort: 80

> kubectl create -f my-nginx-dep-ser.yaml

> kubectl get pods -l app=nginx-ds

### Example:2 Services

> vi my-nginx-service.yaml

apiVersion: v1
kind: Service
metadata:
  name: my-nginx-service-pod
spec:
  type: ClusterIP
  selector:
    app: nginx-ds
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 80

> kubectl create -f my-nginx-service.yaml

> kubectl get service

> kubectl get endpoints my-nginx-service-pod

> kubectl get pods [my-nginx-dep-ser-pod-xxxx-xxxx] -o wide
> curl [ip]:80

