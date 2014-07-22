<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/mention.css"	rel="stylesheet" type="text/css" />
<title>宁波市在线同步拍卖交易平台</title>
</head>
<body>
<input type="hidden" id="auctionFlag" value="<s:property value="#request.auctionFlag"/>"/>
		
<s:if test="#request.bidderFlag == 1">
<script type="text/javascript"  language="javascript">
	location.href="biddingView_viewerWait?auctionFlag=" + $("#auctionFlag").val();
</script>
</s:if>
<s:if test="#request.bidderFlag == 2">
<script type="text/javascript"  language="javascript">
	location.href="biddingView_viewer?auctionFlag=" + $("#auctionFlag").val();
</script>
</s:if>

<div class="content">
	<div class="logo"></div>
	<div class="line"></div>
	<div class="bg">
		<div id="mess_fir" style="display:none">尊敬的用户，观摩人数已经达到上限，暂时无法观摩~~</div>
		<div id="mess_sec" style="display:none">尊敬的用户，您不能观摩该场拍卖会~~</div>
		
		<div class="page"></div>
		<div class="back"></div>
	</div>
</div>

<s:if test="#request.bidderFlag == 0">
<script type="text/javascript"  language="javascript">
	$("#mess_sec").show();
</script>
</s:if>

<s:if test="#request.bidderFlag == 3">
<script type="text/javascript"  language="javascript">
	$("#mess_fir").show();
</script>
</s:if>
</body>
</html>


	
