#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
vagrant box add "bento/ubuntu-20.04" --provider=virtualbox
vagrant mutate "bento/ubuntu-20.04" libvirt
vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# must be created in project root directory with Vagrantfile template file
vagrant up --provider=libvirt "kuma-control-plane"



vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs


echo "========================================================================================="
