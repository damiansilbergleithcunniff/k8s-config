#!/bin/bash

echo '-- Init the cluster with kubeadm and flannel for the pod networ --'
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo '- Pass bridged IPv4 traffic to iptables’ chains, a requirement for some CNI plugins to work'
sudo sysctl net.bridge.bridge-nf-call-iptables=1

echo '- use the generated config for kubectl'
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo '- install flannel v0.9.1'
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml

echo '- print out pods to verify that kube-dns pod is running'
kubectl get pods --all-namespaces

# # USE THIS FOR SINGLE NODE CLUSTERS
# echo '- remove taint from master, allowing pods to schedule on the master node'
# kubectl taint nodes --all node-role.kubernetes.io/master-
