# kuma-vagrant-sandbox


Travis (.com) branch:
[![Build Status](https://travis-ci.com/githubfoam/kuma-vagrant-sandbox.svg?branch=master)](https://travis-ci.com/githubfoam/kuma-vagrant-sandbox)  

~~~~
>vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
>dir
>vagrant up "kuma-control-plane"

>vagrant destroy -f "kuma-control-plane"

>vagrant global-status

>del Vagrantfile
>dir
~~~~

~~~~

https://github.com/kumahq/kuma-demo/tree/master/vagrant

Kuma is a CNCF Sandbox project, open source and vendor neutral.
https://kuma.io/docs/0.7.1/overview/what-is-kuma/#flat-and-distributed-deployments

~~~~