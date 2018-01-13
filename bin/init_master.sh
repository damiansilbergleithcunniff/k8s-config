#!/bin/bash

echo '-- Init the cluster with kubeadm --'
sudo kubeadm init

echo '- use the generated config for kubectl'
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
