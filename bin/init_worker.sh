#!/bin/bash

echo '-- Collect master node information --'
echo 'masterIP:'
read MASTER_IP
echo 'masterPort:'
read MASTER_PORT
echo 'token:'
read TOKEN
echo 'ca-cert-hash:'
read CA_CERT_HASH

echo '-- Joining worker node to cluster'
kubeadm join --token $TOKEN $MASTER_IP:$MASTER_PORT --discovery-token-ca-cert-hash sha256:$CA_CERT_HASH

echo '-- Installing current user\'s  kubectl config from the master'
scp $MASTER_IP:~/.kube/config ~/.kube/config
kubectl get nodes
