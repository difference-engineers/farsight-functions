#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "template1" <<-EOSQL
  BEGIN;
    CREATE EXTENSION IF NOT EXISTS "citext";
    CREATE EXTENSION IF NOT EXISTS "pgcrypto";
    CREATE EXTENSION IF NOT EXISTS "cube";
    CREATE EXTENSION IF NOT EXISTS "btree_gin";
    CREATE EXTENSION IF NOT EXISTS "btree_gist";
    CREATE EXTENSION IF NOT EXISTS "hstore";
    CREATE EXTENSION IF NOT EXISTS "isn";
    CREATE EXTENSION IF NOT EXISTS "ltree";
    CREATE EXTENSION IF NOT EXISTS "lo";
    CREATE EXTENSION IF NOT EXISTS "fuzzystrmatch";
    CREATE EXTENSION IF NOT EXISTS "pg_buffercache";
    CREATE EXTENSION IF NOT EXISTS "pgrowlocks";
    CREATE EXTENSION IF NOT EXISTS "pg_prewarm";
    CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
    CREATE EXTENSION IF NOT EXISTS "pg_trgm";
    CREATE EXTENSION IF NOT EXISTS "tablefunc";
  COMMIT;
EOSQL
psql -v --username "postgres" --dbname "template1" <<-EOSQL
  DROP DATABASE IF EXISTS "resources";
  CREATE DATABASE "resources";
  GRANT ALL PRIVILEGES ON DATABASE "resources" TO "postgres";
EOSQL