<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
	<title>宁波市在线同步拍卖交易平台</title>
	<link rel="stylesheet" type="text/css" href="useeasy/auction/css/flash/controller.css"/>
    <style>
		body{background:url(useeasy/auction/images/flash/flash_bg.gif);}
		div{text-align:center;}
	</style>
</head>
<body>
    <div>
      <object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1024" height="768">
        <param name="movie" value="flash/Console.swf" />
        <param name="quality" value="high" />
        <param name="wmode" value="opaque" />
        <param name="swfversion" value="6.0.65.0" />
        <!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
        <param name="expressinstall" value="scripts/expressInstall.swf" />
        <!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
        <!--[if !IE]>-->
        <object type="application/x-shockwave-flash" data="flash/Console.swf" width="1024" height="768">
        <!--<![endif]-->
       	<param name="quality" value="high" />
        <param name="wmode" value="opaque" />
        <param name="swfversion" value="6.0.65.0" />
        <param name="expressinstall" value="scripts/expressInstall.swf" />
        <param name="FlashVars" value="auction_id=<s:property value="#request.auctionId"/>&user_id=<s:property value="#request.userId"/>&auction_num=<s:property value="#request.auctionNum"/>&xml_num=<s:property value="#request.xmlNum"/>&auction_name=<s:property value="#request.auctionName"/>" />  
        <!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
        <div>
    		<h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
         	<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" width="112" height="33" /></a></p>
        </div>
        <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>
</div>

</body>
   
</html>
