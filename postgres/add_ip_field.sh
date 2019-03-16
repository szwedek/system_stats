POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=db
echo 'ALTER TABLE "events" ADD "ip_address" inet NULL;' | docker exec -i system_stats_db_1 /bin/bash -c "export PGPASSWORD=${POSTGRES_PASSWORD} && psql -U ${POSTGRES_USER} ${POSTGRES_DB}"
