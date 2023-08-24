#!/bin/bash

#
# Script: rebuild.sh
# Purpose:  This script is simply a collation of all the steps needed to create the 
#           kubernetes environment on ec2, in a single script.  It was only written for testing
#           purposes, so the environment could be quickly torn down and spun up again during testing.     
#

#This is just a function to create a more visible title 
show()
{ 
    echo
    echo -ne "==> "
    echo -ne "\033[7m$@\033[0m"
    echo -e " <=="
}

#The correct path to the SSH_KEY_NAME needs to be entered here
SSH_KEY_NAME=

show "1 - terraform destroy"
terraform destroy -auto-approve -var="public_key_path=$SSH_KEY_NAME.pub"

show "2 - terraform apply"
terraform apply -auto-approve -var="public_key_path=$SSH_KEY_NAME.pub"

show "3 - create inventory"
./create-inventory.sh > ./ansible_inventory.ini 

show "4 - sleep for 30 seconds"
sleep 30

show "5 - ansible playbook 1-k8s-pre-flight.yaml"
ansible-playbook 1-k8s-pre-flight.yaml

show "6 - ansible playbook 2-k8s-cp-instance-prep.yaml"
ansible-playbook 2-k8s-cp-instance-prep.yaml

show "7 - ansible playbook 3-k8s-worker-instance-prep.yaml"
ansible-playbook 3-k8s-worker-instance-prep.yaml

show "8 - wait 30 seconds to ensure nodes are ready"
sleep 30

show "9 - k8s environment should be ready"
echo "Try: kubectl get nodes"