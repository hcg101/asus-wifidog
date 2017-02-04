#!/bin/sh


    PIDS=$(ps | grep "ssr-tunnel" | grep -v "grep" | wc -l)
    if [ "$PIDS" != 1 ] ; then
logger -t "ss" "ss服务not runing~~~"
else
modprobe ip_set_hash_ip
modprobe xt_set
modprobe ipt_REDIRECT
ipset create gfwlist hash:ip
/etc/storage/shadowsocksr/ssr-restart
iptables -t nat -I PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1080
iptables -t nat -I OUTPUT -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1080
logger -t "ss" "由于防火墙规则重新配置、重启ss服务完成！！！"
fi
