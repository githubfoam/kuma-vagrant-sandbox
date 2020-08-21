#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================Configure `kumactl` for current user======================================================================"

kumactl config control-planes add --name=universal --address=http://kuma-cp:5681 --overwrite

echo "===================Configure `kumactl` for current user finished======================================================================"