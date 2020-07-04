#! /bin/sh
source ../.env
FILE=/etc/resolv.conf
if test -f "./$MYSQL_IMPORT_FILE"; then
    mysql -u admin -p  $MYSQL_DATABASE < ./$MYSQL_IMPORT_FILE
fi

