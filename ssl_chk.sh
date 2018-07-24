#! /bin/bash

UserParameter=ssl_chk[*],/usr/lib/zabbix/externalscripts/ssl_check.sh $1

SSL_LIMIT=`openssl s_client -connect $1:443 2>&1 < /dev/null |openssl x509 -enddate | grep ^notAfter | cut -c 10-33`
expr \( `date -d "$SSL_LIMIT" +%s` - `date +%s` \)

