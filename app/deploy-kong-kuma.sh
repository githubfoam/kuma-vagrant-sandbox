#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# https://konghq.com/blog/canary-deployment-5-minutes-service-mesh/
# https://kuma.io/docs/0.7.1/installation/ubuntu/
# https://github.com/kumahq/kuma-demo/tree/master/kubernetes
echo "=============================securing your application with mTLS using Kuma============================================================="

# Kuma will store all of its state and configuration on the underlying Kubernetes API server, and therefore requiring no dependency to store the data. 
# Deploy the marketplace application
# kubectl apply -f https://raw.githubusercontent.com/Kong/kuma-demo/master/kubernetes/kuma-demo-aio.yaml
kubectl apply -f https://bit.ly/demokuma

# The first pod is an Elasticsearch service that stores all the items in our marketplace
# The second pod is the Vue front-end application that will give us a visual page to interact with
# The third pod is our Node API server, which is in charge of interacting with the two databasesö
# The fourth pod is the Redis service that stores reviews for each item
kubectl get pods -n kuma-demo

echo echo "Waiting for kuma-demo to be ready "
for i in {1..60}; do # Timeout after 5 minutes, 60x5=300 secs
      # if kubectl get pods --namespace=kubeflow -l openebs.io/component-name=centraldashboard | grep Running ; then
      if kubectl get pods --namespace=kuma-demo  | grep ContainerCreating ; then
        sleep 10
      else
        break
      fi
done
kubectl get pods -n kuma-demo

# port-forward the sample application to access the front-end UI
# kubectl port-forward ${KUMA_DEMO_APP_POD_NAME} -n kuma-demo 8080:80# kubectl port-forward ${KUMA_DEMO_APP_POD_NAME} -n kuma-demo 8080:80

# access the front-end UI on http://localhost:8080, port-forward the frontend service 
kubectl port-forward service/frontend -n kuma-demo 8080 & #background job
# curl: (7) Failed to connect to localhost port 8080: Connection refused
# curl http://localhost:8080

# Kuma is an open-source control plane for modern connectivity, delivering high performance and reliability with Envoy
# download it first and then install it onto the Kubernetes cluster
/bin/sh -c "curl -L https://kuma.io/installer.sh | sh -"
# cd kuma-0.7.0/bin && ls
cd kuma-*/bin && ls -lai  #Kuma 0.7.1 has been downloaded!

# Using kumactl install install the control-plane onto the Kubernetes cluster
# bash kumactl install control-plane | kubectl apply -f - #error: no objects passed to apply
# /bin/sh -c "kumactl install control-plane | kubectl apply -f -" #kumactl: not found
./kumactl install control-plane | kubectl apply -f -

# check the pods are up and running by getting all pods in the kuma-system namespace
kubectl get pods -n kuma-system

echo echo "Waiting for kuma-system to be ready "
for i in {1..60}; do # Timeout after 5 minutes, 60x5=300 secs
      # if kubectl get pods --namespace=kubeflow -l openebs.io/component-name=centraldashboard | grep Running ; then
      if kubectl get pods --namespace=kuma-system  | grep ContainerCreating ; then
        sleep 10
      else
        break
      fi
done
kubectl get pods -n kuma-system

# the control-plane in the cluster, delete the existing pods (or perform a rolling update) 
# so the injector can do its job.
kubectl delete pods --all -n kuma-demo

# kubectl get pods -n kuma-demo -w #hanging
kubectl get pods -n kuma-demo
echo echo "Waiting for kuma-demo to be ready "
for i in {1..60}; do # Timeout after 5 minutes, 60x5=300 secs
      # if kubectl get pods --namespace=kubeflow -l openebs.io/component-name=centraldashboard | grep Running ; then
      if kubectl get pods --namespace=kuma-demo  | grep ContainerCreating ; then
        sleep 10
      else
        break
      fi
done

# looks near identical except each pod now has an additional container. 
# The additional container is the Envoy sidecar proxy that the control-plane is automatically adding to each pod.
kubectl get pods -n kuma-demo

# access the front-end UI on http://localhost:8080, port-forward the frontend service 
# The marketplace application is now running with Kuma, 
# but will be identical to the version with Kuma
# The underlying difference is that all the services are now sending traffic to the Envoy dataplane within the same pod, 
# and the Envoy proxies will communicate to each other
kubectl port-forward service/frontend -n kuma-demo 8080 & #background job

# curl: (7) Failed to connect to localhost port 8080: Connection refused
# curl http://localhost:8080

# Tools kumactl Setup
# configure kumactl to point to any remote Kuma control-plane instance
# Before configuring  local kumactl to point to control-plane running in the 
# kuma-system namespace, port-forward the pod.

# port-forward the kuma-control-plane service in the kuma-system namespace
# 5681: the HTTP API server that is being used by kumactl to retrieve the state of your configuration and policies on every environment
kubectl port-forward service/kuma-control-plane -n kuma-system 5681 & #background job

# configure kumactl to point to the address where the HTTP API server runs
# ./kumactl config control-planes add --name=minikube --address=http://localhost:5681 #Get "http://localhost:5681": dial tcp 127.0.1.1:5681: connect: connection refused

# bash kumactl config control-planes add --name=minikube --address=http://localhost:5681 #kumactl: kumactl: cannot execute binary file

