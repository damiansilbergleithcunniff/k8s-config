#!/bin/bash

echo "-== This should be run on a master ==-"

MASTER_IP=`hostname -i` # <-- centOs
MASTER_PORT=6443 # <-- lazy, should do this dynamically
TOKEN=`sudo kubeadm token list | grep default-node-token | cut -d' ' -f1`
# https://github.com/kubernetes/kubeadm/issues/519
SHA256=`openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'`

echo "-- master node IP: $MASTER_IP"
echo "-- kubeport: $MASTER_PORT"
echo "-- kubernetes token: $TOKEN"
echo "-- cert: $SHA256"

echo
echo "-= This is the standard join command that is printed during master initialiation ="
echo "kubeadm join --token $TOKEN $MASTER_IP:$MASTER_PORT --discovery-token-ca-cert-hash sha256:$SHA256"

echo
echo "-= Use this command from the root of the k8s-config repo to join a node to this master =-"
echo "./bin/init_worker.sh $MASTER_IP $MASTER_PORT $TOKEN $SHA256"
