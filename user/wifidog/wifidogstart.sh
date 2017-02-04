#!/bin/sh

#php mysql nginx start
killall -9 wifidog
/usr/bin/wifidog &

iptables -t filter -A  WiFiDog_br0_AuthServers -d wifi.weixin.qq.com -j ACCEPT
	iptables -t nat -A WiFiDog_br0_AuthServers  -d wifi.weixin.qq.com -j ACCEPT
}

#php mysql nginx stop





