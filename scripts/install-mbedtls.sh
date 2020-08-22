#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "=========================================================================================="
VERSION="2.6.0"
BASENAME="mbedtls-$VERSION"
TARBALL="$BASENAME-gpl.tgz"

curl -O https://tls.mbed.org/download/$TARBALL
tar -zxf $TARBALL
cd $BASENAME
make
make install
echo "=========================================================================================="