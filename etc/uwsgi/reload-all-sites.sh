#!/bin/bash

cd /home/subwebbuild/www/api.subscribie.co.uk
killall -9 uwsgi ; uwsgi --ini config.ini
