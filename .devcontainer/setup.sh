#!/bin/bash

# Instala PostgreSQL Client (para psql)
sudo apt-get update && sudo apt-get install -y postgresql-client

# Configura PostgreSQL
sudo -u postgres psql <<-EOSQL
  CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';
  CREATE DATABASE ${POSTGRES_DB};
  GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};
EOSQL

# Configura Python (Django)
python -m venv /home/codespace/.venv
source /home/codespace/.venv/bin/activate
pip install django psycopg2-binary
