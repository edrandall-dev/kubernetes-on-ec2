#!/bin/bash

#
# Script:   create-inventory.sh
# Purpose:  This script can be used to create an inventory for ansible using
#           terraform's outputs. It can only be run after terraform has finished
#           creating the new environment in AWS.  This script also appends some
#           variables to the bottom of the file, which will be needed by ansible.
#

# Get public IPs of EC2 instances
worker_ips=($(terraform output -json worker_public_ips | jq -r '.[]'))
ctrlplane_ip=($(terraform output -json control_plane_public_ips | jq -r '.[]'))

# Get private IP of ctrl-plane instance
ctrlplane_private_ip=($(terraform output -json ctrlplane_private_ip | jq -r '.[]'))

#Get instance ids of EC2 instances
worker_ids=($(terraform output -json worker_instance_ids | jq -r '.[]'))
ctrlplane_ids=($(terraform output -json ctrl_plane_instance_ids | jq -r '.[]'))

# Get ctrlplane worker instance info 
echo "[ctrlplane_instances]"
echo "ctrlplane-instance ansible_host=${ctrlplane_ip} ansible_user=ec2-user"
echo

# Loop through instances and populate the inventory file
echo "[worker_instances]"
for i in "${!worker_ids[@]}"; do
  echo "worker-instance-${i} ansible_host=${worker_ips[i]} ansible_user=ec2-user"
done

echo
echo "[all:vars]"
echo ctrl_plane_private_ip=${ctrlplane_private_ip}
echo pod_network_cidr="10.244.0.0/16"