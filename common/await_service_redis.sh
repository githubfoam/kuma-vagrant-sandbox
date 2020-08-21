#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================waiting for service======================================================================"
export SERVICE_URL="http://localhost:9901/ready"
echo $SERVICE_URL

if [ -z "${SERVICE_URL}" ]; then
  echo "Error: environment variable SERVICE_URL is not set"
  exit 1
fi

# Wait for service to start
for i in `seq 1 180`; do
    echo "try #$i: "
    if curl --silent --show-error --fail ${SERVICE_URL} ; then
        exit 0
    fi
    sleep 1
done
exit 1

echo "===================waiting for service finished======================================================================"