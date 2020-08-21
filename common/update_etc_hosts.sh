#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "======================update hosts==================================================================="

if [ -z "${KUMA_CONTROL_PLANE_IP}" ]; then
  echo "Error: environment variable KUMA_CONTROL_PLANE_IP is not set"
  exit 1
fi

# echo "
# ${KUMA_CONTROL_PLANE_IP} kuma-cp
# " >> /etc/hosts

echo "
${KUMA_CONTROL_PLANE_IP} kuma-cp
${FRONTEND_IP} frontend
${BACKEND_IP} backend
${BACKEND_V1_IP} backend-v1
${POSTGRESQL_IP} postgresql
${REDIS_IP} redis
${KONG_IP} kong
${METRICS_IP} metrics
" >> /etc/hosts

echo "=======================update hosts finished=================================================================="


  echo "===================================================================================="
                        hostnamectl status
  echo "===================================================================================="
  echo "         \   ^__^                                                                  "
  echo "          \  (oo)\_______                                                          "
  echo "             (__)\       )\/\                                                      "
  echo "                 ||----w |                                                         "
  echo "                 ||     ||                                                         "
  echo "===================================================================================="