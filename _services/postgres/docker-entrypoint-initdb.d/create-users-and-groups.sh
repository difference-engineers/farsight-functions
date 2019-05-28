#!/bin/bash

set -e

createuser --host=$DATABASE_HOST --username=$POSTGRES_USERNAME application
createdb --host=$DATABASE_HOST --username=$POSTGRES_USERNAME --owner=application resources
