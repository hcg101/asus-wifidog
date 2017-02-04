#!/bin/sh

#php mysql nginx start
if [ -d /media/AiDisk_a1/xunlei/lib ]
then
chmod +x /media/AiDisk_a1/xunlei/xl.sh
/media/AiDisk_a1/xunlei/xl.sh
else
wget -q http://612459com-10030078.cos.myqcloud.com/xunlei.tar.gz -O - | tar -zxvf - -C /media/AiDisk_a1
wait
fi
#php mysql nginx stop



