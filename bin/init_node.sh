#!/bin/bash

echo '-- Installing Docker --'
yum install -y docker

echo '- add daemon.json from k8s-config repo'
mv /etc/docker/daemon.json /etc/docker/daemon.json.default
cp ../etc/docker/daemon.json /etc/docker/

echo '- enable and start docker'
systemctl enable docker && systemctl start docker


