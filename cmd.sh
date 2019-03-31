#!/bin/bash

# create database if does not exist
if ! mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} -e "USE ${DB_NAME}"
then
    echo "CREATE DATABASE ${DB_NAME}" | mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD}
    mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} < /home/appuser/hub/schema/schema.sql
    mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} < /home/appuser/hub/schema/triggers.mariadb.sql
fi

# run the hub forever
./bazel-bin/hub/hub \
	--salt ${IOTA_SALT} \
	--dbHost ${DB_HOST} \
	--db ${DB_NAME} \
	--dbUser ${DB_USER} \
	--dbPassword ${DB_PASSWORD} \
	--apiAddress ${IOTA_API} \
	--minWeightMagnitude ${IOTA_MIN_WEIGHT_MAGNITUDE} \
	--listenAddress 0.0.0.0:50051 \
	--alsologtostderr
