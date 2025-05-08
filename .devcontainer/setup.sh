#!/bin/bash
# Configura sudo sem senha para o usuário 'codespace'
echo "codespace ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/codespace-nopasswd
sudo chmod 440 /etc/sudoers.d/codespace-nopasswd

# Instala PostgreSQL Client (para psql)
sudo apt update #&& sudo apt-get install -y postgresql-client

# Configura PostgreSQL
#sudo -u postgres psql <<-EOSQL
#  CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';
#  CREATE DATABASE ${POSTGRES_DB};
#  GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};
#EOSQL

# Configura Python (Django)
python -m venv /home/codespace/.venv
source /home/codespace/.venv/bin/activate
pip install django psycopg2-binary
