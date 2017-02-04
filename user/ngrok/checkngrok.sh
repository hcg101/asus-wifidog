#!/bin/sh


    PIDS=$(nvram get ngrok_enable)
    if [ "$PIDS" != 1 ] ; then
logger -t "ngrok" "Ngrok clinet not runing~~~"
else
/usr/bin/ngrok.sh start 
logger -t "ngrok" "Ngrok clinet  started~~~"
fi
