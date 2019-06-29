#!/bin/bash

set -e

createuser --host=$POSTGRES_HOST --username=$POSTGRES_USERNAME application
createdb --host=$POSTGRES_HOST --username=$POSTGRES_USERNAME --owner=application resources
