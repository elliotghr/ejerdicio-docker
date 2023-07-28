#!/bin/bash

# INSTALAR PROYECTO
if ! [ -d "/var/www/html/project" ]; then
    cd /var/www/html
    composer create-project codeigniter4/appstarter project
    cd /var/www/html/project
    cp env .env
fi

# INSTALAR VENDOR
if ! [ -d "/var/www/html/project/vendor" ]; then
    cd /var/www/html/project
    composer install --no-dev
fi

# MODIFICAR PERMISOS DE WRITABLE
chmod 777 -R /var/www/html/project/writable

# INICIAR APACHE EN SEGUNDO PLANO
apache2-foreground
