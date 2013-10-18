#!/bin/bash
read -p "Geben sie die die Identifikationszahl der aktuellsten Webmin Version ein z.B 1.650:" webminversion
echo "Installation von Webmin zur Systemüberwachung und der RAID konfiguration"
wget http://garr.dl.sourceforge.net/project/webadmin/webmin/${webminversion}/webmin_${webminversion}_all.deb
dpkg -i webmin_${webminversion}_all.deb
apt-get --force-yes install -f

read -p "Geben sie die die Identifikationszahl der aktuellsten Owncloud Version ein z.B 5.0.12:" owncloudversion
echo "Installation von Webserverkomponenten und OWNCLOUD"
apt-get --force-yes install apache2 php5 php5-gd php-xml-parser php5-intl
apt-get --force-yes install php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl
apt-get --force-yes install mysql-server mysql-client
cd /var/www
wget http://download.owncloud.org/community/owncloud-${owncloudversion}.tar.bz2
tar -xjf /var/www/owncloud-${owncloudversion}.tar.bz2

echo "Samba installation"
apt-get --force-yes install samba
echo "Benutzervorbereitung für den SAMBA gebrauch"
useradd nas
passwd nas
usermod -aG www-data nas
smbpasswd -a nas
chmod 774 /var/www/owncloud/data/nas/files
rm /etc/samba/smb.conf
cp ./smb.conf /etc/samba
service samba restart

echo "RAID System Installation für spätere Implementation"
apt-get --force-yes install mdadm
