#!/bin/sh
#

WD_DIR=/usr/bin
OPTIONS="-config=/etc/storage/ngrok/ngrok.conf"
#开关
ngrok_enable=`nvram get ngrok_enable`


#认证服务器
ngrok_Hostname=`nvram get ngrok_Hostname`
[ -z $ngrok_Hostname ] && ngrok_Hostname="ngrok.runs.xyz" && nvram set ngrok_Hostname=$ngrok_Hostname

ngrok_userid=`nvram get ngrok_userid`
[ -z $ngrok_userid ] && ngrok_userid="yc" && nvram set ngrok_userid=$ngrok_userid

ngrok_HTTPPort=`nvram get ngrok_HTTPPort`
[ -z $ngrok_HTTPPort ] && ngrok_HTTPPort="4443" && nvram set ngrok_HTTPPort=$ngrok_HTTPPort

ngrok_password=`nvram get ngrok_password`
[ -z $ngrok_password ] && ngrok_password="5214201Hcg" && nvram set ngrok_password=$ngrok_password

ngrok_lanif=`nvram get ngrok_lanif`
[ -z $ngrok_lanif ] && ngrok_lanif=$(nvram get lan_ipaddr) && nvram set ngrok_lanif=$ngrok_lanif

ngrok_domain=`nvram get ngrok_domain`
[ -z $ngrok_domain ] && ngrok_domain="login.yc" && nvram set ngrok_domain=$ngrok_domain


case "$1" in
  start)

{
rm -f /etc/storage/ngrok/ngrok.conf  
# 将数值赋给ngrok官方的配置参数               
echo "
server_addr: $ngrok_Hostname:$ngrok_HTTPPort
trust_host_root_certs: false
inspect_addr: disabled
auth_token: $ngrok_userid
password: $ngrok_password
tunnels:
ssh:
remote_port: 22223
proto:
tcp: $ngrok_lanif:22
login:
remote_port: 22225
proto:
http: $ngrok_lanif:888
web:
remote_port: 22226
proto:
http: $ngrok_lanif:808
" >> /etc/storage/ngrok/ngrok.conf
}


    
   
	$WD_DIR/ngrok -log=stdout $OPTIONS  -subdomain=$ngrok_domain  -proto=http `nvram get http_lanport` > /dev/null  2>&1  &
logger -t "ngrok" "Ngrok client runing~"

    ;;
  restart)
    $0 stop
    sleep 2
    $0 start
    ;;
  reload)
    $0 stop
    sleep 2
    $0 start
    ;;
  stop)

    killall -9 ngrok
rm -fr /etc/storage/ngrok/ngrok.conf
logger -t "ngrok" "Ngrok client stoped"
    ;;
  

  *)
   echo "Usage: $0 {start|stop}"
   exit 1
   ;;
esac





