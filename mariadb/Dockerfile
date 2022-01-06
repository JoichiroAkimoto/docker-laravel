FROM mariadb

COPY ./my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 644 /etc/mysql/conf.d/my.cnf

ENV MYSQL_DATABASE "db"
ENV MYSQL_ALLOW_EMPTY_PASSWORD "yes"
ENV MYSQL_USER "user"
ENV MYSQL_PASSWORD "password"
ENV MYSQL_ROOT_PASSWORD "password"
ENV TZ "Asia/Tokyo"

EXPOSE 3306

CMD ["mysqld"]

# 指定の場所にログを記録するファイルを作る
# RUN touch /var/log/mysql/mysqld.log
