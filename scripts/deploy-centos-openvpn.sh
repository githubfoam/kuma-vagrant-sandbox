#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===========deploy openvpn================="

echo "Preparing OpenVPN 2 build environment"
yum -y install lzo-devel openssl-devel pam-devel pkcs11-helper-devel gnutls-devel autoconf libtool make cmake git net-tools

echo "Preparing OpenVPN 3 build enviroment"
yum install -y epel-release
yum install -y mbedtls-devel glib2-devel \
             jsoncpp-devel libuuid-devel \
             lz4-devel gcc-c++ git autoconf \
             automake make pkgconfig fping
echo "===========deploy openvpn finished================="