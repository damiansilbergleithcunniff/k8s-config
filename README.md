# k8s-config
This repo contains scripts that can be run to create a minimal kubernetes cluster on centos 7.  It's pretty much just a script implementation of the `kubeadm` documentation  which can be found here: 
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

There is some minor customization of the default documentation:
* docker network on each node is updated to be 172.18.0.0/16.  This addresses an issue with my VPN which shared the default 172.17.0.0/16 network.
* flannel is chosen as the pod network and installed as part of the setup.

# Usage
* Clone this repo onto each node in your cluster
* On the master: 
  * run `bin/init_node.sh`
  * run `bin/init_master.sh` 
  * run `bin/get_joincmd.sh`
     * save the output of this command, you'll run it on each worker node in the cluster
* On the workers:
  * run `bin/init_node.sh`
  * run the output of the `bin/get_joincmd.sh` from above

You should now have a cluster that you can start to do things with.  

## Adding an additional worker
If you want to add additional workers you can:
* On the master:
  * run 'bin/get_joincmd.sh`
     * save the output of this command, you'll run it on each worker node in the cluster
* On the workers:
  * run `bin/init_node.sh`
  * run the output of the `bin/get_joincmd.sh` from above
