# Install k3s on multipass
 - Multipass is a tool to generate cloud-style Ubuntu VMs quickly https://multipass.run
 - K3s is a lightweight Kubernetes distribution created by Rancher Labs https://k3s.io

## How to install
* This note is referenced from: https://andreipope.github.io/tutorials/create-a-cluster-with-multipass-and-k3s.html
- Install multipass  ```snap install multipass```
- Create a note name's **k-master**  ```multipass launch -n k-master``` default cpu 1 disk 5Gb memory 1Gb image lastest lts
- Create 2 worker nodes: **k-node1**, **k-node2** ```multipass launch -n k-node1``
- Deploy k3s to master node: ```multipass exec k-master -- bash -c "curl -sfL https://get.k3s.io | sh -"``` k3s default use containerd if want use docker https://docs.k3s.io/advanced#using-docker-as-the-container-runtime
- Save master token to **TOKEN** variable: ```TOKEN=$(multipass exec k3s-master sudo cat /var/lib/rancher/k3s/server/node-token)```
- Save master ip to **IP** variable: ```IP=$(multipass info k3s-master | grep IPv4 | awk '{print $2}')```
- Add **k-node1** to cluster: ```multipass exec k-node1 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"```
- Add **k-node2** to cluster: ```multipass exec k-node2 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"```

## Cleanup
- Just ```multipass stop k-master k-node1 k-node2 && multipass delete k-master k-node1 k-node2 && mutipass purge```