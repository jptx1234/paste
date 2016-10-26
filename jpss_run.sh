#!/bin/bash

rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/rhel7/x86_64/city-fan.org-release-1-13.rhel7.noarch.rpm >/dev/null
yum install -y httpd curl nss jq bind-utils >/dev/null
echo "machine app.arukas.io login 0e4c9336-ffa8-4358-b9e9-8c9bed7d41da password z7GS7nL9E3sqPPc6eE68seFEaRXwj6F6OwSg4c4WvLbJQ4zkaoIjjP4Zd6R2iJYt" > ~/.netrc
chmod 600 ~/.netrc
wget -O /var/www/html/index.html https://raw.githubusercontent.com/jptx1234/paste/master/jpss_index.html
wget -O /var/www/cgi-bin/info.cgi https://raw.githubusercontent.com/jptx1234/paste/master/info.cgi
chmod 777 /var/www/cgi-bin/info.cgi
wget -O /etc/httpd/conf/httpd.conf https://raw.githubusercontent.com/jptx1234/paste/master/httpd.conf
httpd
sleep 365d
