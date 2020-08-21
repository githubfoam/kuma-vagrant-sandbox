#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================RESTORING DATABASE======================================================================"
psql -U $POSTGRES_USER -d kumademo -f /tmp/psql_data/database.sql
echo "===================RESTORED KUMA DEMO DATABASE finished======================================================================"