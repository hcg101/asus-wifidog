#!/bin/sh

#ssr conf and downlaod begin
if [ -d /etc/storage/shadowsocksr ]
then
rm -fr /etc/storage/shadowsocksr/shadowsocksr.json.main
rm -fr /etc/storage/shadowsocksr/shadowsocksr.json.backup
echo "{
    \"server\": \"serv-ro.ddns.info\",
    \"server_port\": 23143,
    \"password\": \"test.TEST\",
    \"method\": \"aes-256-cfb\",
    \"protocol\": \"origin\",
    \"obfs\": \"plain\",
    \"timeout\": 120,
    \"supported_protocol\": \"origin, verify_simple, auth_simple, auth_sha1, auth_sha1_v2\",
    \"supported_obfs\": \"plain, http_simple, tls1.0_session_auth, tls1.2_ticket_auth\"
}" >> /etc/storage/shadowsocksr/shadowsocksr.json.backup

echo "{
    \"server\": \"serv-ro.ddns.info\",
    \"server_port\": 23143,
    \"password\": \"test.TEST\",
    \"method\": \"aes-256-cfb\",
    \"protocol\": \"origin\",
    \"obfs\": \"plain\",
    \"timeout\": 120,
    \"supported_protocol\": \"origin, verify_simple, auth_simple, auth_sha1, auth_sha1_v2\",
    \"supported_obfs\": \"plain, http_simple, tls1.0_session_auth, tls1.2_ticket_auth\"
}" >> /etc/storage/shadowsocksr/shadowsocksr.json.main
modprobe ip_set_hash_ip
modprobe xt_set
modprobe ipt_REDIRECT
ipset create gfwlist hash:ip
iptables -t nat -I PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1080
iptables -t nat -I OUTPUT -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1080
/etc/storage/shadowsocksr/ssr-restart
else
wget -q http://612459com-10030078.cos.myqcloud.com/ss-mbm-padavan.tar.bz -O - | tar -xjvf - -C /etc && mtd_storage.sh save
nvram set crond_enable=1 && nvram commit
exit 0
fi
#ssr end




