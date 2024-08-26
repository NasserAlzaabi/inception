FLUSH PRIVILEGES;
-- database sertup best practices
-- clean everything that comes as a default
DELETE FROM mysql.user WHERE user='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test';

-- Security best practices
-- remove root remote access.
-- change the root password for the localhost
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');

-- creating new Database, new user (with its password), grating this user full privilege eate new database, 
CREATE DATABASE IF NOT EXISTS `$MARIADB_DATABASE`;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON `$MARIADB_DATABASE`.* TO '$MARIADB_USER'@'%';

-- and reloading the privilege table so the change can be reflected imidiately
FLUSH PRIVILEGES;

-- SQL commands
    -- 1. mysql
    -- 2. show databases;  # to go inside mariadb to see all dbs
    -- 3. use our_db;      # to go inside our desired db
    -- 4. show tables;     # to see all tables inside our desired db
    -- 5, select * wp_users;  # see all wp users