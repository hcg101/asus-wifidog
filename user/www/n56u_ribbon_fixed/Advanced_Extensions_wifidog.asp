<!DOCTYPE html>

<html>

<head>

<title>Wifidog 设置</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta http-equiv="Pragma" content="no-cache">

<meta http-equiv="Expires" content="-1">



<link rel="shortcut icon" href="images/favicon.ico">

<link rel="icon" href="images/favicon.png">

<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">

<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">



<script type="text/javascript" src="/jquery.js"></script>

<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>

<script type="text/javascript" src="/state.js"></script>

<script type="text/javascript" src="/general.js"></script>

<script type="text/javascript" src="/itoggle.js"></script>

<script type="text/javascript" src="/popup.js"></script>

<script type="text/javascript" src="/help.js"></script>

<script>

var $j = jQuery.noConflict();



$j(document).ready(function() {

    init_itoggle('wifidog_enable');

	init_itoggle('wifidog_Daemon');

});



</script>

<script>



<% login_state_hook(); %>



function initial(){

    show_banner(1);

    show_menu(5,11,3);

    show_footer();



}



function applyRule(){

    if(validForm()){

        showLoading();



        document.form.action_mode.value = " Apply ";

        document.form.current_page.value = "/Advanced_Extensions_wifidog.asp";

        document.form.next_page.value = "";       

        document.form.submit();

    }

}



function validForm(){





    return true;

}



function done_validating(action){

    refreshpage();

}



</script>

<style>

    .table th, .table td{vertical-align: middle;}

    .table input, .table select {margin-bottom: 0px;}

</style>

</head>



<body onload="initial();" onunLoad="return unload_body();">



<div class="wrapper">

    <div class="container-fluid" style="padding-right: 0px">

        <div class="row-fluid">

            <div class="span3"><center><div id="logo"></div></center></div>

            <div class="span9" >

                <div id="TopBanner"></div>

            </div>

        </div>

    </div>

    <div id="Loading" class="popup_bg"></div>

    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

    <form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

    <input type="hidden" name="current_page" value="Advanced_Extensions_wifidog.asp">

    <input type="hidden" name="next_page" value="">

    <input type="hidden" name="next_host" value="">

    <input type="hidden" name="sid_list" value="LANHostConfig;">

    <input type="hidden" name="group_id" value="">

    <input type="hidden" name="action_mode" value="">

    <input type="hidden" name="action_script" value="">

    <div class="container-fluid">

        <div class="row-fluid">

            <div class="span3">

                <!--Sidebar content-->

                <!--=====Beginning of Main Menu=====-->

                <div class="well sidebar-nav side_nav" style="padding: 0px;">

                    <ul id="mainMenu" class="clearfix"></ul>

                    <ul class="clearfix">

                        <li>

                            <div id="subMenu" class="accordion"></div>

                        </li>

                    </ul>

                </div>

            </div>



            <div class="span9">

                <!--Body content-->

                <div class="row-fluid">

                    <div class="span12">

                        <div class="box well grad_colour_dark_blue">

                            <h2 class="box_head round_top">Wifidog 设置</h2>

                            <div class="round_bottom">

                                <div class="row-fluid">

                                    <div id="tabMenu" class="submenuBlock"></div>

                                  <div class="alert alert-info" style="margin: 10px;">Wifidog 是一款开源的用来实现无线认证的应用，需要配合认证平台使用。</br>如果亲没有认证平台、可以在<a href="http://wifi2.612459.com" target="_blank">【哎丫丫智慧wifi平台】</a>使用测试账户对接<br>默认测试用户 testuser 密码 123456（ps：仅供测试！）<br>





								   <a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "wifidog_Port"); %>/wifidog/status" target="_blank">Wifidog状态统计查询页面</a><br><font color=red>请注意！！！wifidog服务每次开机自动启动、保证认证功能一直运行。。。<br>

如不需认证功能，请每次开机手动开启关闭服务2次。（或者更新其他固件）</font>

								  </div>             

                                    <table width="100%" cellpadding="4" cellspacing="0" class="table">

                                        <tr>

                                            <th colspan="2" style="background-color: #E3E3E3;">开关</th>

                                        </tr>

                                        <tr>

                                            <th width="30%" style="border: 0 none;">启用 Wifidog</th>

                                            <td style="border: 0 none;">

                                                <div class="main_itoggle">

                                                    <div id="wifidog_enable_on_of">

                                                        <input type="checkbox" id="wifidog_enable_fake" <% nvram_match_x("", "wifidog_enable", "1", "value=1 checked"); %><% nvram_match_x("", "wifidog_enable", "0", "value=0"); %>  />

                                                    </div>

                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">

                                                    <input type="radio" value="1" name="wifidog_enable" id="wifidog_enable_1" class="input" value="1" <% nvram_match_x("", "wifidog_enable", "1", "checked"); %> /><#checkbox_Yes#>

                                                    <input type="radio" value="0" name="wifidog_enable" id="wifidog_enable_0" class="input" value="0" <% nvram_match_x("", "wifidog_enable", "0", "checked"); %> /><#checkbox_No#>

                                                </div>

                                            </td>

                                        </tr>

										<tr>

                                            <th width="30%" style="border: 0 none;">守护进程</th>

                                            <td style="border: 0 none;">

                                                <div class="main_itoggle">

                                                    <div id="wifidog_Daemon_on_of">

                                                        <input type="checkbox" id="wifidog_Daemon_fake" <% nvram_match_x("", "wifidog_Daemon", "1", "value=1 checked"); %><% nvram_match_x("", "wifidog_Daemon", "0", "value=0"); %>  />

                                                    </div>

                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">

                                                    <input type="radio" value="1" name="wifidog_Daemon" id="wifidog_Daemon_1" class="input" value="1" <% nvram_match_x("", "wifidog_Daemon", "1", "checked"); %> /><#checkbox_Yes#>

                                                    <input type="radio" value="0" name="wifidog_Daemon" id="wifidog_Daemon_0" class="input" value="0" <% nvram_match_x("", "wifidog_Daemon", "0", "checked"); %> /><#checkbox_No#>

                                                </div>

                                            </td>

                                        </tr>

										<tr>

                                            <th colspan="2" style="background-color: #E3E3E3;">认证服务器</th>

                                        </tr>

                                        <tr>

                                            <th style="border: 0 none;">认证服务器地址:</th>

                                           <td style="border: 0 none;"><input name="wifidog_Hostname" type="text" class="input" id="wifidog_Hostname" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_Hostname"); %>" size="32" maxlength="128" />

					   <!--<td style="border: 0 none;"><input name="wifidog_Hostname" type="text" class="input" id="wifidog_Hostname" onkeypress="return is_string(this,event);" value="wifi2.612459.com" size="32" maxlength="128" readonly />-->

                                            </br><span style="color:#888;"><a href="http://wifi2.612459.com" target="_blank">【哎丫丫智慧wifi平台】</a>default:wifi2.612459.com</span></td>

                                        </tr>
  <!--<tr>

                                            <th style="border: 0 none;">是否开启ssl认证服务器:</th>

                                            <td style="border: 0 none;"><input name="wifidog_sslenable" type="text" class="input" id="wifidog_sslenable" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_sslenable"); %>" size="32" maxlength="128" />

											</br><span style="color:#888;">默认no为不开启状态、请输入yes开启ssl认证。请勿随意输入！！！</span></td>

                                        </tr>-->

                                        <tr>

                                            <th style="border: 0 none;">认证服务器端口:</th>

                                            <td style="border: 0 none;"><input name="wifidog_HTTPPort" type="text" class="input" id="wifidog_HTTPPort" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_HTTPPort"); %>" size="32" maxlength="128" />

											</br><span style="color:#888;">默认80端口</span></td>

                                        </tr>

							

                                         <tr>

                                            <th style="border: 0 none;">认证服务器路径:</th>

                                           <td style="border: 0 none;"><input name="wifidog_Path" type="text" class="input" id="wifidog_Path" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_Path"); %>" size="32" maxlength="128"  />

					<!-- <td style="border: 0 none;"><input name="wifidog_Path" type="text" class="input" id="wifidog_Path" onkeypress="return is_string(this,event);" value="/" size="32" maxlength="128" readonly />	-->

											</br><span style="color:#888;">默认"/",例如: "/","/wifidog/"</span></td>

                                        </tr>

		<!-- <tr>

                                           <th colspan="2" style="background-color: #E3E3E3;">高级设置</th>

                                        </tr>

                                        <tr>-->

                                            <th style="border: 0 none;">认证 ID:</th>

                                            <td style="border: 0 none;"><input name="wifidog_id" type="text" class="input" id="wifidog_id" onKeyPress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_id"); %>" size="12" maxlength="12"/>

                                            </br><span style="color:#888;">默认使用路由器mac地址作为ID. 请复制此认证ID去认证平台对接。<br>测试专用认证平台<a href="http://wifi2.612459.com" target="_blank">【哎丫丫智慧wifi平台】</a></span></td>

                                        </tr>										

                                      <!--   <tr>

                                            <th style="border: 0 none;">内部网卡:</th>

                                            <td style="border: 0 none;"><input name="wifidog_lanif" type="text" class="input" id="wifidog_lanif" onKeyPress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_lanif"); %>" size="12" maxlength="12"/>

                                            </br><span style="color:#888;">留空则自动选LAN网卡</span></td>

                                        </tr>

                                      <!--  <tr>

                                            <th style="border: 0 none;">外部网卡:</th>

                                            <td style="border: 0 none;"><input name="wifidog_wanif" type="text" class="input" id="wifidog_wanif" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_wanif"); %>" size="32" maxlength="128"/>

                                            </br><span style="color:#888;">留空则自动选WAN网卡</span></td>

                                        </tr>-->

                                        <tr>

                                            <th style="border: 0 none;">认证网关端口:</th>

                                            <td style="border: 0 none;">

                                            <input name="wifidog_Port" type="text" class="input" id="wifidog_Port" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_Port"); %>" size="32" maxlength="128"/>

                                            </br><span style="color:#888;">默认2060</span>

                                            </td>

                                        </tr>

                                        <tr>

                                            <th style="border: 0 none;">wifidog检测ping服务器间隔:</th>

                                            <td style="border: 0 none;"><input name="wifidog_Interval" type="text" class="input" id="wifidog_Interval" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_Interval"); %>" size="32" maxlength="128"/>

                                            </br><span style="color:#888;">单位秒 默认60秒、不建议修改大于180秒</span></td>

                                        </tr>

                                         <tr>

                                            <th style="border: 0 none;">wifidog检测连接终端间隔:</th>

                                            <td style="border: 0 none;"><input name="wifidog_Timeout" type="text" class="input" id="wifidog_Timeout" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_Timeout"); %>" size="32" maxlength="128"/>

                                            </br><span style="color:#888;">单位分钟 默认5分钟、具体和平台配合设置。<br>也就是说5分钟wifidog检测木有数据传输，即会判断用户不在线！<br>在平台的用户管理处用户可以判断！</span></td>

                                        </tr>

                                        <tr>

                                            <th style="border: 0 none;">HTTP 最大连接数:</th>

                                            <td style="border: 0 none;"><input name="wifidog_MaxConn" type="text" class="input" id="wifidog_MaxConn" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_MaxConn"); %>" size="32" maxlength="128"/>

                                            </br><span style="color:#888;">默认30</span></td>

                                        </tr>

                                        <tr>

                                            <th style="border: 0 none;">信任 MAC 地址:</th>

                                            <td style="border: 0 none;"><input name="wifidog_MACList" type="text" class="input" id="wifidog_MACList" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_MACList"); %>" size="32" maxlength="1024"/>

                                            </br><span style="color:#888;">默认00:00:DE:AD:BE:AF,多个用","连接</span></td>

                                        </tr>

										 <tr>

                                            <th style="border: 0 none;">信任 Url 地址:</th>

                                            <td style="border: 0 none;"><input name="wifidog_bmdurl" type="text" class="input" id="wifidog_bmdurl" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","wifidog_bmdurl"); %>" size="32" maxlength="1024"/>

                                            </br><span style="color:#888;">默认wifi.weixin.qq.com 多个请使用半角小逗号","隔开</span></td>

                                        </tr>

                                       

                                  </table>

                                    <table class="table">

                                        <tr>

                                            <td style="border: 0 none;">

                                                <center><input class="btn btn-primary" style="width: 219px" onclick="applyRule();" type="button" value="<#CTL_apply#>" /></center>

                                            </td>

                                        </tr>

                                    </table>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

    </form>

    <div id="footer"></div>

</div>

</body>

</html>
