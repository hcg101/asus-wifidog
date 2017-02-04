#!/bin/sh
#
sleep 6
ls -l /dev | awk '/^brw/ {print $NF}' | grep mmcblk0 > /tmp/mmc.txt
if [ -s /tmp/mmc.txt ]  ; then
mmci=0
while read line
do
    mmci=$(($mmci+1))
    /sbin/automount.sh $line AiCard_0$mmci
    logger -t "Automount" AiCard_0$mmci
mkdir -p /media/AiDisk_a1/
ln -sf  /media/AiCard_0$mmci /media/AiDisk_a1
ln -sf  /media/AiCard_0$mmci/* /media/AiDisk_a1/
mount -o bind /media/AiDisk_a1/AiCard_0$mmci/opt /opt
done < /tmp/mmc.txt
sleep 2
stop_ftpsamba
sleep 2
run_ftpsamba
fi



