#!/bin/bash

echo "-== This should be run on a master ==-"

echo "-- master node IP:"
hostname -i # <-- centOs
echo "-- kubeport:"
echo 6443 # <-- lazy, should do this dynamically
echo "-- kubernetes tokens"
sudo kubectl tokens list
echo "-- The sha256 used for the cert field when joining nodes to this master"
# https://github.com/kubernetes/kubeadm/issues/519
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

