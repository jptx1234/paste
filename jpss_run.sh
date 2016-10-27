#!/bin/bash

rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/rhel7/x86_64/city-fan.org-release-1-13.rhel7.noarch.rpm >/dev/null
yum install -y httpd curl nss jq bind-utils >/dev/null
wget -O /var/www/html/index.html https://raw.githubusercontent.com/jptx1234/paste/master/jpss_index.html
wget -O /var/www/cgi-bin/info.sh https://raw.githubusercontent.com/jptx1234/paste/master/info.sh
chmod 777 /var/www/cgi-bin/info.sh
wget -O /etc/httpd/conf/httpd.conf https://raw.githubusercontent.com/jptx1234/paste/master/httpd.conf
httpd
sleep 365d
