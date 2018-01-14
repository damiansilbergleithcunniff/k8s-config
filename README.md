# k8s-config
This repo contains a series of scripts that can be run to create a minimal kubernetes cluster on centos 7.

# usage
* `bin/init_node.sh` on each server in the cluster regardless of role.
*  Then on the master run `bin/init_master.sh`
  * When it completes run `bin/get_joincmd.sh
  * Save the command that is output, you'll use it to join the workers in a minute $JOIN
*  On each worker
  * Use $JOIN, the output from above.

You should now have a cluster that you can start to do things with.  Rerun `bin/get_joincmd.sh` anytime to get the command to run on additional nodes to add them to the cluster
