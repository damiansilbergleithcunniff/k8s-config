#!/bin/bash

MASTER_IP=$1
MASTER_PORT=$2
TOKEN=$3
SHA256=$4

echo '-- must be root'
sudo -s <<EOF
echo '-- setting network'
sysctl net.bridge.bridge-nf-call-iptables=1
echo '-- Joining worker node to cluster'
kubeadm join --token $TOKEN $MASTER_IP:$MASTER_PORT --discovery-token-ca-cert-hash sha256:$SHA256
echo 'exit root'
EOF

echo "-- Installing current user's  kubectl config from the master"
mkdir ~/.kube
scp $MASTER_IP:~/.kube/config ~/.kube/config

echo "-- Add the node role 'worker'"
kubectl label no `hostname` node-role.kubernetes.io/worker=

echo "-- sleep for 5 seconds then print the node list"
sleep 5s
kubectl get nodes
