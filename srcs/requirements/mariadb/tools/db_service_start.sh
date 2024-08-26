#!/bin/sh

#data directory
DATA="/var/lib/mysql"
MYSQL_OPTIONS="--user=mysql --skip-name-resolve --skip-networking=0 --bind-address=0.0.0.0"
# initialize a db directory
if ! mysql_install_db --user=mysql --datadir=$DATA > /dev/null ; then
    echo "failed to initialize a db directory ...."
    return 1
fi

# env value substitution -- resolution
envsubst < init_sql.sql > tmp_init_sql.sql

# feed it to the mysql server
mysqld $MYSQL_OPTIONS --bootstrap < tmp_init_sql.sql

# delete tmp file coz username and password is exposed
rm tmp_init_sql.sql

# run server -- listens for conneciton
mysqld $MYSQL_OPTIONS --console