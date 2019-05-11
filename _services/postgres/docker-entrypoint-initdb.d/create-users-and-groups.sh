#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
  CREATE USER "application" LOGIN SUPERUSER PASSWORD 'password';
  CREATE DATABASE "resources";
  GRANT ALL PRIVILEGES ON DATABASE "resources" TO "application";
EOSQL
