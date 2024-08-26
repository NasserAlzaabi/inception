FROM alpine:3.19

RUN apk update && \
    apk upgrade && \
	apk add mariadb mariadb-client gettext

RUN mkdir -p /var/lib/mysql /run/mysqld

RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld

WORKDIR /var/lib/mysql

COPY ./conf/init_sql.sql .
COPY ./tools/db_service_start.sh .

RUN chmod 755 db_service_start.sh

EXPOSE 3306

ENTRYPOINT ["./db_service_start.sh"]