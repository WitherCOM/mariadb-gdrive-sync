#!/bin/bash

rm /backup/*.sql

# READ ALL DATABASES AND DUMP THEM INTO FILES
dbs=($(mariadb -h$HOSTNAME -u$USERNAME -p$PASSWORD --skip_ssl -s -r -e 'SHOW DATABASES;'))
for i in "${dbs[@]}"; do
  # IGNORE SYSTEM DATABASES
  if [ $i != "information_schema" ] && [ $i != "performance_schema" ] && [ $i != "mysql" ] && [ $i != "sys" ]; then
    echo "Dumping $i ..."
    mariadb-dump --max_allowed_packet=512M --skip_ssl -h$HOSTNAME -u$USERNAME -p$PASSWORD $i >/backup/$i".sql"
  fi
done

rclone copy /backup/* gdrive:$(date +%F)/
rm /backup/*.sql
