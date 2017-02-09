FROM php:7-fpm
MAINTAINER Richard Scoop <richard.scoop@gmail.com>

RUN apt-get update && apt-get install -y libmcrypt-dev mysql-client \
    && docker-php-ext-install mcrypt pdo_mysql
RUN apt-get upgrade -y

#The following lines allows the first user of the host
#to remain the owner of the files while they are shared with the container
#1000 is the uid and gid of the host user, change if yours is not 1000
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
#RUN find / -user 33 -exec chown -h 1000 {} \;
#RUN find / -group 33 -exec chgrp -h 1000 {} \;
RUN usermod -g 1000 www-data

RUN apt-get purge -y --auto-remove
RUN apt-get clean

WORKDIR /var/www