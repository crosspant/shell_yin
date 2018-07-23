#!/bin/bash
# Updated 20180723 
# Shrew IKE VPN Connection Check file
date >> /var/log/ping-check.log
PING=`ping -c 1 -i 1 192.168.1.1|tee -a /var/log/ping-check.log |grep "100% packet loss"`
CHECK=`tail -1 /var/log/shrew-check.log|grep OK`
CHECKRT=`tail -1 /var/log/shrew-check.log|grep Reconnect`

if [ -z "$PING" ] ; then
#   if [ -z "$CHECK" ]; then
   if [ -n "$CHECKRT" ]; then
      /usr/sbin/sendmail -t -i '-fyin-test@xxx.co.jp' < /root/recover.txt
   fi
   echo "[Ping OK] : "`date`  >> /var/log/shrew-check.log 2>&1
else
   if [ -n "$CHECK" ]; then
      /usr/sbin/sendmail -t -i '-fyin@xxx.co.jp' < /root/alert.txt
   fi
   echo "[Ping NG] : "`date`  >> /var/log/shrew-check.log 2>&1
   echo "Challenge Reconnect"  >> /var/log/shrew-check.log 2>&1
   service shrew-connect stop
   service iked stop
   sleep 3
   service iked start
   service shrew-connect start
fi

