#!/bin/sh

PIDS=$(ps | grep "/usr/bin/wifidog" | grep -v "grep" | wc -l)
if [ "$PIDS" != 1 ] ; then
logger -t "wifidog" "wifidog服务not runing~"
else
/usr/bin/wifidog.sh restart
logger -t "wifidog" "重启wifidog服务完成！！！"
fi
