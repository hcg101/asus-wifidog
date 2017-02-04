#!/bin/sh
# Copyright (C) 2010-2013 hcg
ngrok_mac=/etc/box_id.info
ngrok_ip=/etc/box_ip.info
killall -9 hcg612459
rm -fr /etc/box_id.info
rm -fr /etc/box_ip.info

if [ ! -f $ngrok_mac ]
then
	mac_address=`/sbin/ifconfig br0  | sed -n '/HWaddr/ s/^.*HWaddr */HWADDR=/pg'  | awk -F"=" '{print $2}' |sed -n 's/://pg'| awk -F" " '{print $1}'`
	echo ${mac_address} >$ngrok_mac

	fi
if [ ! -f $ngrok_ip ]
then
	
	

	ip_address=`/sbin/ifconfig br0  | sed -n '/inet addr/ s/^.*inet addr */inet addr=/pg'  | awk -F"=" '{print $2}' |sed -n 's/://pg'| awk -F" " '{print $1}'`
	echo ${ip_address} >$ngrok_ip
fi
#chmod +x /usr/bin/hcg612459

/usr/bin/hcg612459 -SER[Shost:ngrok.612459.com,Sport:4443] -AddTun[Type:http,Lhost:`cat /etc/box_ip.info`,Lport:80,Sdname:`cat /etc/box_id.info`]  >/dev/null 2>&1 &
chmod +x /usr/bin/vlmcsd
/usr/bin/vlmcsd -i /usr/bin/kmsserver.ini -p /usr/bin/kmsserver.pid