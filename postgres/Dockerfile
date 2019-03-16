FROM postgres:alpine

COPY ./db.sql  /docker-entrypoint-initdb.d/10-db.sql
COPY ./create_users.sh  /docker-entrypoint-initdb.d/20-init_db.sh
