#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================Creating PostgreSQL databases and users======================================================================"
su postgres

# Update pg_hba.conf to trust local peer connection
sed -i  '/^local   all             all                                     peer/ s/peer/trust/' /etc/postgresql/12/main/pg_hba.conf
cat /etc/postgresql/12/main/pg_hba.conf

# Restart Postgres to udpate conf
/etc/init.d/postgresql restart

# Create kumademo user 
sudo -u postgres psql -c "CREATE USER kumademo WITH SUPERUSER CREATEDB ENCRYPTED PASSWORD 'kumademo'"

# Create kumademo database
sudo -u postgres createdb kumademo

# Restore PostgreSQL data from dump file
sudo -u postgres psql -U kumademo -d kumademo -f /home/vagrant/kuma-demo/postgresql/database.sql
echo "===================Creating PostgreSQL databases and users finished======================================================================"