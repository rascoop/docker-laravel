# docker-laravel
Docker definition for Laravel Development. 
This is an attempt to make development using docker simple by having most of the needed stuff inside the php container.
This image is now based on alpine linux and has extensions for SQLite, MySQL, MariaDB and Postgresql 
Xdebug is also installed
##Build
The simplest way to use this Docker definition is to build the image:
<code>docker build .</code>

You can also build the image and include a tag to make it easier to find like so:
<code>docker build -t \<dockhubname\>/php-fpm-laravel:latest .</code>

##Use
The best way to use this image is with other images.


As it does not have a webserver nor a database server, use it as part of a group.
Check the docker-compose.yml in this repository. The necessary mysql drivers are installed. But if you are planning in using anything else please feel free to fork and change.

When running composer or php artisan you need to do it from the php container. You can go to the container by: <code>docker exec -ti appnamephp /bin/bash</code>
Once inside the container, you can run composer by <code>php /usr/local/bin/composer</code>
You can also run this without being in the container's terminal by running composer or artisan like so: <code>docker exec appnamephp php /usr/local/bin/composer</code> or <code>docker exec appnamephp php artisan</code>

One thing that you need to be aware is that whenever you run any of those commands, you need to run <code>sudo chmod -R yourusername:yourusername ./src/*</code>.
The reason for this is that when inside the container the commands are run as root and therefore owned by root.
 
Hope this helps you setup a development environment faster. 

###xdebug
To enable xdebug please mount a volume that points to <code>/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini</code>
