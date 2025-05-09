#!/bin/bash
# Configura sudo sem senha para o usuário 'codespace'
echo "codespace ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/codespace-nopasswd
sudo chmod 440 /etc/sudoers.d/codespace-nopasswd

# Instala PostgreSQL Client (para psql)
sudo apt update #&& sudo apt-get install -y postgresql-client
sudo apt-get install -y postgresql postgresql-client

# Configura PostgreSQL
#sudo -u postgres psql <<-EOSQL
#  CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';
#  CREATE DATABASE ${POSTGRES_DB};
#  GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};
#EOSQL

# Configura Python (Django)
pip install --upgrade
python -m venv /home/codespace/.venv
source /home/codespace/.venv/bin/activate
pip install django psycopg2-binary

# frontend React
cd /workspaces/static-site/
yes | npx create-react-app frontend
cd frontend
##### && npm start &

# Backend Django
cd /workspaces/static-site/
django-admin startproject backend
cd backend && python manage.py migrate
##### && python manage.py runserver &


# ------------------------------------------------------------
#    Configuração Manual do PostgreSQL Pós Instalação
# ------------------------------------------------------------
#service --status-all
#sudo nano /etc/postgresql/17/main/pg_hba.conf
#       Adicionar -->  local   all   postgres   trust
#sudo service postgresql stop
#sudo -u postgres /usr/lib/postgresql/17/bin/postgres --single -D /etc/postgresql/17/main/
#         backend> ALTER USER postgres WITH PASSWORD 'Quick@2025';
#         CTRL+D  <-- Para sair, pois \q não funcionou
#sudo service postgresql restart
#psql -U postgres -h localhost
#
# CREATE USER gpp_user WITH PASSWORD 'Quick@2025';
# CREATE DATABASE gpp_homolog;
# GRANT ALL PRIVILEGES ON DATABASE gpp_homolog TO gpp_user;
# ------------------------------------------------------------