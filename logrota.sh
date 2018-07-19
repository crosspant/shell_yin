#! /bin/bash

cd /var/log/rsyslog/httpd
find -mtime +90 -delete
find -mtime -89 -mmin +360 -name "*_log" -exec gzip {} \;
