#!/bin/bash

# Install Ansible in the VM
if [ ! -f /usr/bin/ansible ]; then
    echo INSTALLING ANSIBLE
    sudo apt-get install software-properties-common
    echo ADDING ANSIBLE REPO
    sudo apt-add-repository ppa:ansible/ansible
    echo APT GET UPDATE
    sudo apt-get update
    echo INSTALL ANSIBLE
    sudo apt-get install -y ansible
fi

# Kickstart provisioning with Ansible in local
#cd  /var/www/nbddata
#ln -s ansible/roles
#ansible-galaxy install --role-file=ansible/galaxy-roles.txt --ignore-errors --force
ansible-playbook -i ansible/hosts --limit=vagrant ansible/consul.yml -vv; true
