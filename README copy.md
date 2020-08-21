# kuma-k8s-sandbox

Travis (.com) branch:
[![Build Status](https://travis-ci.com/githubfoam/kuma-k8s-sandbox.svg?branch=dev)](https://travis-ci.com/githubfoam/kuma-k8s-sandbox)  

~~~~
>vagrant init --template Vagrantfile.provision.bash.ubuntu.erb
>dir
>vagrant up "kuma-control-plane"
>vagrant up "redis"

>vagrant destroy -f "kuma-control-plane"
>vagrant destroy -f "redis

>vagrant global-status

>del Vagrantfile
>dir
~~~~

~~~~
Kuma is a CNCF Sandbox project, open source and vendor neutral.
https://kuma.io/docs/0.7.1/overview/what-is-kuma/#flat-and-distributed-deployments

~~~~