## Labels:
- are key/value pair that are attached to a resource, such as pods. You can make use of these labels to select and filter the resources using label selectors. A object can have more than one label and each key must be unique for a given object.
## Annotation:
- are used to specify non-identifying metadata to objects.
- can not be used to select kubernetes objects using label selectors.

# Practice:
### Example:1
> vi my-nginx-label.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-nginx-label-pod
  labels:
    my-web-server: nginx-dev
    env: development
spec:
  containers:
  - name: my-nginx-label-container
    image: nginx
    ports:
    - containerPort: 80

> kubectl create -f my-nginx-label.yaml

> kubectl get pods

> kubectl get pod --show-labels

> kubectl get pods -l env=development

> kubectl label pod my-nginx-label-pod my-app=my-application

> kubectl get pod --show-labels

> kubectl label pod my-nginx-label-pod  my-app=my-nginx-server --overwrite

> kubectl get pods --show-labels

> kubectl get pods --field-selector status.phase=Running
> kubectl get pods --field-selector status.phase!=Running

> kubectl get pods --field-selector status.phase=Running,metadata.namespace=default

> kubectl get pods --field-selector status.phase=Running,metadata.namespace=default -L env

### Example:2
> vi my-nginx-annotation.yaml

apiVersion: v1
kind: Pod
metadata:
  name: my-nginx-annotation-pod
  annotations:
    developer: test@devops4beginners.com
spec:
  containers:
  - name: my-nginx-annotation-container
    image: nginx
    ports:
    - containerPort: 80

> kubectl create -f  my-nginx-annotation.yaml
> kubectl describe pod my-nginx-annotation-pod
