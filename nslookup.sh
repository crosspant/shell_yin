#! /bin/bash

# nslookupコマンドを実行し、IPアドレス表示
nslookup www.yahoo.co.jp |grep "Address" |grep -v "#53" |cut -d" " -f2 |sort
