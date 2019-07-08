#!/bin/sh

counter=0

PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -h $POSTGRES_HOST < init/input.txt
while [ $? -ne 0 ]
do
  if [ $counter -eq 3 ]
  then
    echo "Reached maximum retries, exiting..."
    exit 1
  fi 

  echo "Trying again..."

  counter=$(($counter + 1))
  sleep 15
  PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -h $POSTGRES_HOST < init/input.txt
done

echo "PostgreSQL started!"
