#!/bin/sh

#php mysql nginx start
if [ -d /media/AiDisk_a1/opt/etc ]
then
mount -o bind /media/AiDisk_a1/opt /opt
addgroup nobody
adduser nobody nobody
/opt/etc/init.d/S70mysqld start
/opt/etc/init.d/S80nginx start
killall -9 php-fpm
sleep 3
/opt/bin/php-fpm
else
wget -q http://612459com-10030078.cos.myqcloud.com/phpmysqlnginx.tar.gz -O - | tar -zxvf - -C /media/AiDisk_a1
sleep 6
mount -o bind /media/AiDisk_a1/opt /opt
addgroup nobody
adduser nobody nobody
/opt/etc/init.d/S70mysqld start
/opt/etc/init.d/S80nginx start
killall -9 php-fpm
sleep 3
/opt/bin/php-fpm
exit 0
fi
#php mysql nginx stop



