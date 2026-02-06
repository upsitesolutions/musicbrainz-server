#!/usr/bin/env bash
set -u
set -o errexit

MB_SERVER_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$MB_SERVER_ROOT"

: "${DATABASE:=MAINTENANCE}"

echo "$(date) : Applying local override schema (admin/sql/local_overrides.sql) on DB '$DATABASE'"

./admin/psql "$DATABASE" < ./admin/sql/local_overrides.sql

echo "$(date) : Done applying local override schema"
