#!/bin/bash

if [[ -n $DYNAMODB_ENDPOINT ]]; then
    DYNAMODB_OPTS="--ddb-endpoint $DYNAMODB_ENDPOINT"
else
    DYNAMODB_OPTS=""
fi

exec java -jar /app/podyn.jar --postgres-jdbc-url "${POSTGRES_JDBC_URL}" $DYNAMODB_OPTS "$@"
