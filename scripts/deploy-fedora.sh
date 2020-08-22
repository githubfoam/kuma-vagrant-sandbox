#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

#https://github.com/chef/bento/tree/master/packer_templates/debian
# vagrant box add "bento/debian-10.4" --provider=virtualbox
# vagrant mutate "bento/debian-10.4" libvirt
# vagrant up --provider=libvirt "vg-compute-05"

# TESTED OK
# https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-8.2" --provider=virtualbox
# vagrant mutate "bento/centos-8.2" libvirt
# vagrant init --template Vagrantfile.template.erb 
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "vg-compute-06" 

# https://app.vagrantup.com/ubuntu/boxes/bionic64
# vagrant box add "ubuntu/bionic64" --provider=virtualbox
# vagrant mutate "ubuntu/bionic64" libvirt
# vagrant init --template Vagrantfile.provision.bash.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane" 


# https://app.vagrantup.com/ubuntu/boxes/groovy64 20.10
# vagrant box add "ubuntu/groovy64" --provider=virtualbox
# vagrant mutate "ubuntu/groovy64" libvirt
# vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane" 


# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
# vagrant box add "bento/ubuntu-19.10" --provider=virtualbox
# vagrant mutate "bento/ubuntu-19.10" libvirt
# vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane"

# https://github.com/chef/bento/tree/master/packer_templates/ubuntu
# vagrant box add "bento/ubuntu-20.04" --provider=virtualbox
# vagrant mutate "bento/ubuntu-20.04" libvirt
# vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane"
# vagrant up --provider=libvirt "redis"

# #https://github.com/chef/bento/tree/master/packer_templates/fedora
vagrant box add "bento/fedora-32" --provider=virtualbox
vagrant mutate "bento/fedora-32" libvirt
vagrant init --template Vagrantfile.provision.bash.fedora.erb
# must be created in project root directory with Vagrantfile template file
vagrant up --provider=libvirt "kuma-control-plane"
# vagrant up --provider=libvirt "redis"

# # https://app.vagrantup.com/centos/boxes/8 # Ansible provision OK
# vagrant box add "centos/8" --provider=libvirt
# vagrant up --provider=libvirt "vg-compute-09"

# # https://github.com/chef/bento/tree/master/packer_templates/opensuse
# vagrant box add  "bento/opensuse-leap-15.1" --provider=virtualbox
# vagrant mutate "bento/opensuse-leap-15.1"  libvirt
# vagrant up --provider=libvirt "vg-compute-10"

# # https://github.com/chef/bento/tree/master/packer_templates/sles
# vagrant box add  "bento/sles-15-sp1" --provider=virtualbox
# vagrant mutate "bento/sles-15-sp1"  libvirt
# vagrant init --template Vagrantfile.provision.bash.suse.erb
# # must be created in project root directory with Vagrantfile template file
# vagrant up --provider=libvirt "kuma-control-plane"
# vagrant up --provider=libvirt "redis"

# vagrant ssh "vg-compute-05" -c "sudo blazescan -h"

vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs
# vagrant destroy -f "vg-compute-05"


echo "========================================================================================="
