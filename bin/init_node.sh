#!/bin/bash

# script generated from documentation found here:
#  https://kubernetes.io/docs/setup/independent/install-kubeadm/

echo '-- Installing Docker --'
yum install -y docker

echo '- add daemon.json from k8s-config repo'
pushd "${0%/*}"
mv /etc/docker/daemon.json /etc/docker/daemon.json.default
cp ../etc/docker/daemon.json /etc/docker/
popd

echo '- enable and start docker'
systemctl enable docker && systemctl start docker

echo '-- Intsalling kubelet, kubeadm, and kubectl --'
echo '- add kubenetes repos'
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
# Disabling SELinux by running setenforce 0 is required to allow 
# containers to access the host filesystem, which is required by 
# pod networks for example. You have to do this until SELinux 
# support is improved in the kubelet.
setenforce 0
yum install -y kubelet kubeadm kubect

echo '- enable and start kubelet'
systemctl enable kubelet && systemctl start kubelet

