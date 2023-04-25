## Persistent Volumes:
- Kubernetes persistent volumes are user-provisioned storage volumes assigned to a Kubernetes cluster.

## Persistent Volume Claims:
- are objects that connect to back-end storage volumes.

## Diagram:
> Node/Cluster(1TB) -> Persistent Volume(10GB) -> Persistent Volume Claim(3GB) -> Application/Pod(3Gb)

# Practice:
### Example:1 Create PV 
> vi my-persistent-volume.yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv-volume
  labels:
    type: local
spec:
  storageClassName: my-pv-ten-gb
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"

> kubectl create -f my-persistent-volume.yaml
> kubectl get pv

### Exmple:2 Create PVC 
> vi my-persistent-volume-claim.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pv-claim
spec:
  storageClassName: my-pv-ten-gb
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi

> kubectl create -f my-persistent-volume-claim.yaml
> kubectl get pv
> kubectl get pvc

### Example:3 Create Pod 
> vi my-pvc-utilize.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-pvc-utilize-pod
spec:
  volumes:
    - name: my-pv-storage
      persistentVolumeClaim:
        claimName: my-pv-claim
  containers:
    - name: my-pvc-utilize-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: my-pv-storage

> kubectl create -f my-pvc-utilize.yaml
> kubectl describe pod my-pvc-utilize-pod

