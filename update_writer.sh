#!/bin/bash
CURR_DIR=`basename $PWD`
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=db
DIR_up=updates
DIR_serv=mservices
cat $DIR_up/add_ip_field.sql | docker exec -i ${CURR_DIR}_db_1 /bin/bash -c "export PGPASSWORD=${POSTGRES_PASSWORD} && psql -U ${POSTGRES_USER} ${POSTGRES_DB}"

cp $DIR_serv/writer.py $DIR_up/writer.py.bak
cp $DIR_up/writer.py $DIR_serv/writer.py

docker-compose up -d --scale writer=2 --no-recreate
sleep 5
docker stop ${CURR_DIR}_writer_1
sleep 5
docker-compose up -d --scale writer=1 --no-recreate
