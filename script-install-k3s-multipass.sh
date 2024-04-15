#!/bin/bash

multipass launch -n k-master -d 10Gb
multipass launch -n k-node1 -d 10Gb
multipass launch -n k-node2 -d 10Gb

multipass exec k-master -- bash -c "curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644"
TOKEN=$(multipass exec k-master sudo cat /var/lib/rancher/k3s/server/node-token)
IP=$(multipass info k-master | grep IPv4 | awk '{print $2}')

multipass exec k-node1 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"
multipass exec k-node2 -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin/kubectl
mkdir -p ~/.kube
multipass exec k-master -- cat /etc/rancher/k3s/k3s.yaml | sed 's/server: .*/server: https:\/\/'$IP':6443/' > ~/.kube/config
