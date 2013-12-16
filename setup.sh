#!/bin/bash
read -p "Wat is de laaste nieuwe versie van Webmin (www.webmin.com)? Vb: 1.660" webminversion
echo "Webmin installeren voor systeem beheer en monitoring"
wget http://garr.dl.sourceforge.net/project/webadmin/webmin/${webminversion}/webmin_${webminversion}_all.deb
dpkg -i webmin_${webminversion}_all.deb
apt-get --force-yes install -f

read -p "Wat is de laatste nieuwe versie van OwnCloud (www.owncloud.org)? Vb: 6.0.0a" owncloudversion
echo "Webserver, php, database en OwnCloud installeren"
apt-get --force-yes install apache2 php5 php5-gd php-xml-parser php5-intl
apt-get --force-yes install php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl
apt-get --force-yes install mysql-server mysql-client
cd /var/www
wget http://download.owncloud.org/community/owncloud-${owncloudversion}.tar.bz2
tar -xjf /var/www/owncloud-${owncloudversion}.tar.bz2

echo "Samba installeren"
apt-get --force-yes install samba
echo "Server configureren"
useradd nas
passwd nas
usermod -aG www-data nas
smbpasswd -a nas
chmod 774 /var/www/owncloud/data/nas/files
rm /etc/samba/smb.conf
cp ./smb.conf /etc/samba
service samba restart