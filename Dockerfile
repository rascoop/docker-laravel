FROM php:7-fpm
MAINTAINER Richard Scoop <richard.scoop@gmail.com>

RUN apt-get update -qq && apt-get install -y -qq libmcrypt-dev mysql-client git curl wget\
    && docker-php-ext-install mcrypt pdo_mysql && apt-get upgrade -y

# Install composer
RUN bash -c "wget http://getcomposer.org/composer.phar && mv composer.phar /usr/local/bin/composer"


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