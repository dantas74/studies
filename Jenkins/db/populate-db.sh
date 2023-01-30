#!/bin/bash

DB_PASSWORD=$1

COUNTER=0

while [ $COUNTER -lt 50 ]; do
  (( COUNTER++ )) || true

  NAME=$(nl people.txt | grep -w "$COUNTER" | awk '{print $2}' | awk -F ',' '{print $1}')
  LAST_NAME=$(nl people.txt | grep -w "$COUNTER" | awk '{print $2}' | awk -F ',' '{print $2}')
  AGE=$(shuf -i 20-25 -n 1)
  mysql -u root -p"$DB_PASSWORD" people -e "INSERT INTO register VALUES ($COUNTER, '$NAME', '$LAST_NAME', $AGE)"
done
