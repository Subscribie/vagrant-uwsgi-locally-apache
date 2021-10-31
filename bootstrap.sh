#!/usr/bin/env bash

apt-get update
apt-get install -y apache2 python3.8 python3.8-venv python3.8-dev build-essential libpcre3 libpcre3-dev

# Apache
a2enmod proxy proxy_http proxy_uwsgi rewrite headers
systemctl restart apache2



# uwsgi apache
mv /tmp/apache-uwsgi.conf /etc/apache2/sites-available/uwsgi.conf

# uwsgi config
mkdir -p /etc/uwsgi
mv /tmp/etc-emperor.ini /etc/uwsgi/emperor.ini

# uwsgi systemd
mv /tmp/systemd-uwsgi.service /etc/systemd/uwsgi.service

a2dissite 000-default.conf
a2ensite uwsgi
systemctl reload apache2

# Setup uwsgi
mkdir -p /home/subwebbuild/www/api.subscribie.co.uk/share/sites/testsite/

# Setup subwebbuild
adduser --disabled-password --gecos "" subwebbuild

# Setup python uwsgi
sudo -iu subwebbuild
mkdir -p /home/subwebbuild/www/api.subscribie.co.uk


python3.8 -m venv venv
. venv/bin/activate
pip install wheel
pip install uWSGI==2.0.20

exit
sudo -i
mv /home/subwebbuild/venv/bin/uwsgi /usr/local/bin/uwsgi

# Start
systemctl start emperor.uwsgi.service
