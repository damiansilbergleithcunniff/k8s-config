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
  * run `bin/get_joincmd.sh`
     * save the output of this command, you'll run it on each worker node in the cluster
* On the workers:
  * run `bin/init_node.sh`
  * run the output of the `bin/get_joincmd.sh` from above

# kubectl from your laptop
## install kubectl config
You can use the kubectl config from the server to enable direct communication from your local machine.  The easiest way to do this is to `scp` it from the master with a command like:

```
$MASTER_IP=10.0.0.0
$CLUSTER_NAME=dsck8s01
scp $MASTER_IP:~/.kube/config ~/.kube/$CLUSTER_NAME
```

Where $MASTER_IP is the IP of the master node, and $CLUSTER_NAME is some id that you can pass to kubectl or set as an enivornment variable.

## configure filewall rules
You may need to allow inbound TCP traffic on port `6443` to your master node.  You can set this up in the cloud provider's firewall ruleset.  It is suggested to allow as limited access as is reasonable and to consider the security implications of opening the port

## connecting using the config
You can use the config by assigning it's full path to the environment variable `KUBECONFIG`.  This can be done by issueing
```
export KUBECONFIG=$HOME/.kube/$CLUSTER_NAME
```
alternatively you can use the config for one offs: 
```
kubectl --kubeconfig=~/.kube/$CLUSTER_NAME get no
```

