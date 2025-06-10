#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h 127.0.0.1 -uroot -pmariadb --silent; do
  >&2 echo "MariaDB is unavailable - sleeping"
  sleep 1
done
echo "MariaDB is up and running!"

# Execute the setup script
mysql -h 127.0.0.1 -uroot -pmariadb < .devcontainer/setup-mariadb.sql

# Set DBT_PROFILES_DIR (if needed)
echo 'export DBT_PROFILES_DIR="/workspace"' >> ~/.bash_profile