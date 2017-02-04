#!/bin/sh
#
# Could be better, but it's working as expected
#
# 
#
# chkconfig: 345 65 35
#
# description: Startup/shutdown script for wifidogcaptive portal
# processname: wifihct

# Date    : 2004-08-25
# Version : 1.0

IPT=/usr/sbin/iptables
WD_DIR=/usr/bin
OPTIONS=" -c /etc/storage/wifidog/wifidog.conf"
#开关
wifidog_enable=`nvram get wifidog_enable`
wifidog_Daemon=`nvram get wifidog_Daemon`


#认证服务器
wifidog_Hostname=`nvram get wifidog_Hostname`
[ -z $wifidog_Hostname ] && wifidog_Hostname="wifi2.612459.com" && nvram set wifidog_Hostname=$wifidog_Hostname
wifidog_sslenable=`nvram get wifidog_sslenable`
[ -z $wifidog_sslenable ] && wifidog_sslenable="no" && nvram set wifidog_sslenable=$wifidog_sslenable
wifidog_HTTPPort=`nvram get wifidog_HTTPPort`
[ -z $wifidog_HTTPPort ] && wifidog_HTTPPort="80" && nvram set wifidog_HTTPPort=$wifidog_HTTPPort
wifidog_Path=`nvram get wifidog_Path`
[ -z $wifidog_Path ] && wifidog_Path="/" && nvram set wifidog_Path=$wifidog_Path

#高级设置
wifidog_id=`nvram get wifidog_id`
[ -z $wifidog_id ] && wifidog_id=$(/sbin/ifconfig br0  | sed -n '/HWaddr/ s/^.*HWaddr */HWADDR=/pg'  | awk -F"=" '{print $2}' |sed -n 's/://pg'| awk -F" " '{print $1}')  && nvram set wifidog_id=$wifidog_id
wifidog_lanif=`nvram get wifidog_lanif`
[ -z $wifidog_lanif ] && wifidog_lanif="br0" && nvram set wifidog_lanif=$wifidog_lanif
wifidog_wanif=`nvram get wifidog_wanif`
[ -z $wifidog_wanif ] && wifidog_wanif=$(nvram get wan0_ifname_t) && nvram set wifidog_wanif=$wifidog_wanif
wifidog_Port=`nvram get wifidog_Port`
[ -z $wifidog_Port ] && wifidog_Port="2060" && nvram set wifidog_Port=$wifidog_Port
wifidog_Interval=`nvram get wifidog_Interval`
[ -z $wifidog_Interval ] && wifidog_Interval="60" && nvram set wifidog_Interval=$wifidog_Interval
wifidog_Timeout=`nvram get wifidog_Timeout`
[ -z $wifidog_Timeout ] && wifidog_Timeout="5" && nvram set wifidog_Timeout=$wifidog_Timeout
wifidog_MaxConn=`nvram get wifidog_MaxConn`
[ -z $wifidog_MaxConn ] && wifidog_MaxConn="30" && nvram set wifidog_MaxConn=$wifidog_MaxConn
wifidog_MACList=`nvram get wifidog_MACList`
[ -z $wifidog_MACList ] && wifidog_MACList="00:00:DE:AD:BE:AF" && nvram set wifidog_MACList=$wifidog_MACList
wifidog_bmdurl=`nvram get wifidog_bmdurl`
[ -z $wifidog_bmdurl ] && wifidog_bmdurl="wifi.weixin.qq.com" && nvram set wifidog_bmdurl=$wifidog_bmdurl


case "$1" in
  start)

{
rm -f /etc/storage/wifidog/wifidog.conf  
# 将数值赋给WiFiDog官方的配置参数               
echo "
#WiFiDog 配置文件

#网关ID
GatewayID $wifidog_id

#内部网卡
GatewayInterface $wifidog_lanif

#外部网卡
ExternalInterface $wifidog_wanif 

#认证服务器
AuthServer {
	Hostname $wifidog_Hostname
	SSLAvailable $wifidog_sslenable
	#SSLPort $sslport
	SSLPort 443
	HTTPPort $wifidog_HTTPPort
	Path $wifidog_Path
	}
	
#守护进程
Daemon 1

#检查DNS状态(Check DNS health by querying IPs of these hosts)
PopularServers $wifidog_Hostname

#运行状态
HtmlMessageFile /www/wifidog-msg.html

#监听端口
GatewayPort $wifidog_Port

#心跳间隔时间
CheckInterval $wifidog_Interval

#心跳间隔次数
ClientTimeout $wifidog_Timeout

#HTTP最大连接数
HTTPDMaxConn $wifidog_MaxConn

#信任的MAC地址,加入信任列表将不用登录可访问
TrustedMACList $wifidog_MACList

#全局防火墙设置
FirewallRuleSet global {
	FirewallRule allow tcp port 443
	FirewallRule allow tcp to qq.com
}

#新验证用户
FirewallRuleSet validating-users {
    FirewallRule allow to 0.0.0.0/0
}
#正常用户
FirewallRuleSet known-users {
    FirewallRule allow to 0.0.0.0/0
}

#未知用户
FirewallRuleSet unknown-users {
    FirewallRule allow udp port 53
    FirewallRule allow tcp port 53
    FirewallRule allow udp port 67
    FirewallRule allow tcp port 67
}

#锁住用户
FirewallRuleSet locked-users {
    FirewallRule block to 0.0.0.0/0
}
" >> /etc/storage/wifidog/wifidog.conf
}


    echo "Starting wifidog... "
    if $WD_DIR/wdctl status 2> /dev/null
    then
	echo "FAILED:  wifidogalready running"
    else
        $0 test-module
	if $WD_DIR/wifidog$OPTIONS
sleep 4
wifidog_bmdurl=`nvram get wifidog_bmdurl`
[ -z $wifidog_bmdurl ] && wifidog_bmdurl="wifi.weixin.qq.com" && nvram set wifidog_bmdurl=$wifidog_bmdurl
echo $wifidog_bmdurl
wait
echo "wifidog is runing!"
iptables -t nat -D WiFiDog_br0_AuthServers -d $wifidog_bmdurl -j ACCEPT
wait
echo "iptable add rule 3"
iptables -t filter -D WiFiDog_br0_AuthServers -d $wifidog_bmdurl -j ACCEPT
wait
echo "iptable add rule 4"
iptables -t nat -A WiFiDog_br0_AuthServers -d $wifidog_bmdurl -j ACCEPT
wait
echo "iptable add rule 1"
iptables -t filter -A WiFiDog_br0_AuthServers -d $wifidog_bmdurl -j ACCEPT
wait
echo "iptable add rule 2"
	then
	

		echo "OK"
	else
		echo "FAILED:  wifidogexited with non 0 status"
	fi
    fi
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
    echo "Stopping wifidog... "
    if $WD_DIR/wdctl status 2> /dev/null
    then
       	if $WD_DIR/wdctl stop
	then
		echo "OK"
	else
		echo "FAILED:  wdctl stop exited with non 0 status"
	fi
       
    else
       echo "FAILED:  wifidogwas not running"
    fi
    ;;
  status)
    $WD_DIR/wdctl status
    ;;
  debug|test-module)

    ### Test ipt_mark with iptables
    test_ipt_mark () {
      IPTABLES_OK=$($IPT -A FORWARD -m mark --mark 2 -j ACCEPT 2>&1 | grep "No chain.target.match")
      if [ -z "$IPTABLES_OK" ]; then
        $IPT -D FORWARD -m mark --mark 2 -j ACCEPT 2>&1
        echo 1
      else
        echo 0
      fi
    }
    ### Test ipt_mac with iptables
    test_ipt_mac () {
      IPTABLES_OK=$($IPT -A INPUT -m mac --mac-source 00:00:00:00:00:00 -j ACCEPT 2>&1 | grep "No chain.target.match")
      if [ -z "$IPTABLES_OK" ]; then
        $IPT -D INPUT -m mac --mac-source 00:00:00:00:00:00 -j ACCEPT 2>&1
        echo 1
      else
        echo 0
      fi
    }

    ### Test ipt_REDIRECT with iptables
    test_ipt_REDIRECT () {
      IPTABLES_OK=$($IPT -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 2060 2>&1 | grep "No chain.target.match")
      if [ -z "$IPTABLES_OK" ]; then
        $IPT -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 2060 2>&1
        echo 1
      else
        echo 0
      fi
    }

    ### Find a module on disk
    module_exists () {
    echo " Looking for a module on disk"
      EXIST=$(find /lib/modules/`uname -r` -name $1.*o 2>/dev/null)
      if [ -n "$EXIST" ]; then
        echo 1
      else
        echo 0
      fi
    }

    ### Test if a module is in memory
    module_in_memory () {
      MODULE=$(lsmod | grep $1 | awk '{print $1}')
      if [ "$MODULE" = "$1" ]; then
        echo 1
      else
        echo 0
      fi
    }

    echo "Testing for iptables modules"

    echo "  Testing ipt_mac"
    TEST_IPT_MAC=$(test_ipt_mac)
    if [ "$TEST_IPT_MAC" = "0" ]; then
      echo "   iptables is not working with ipt_mac"
      echo "   Scanning disk for ipt_mac module"
      TEST_IPT_MAC_MODULE_EXISTS=$(module_exists "ipt_mac")
      if [ "$TEST_IPT_MAC_MODULE_EXISTS" = "0" ]; then
        echo "   ipt_mac module is missing, please install it (kernel or module)"
        exit
      else
        echo "   ipt_mac module exists, trying to load"
        insmod ipt_mac > /dev/null
        TEST_IPT_MAC_MODULE_MEMORY=$(module_in_memory "ipt_mac")
        if [ "$TEST_IPT_MAC_MODULE_MEMORY" = "0" ]; then
          echo "  Error: ipt_mac not loaded"
          exit
        else
          echo "  ipt_mac loaded sucessfully"
        fi
      fi
    else
      echo "   ipt_mac  module is working"
    fi

    echo "  Testing ipt_mark"
    TEST_IPT_MARK=$(test_ipt_mark)
    if [ "$TEST_IPT_MARK" = "0" ]; then
      echo "   iptables is not working with ipt_mark"
      echo "   Scanning disk for ipt_mark module"
      TEST_IPT_MARK_MODULE_EXISTS=$(module_exists "ipt_mark")
      if [ "$TEST_IPT_MARK_MODULE_EXISTS" = "0" ]; then
        echo "   iptables ipt_mark module missing, please install it (kernel or module)"
        exit
      else
        echo "   ipt_mark module exists, trying to load"
        insmod ipt_mark
        TEST_IPT_MARK_MODULE_MEMORY=$(module_in_memory "ipt_mark")
        if [ "$TEST_IPT_MARK_MODULE_MEMORY" = "0" ]; then
          echo "   Error: ipt_mark not loaded"
          exit
        else
          echo "   ipt_mark loaded sucessfully"
        fi
      fi
      else
    echo "   ipt_mark module is working"
    fi

##TODO:  This will not test if required iptables userspace (iptables-mod-nat on Kamikaze) is installed
    echo "  Testing ipt_REDIRECT"
    TEST_IPT_MAC=$(test_ipt_REDIRECT)
    if [ "$TEST_IPT_MAC" = "0" ]; then
      echo "   iptables is not working with ipt_REDIRECT"
      echo "   Scanning disk for ipt_REDIRECT module"
      TEST_IPT_MAC_MODULE_EXISTS=$(module_exists "ipt_REDIRECT")
      if [ "$TEST_IPT_MAC_MODULE_EXISTS" = "0" ]; then
        echo "   ipt_REDIRECT module is missing, please install it (kernel or module)"
        exit
      else
        echo "   ipt_REDIRECT module exists, trying to load"
        insmod ipt_REDIRECT > /dev/null
        TEST_IPT_MAC_MODULE_MEMORY=$(module_in_memory "ipt_REDIRECT")
        if [ "$TEST_IPT_MAC_MODULE_MEMORY" = "0" ]; then
          echo "  Error: ipt_REDIRECT not loaded"
          exit
        else
          echo "  ipt_REDIRECT loaded sucessfully"
        fi
      fi
    else
      echo "   ipt_REDIRECT  module is working"
    fi

    ;;

  *)
   echo "Usage: $0 {start|stop|restart|reload|status|test-module}"
   exit 1
   ;;
esac





