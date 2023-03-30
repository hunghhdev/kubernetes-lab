## ConfigMaps
- A ConfigMap is an API object used to store non-confidential data in key-value pairs.
## Create ConfigMaps
- kubectl cli
- yaml file

# Practice
> vi env.properties
env_sever=node1
env_name=myConfig

> kubectl create configmap myconfigmap-1 --from-env-file=env.properties

> kubectl get configmap myconfigmap-1 -o yaml

> kubectl create configmap myconfigmap-2 --from-literal=env_sever=node1 --from-literal=env_name=myConfig

> kubectl get configmaps myconfigmap-2 -o yaml

### Example:1 
> vi myconfigmap3.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: myconfigmap-3
  namespace: default
data:
  env_text1: Hello
  env_text2: Students


> kubectl create -f myconfigmap3.yaml

> kubectl get ConfigMap

### Example:2 
> vi my-configmap-pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: mypod-configmap
spec:
  containers:
    - name: mybusybox
      image: busybox
      command: ['sh', '-c', "echo $(env_text1_key) $(env_text2_key) && sleep 3600"]
      env:
        - name: env_text1_key
          valueFrom:
            configMapKeyRef:
              name: myconfigmap-3
              key: env_text1
        - name: env_text2_key
          valueFrom:
            configMapKeyRef:
              name: myconfigmap-3
              key: env_text2
  restartPolicy: Never

> kubectl create -f my-configmap-pod.yaml

> kubectl get pods

> kubectl logs mypod-configmap

> kubectl exec  mypod-configmap -- printenv

### Example:3 
> vi my-config-vol.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-config-vol-pod
spec:
  containers:
    - name: my-config-vol-container
      image: busybox
      command: ['sh', '-c', "echo $(ls /etc/config/) && sleep 3600"]
      volumeMounts:
      - name: my-config-volume
        mountPath: /etc/config
  volumes:
    - name: my-config-volume
      configMap:
        name: myconfigmap-3
  restartPolicy: Never

> kubectl create -f my-config-vol.yaml

> kubectl get pods

> kubectl logs my-config-vol-pod

> kubectl exec my-config-vol-pod -- cat /etc/config/env_text1

