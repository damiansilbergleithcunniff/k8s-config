# k8s-config
This repo contains scripts that can be run to create a minimal kubernetes cluster on centos 7.  It's pretty much just a script implementation of the `kubeadm` documentation  which can be found here: 
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

There is some minor customization of the default documentation:
* docker network on each node is updated to be 172.18.0.0/16.  This addresses an issue with my VPN which shared the default 172.17.0.0/16 network.
* flannel is chosen as the pod network and installed as part of the setup.

# Usage
* `bin/init_node.sh` on each server in the cluster regardless of role.
*  Then on the master run `bin/init_master.sh`
  * When it completes run `bin/get_joincmd.sh
  * Save the command that is output, you'll use it to join the workers in a minute $JOIN
*  On each worker
  * Use $JOIN, the output from above.

You should now have a cluster that you can start to do things with.  Rerun `bin/get_joincmd.sh` anytime to get the command to run on additional nodes to add them to the cluster

