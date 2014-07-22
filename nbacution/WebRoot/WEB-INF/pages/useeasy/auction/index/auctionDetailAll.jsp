<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/window/showall.css" rel="stylesheet" type="text/css" />

<title>宁波市在线同步拍卖交易平台</title>

</head>
<body onload="gototop();" >
<div class="font">
<s:property value="#request.returnVal" escape="false" />
</div>
<div  class="close"><a href="#" onclick="closeW();"></a></div>
<script language="javascript" type="text/javascript">
//返回页面顶端
function gototop(){
	scroll(0,0);
}
function closeW(){
	window.close();
}
</script>
</body>
</html>