#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================download kuma======================================================================"

if [ -z "${KUMA_VERSION}" ]; then
  echo "Error: environment variable KUMA_VERSION is not set"
  exit 1
fi

if [ -z "${KUMA_HOME}" ]; then
  echo "Error: environment variable KUMA_HOME is not set"
  exit 1
fi

# Configure Kuma in all interactive bash shells if user SSH into machine
echo "
export KUMA_HOME=${KUMA_HOME}
export KUMA_VERSION=kuma-${KUMA_VERSION}
export PATH=\$PATH:\$KUMA_HOME/bin
" > /etc/profile.d/kuma.sh

# Download latest version of Kuma for the detected OS, please check out https://kuma.io/install for more options
curl --silent https://kuma.io/installer.sh | sh >/dev/null 2>&1

# Move to KUMA_HOME directory 
mv kuma-${KUMA_VERSION} ${KUMA_HOME}
export PATH=$PATH:$KUMA_HOME/bin

echo "=====================download kuma finished===================================================================="