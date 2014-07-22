<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords" content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统" />
<link href="useeasy/auction/css/main/main.css" rel="stylesheet"
	type="text/css" />
<link href="useeasy/auction/css/reference/layout.css" rel="stylesheet"
	type="text/css" />
<title>宁波市在线同步拍卖交易平台--拍卖指南</title>
</head>
<body>
	<!--container-->
	<div class="container">
	<!--topnav--> 
	<jsp:include page="../main/topLogin.jsp" flush="true" /> 
	<!--end topnav--> 
	
	<!--header-->
		<div class="header">
			
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
			
			<div class="">
			<table width="920" border="0" cellpadding="0" cellspacing="0">
				<tr>
					</tr>
			</table>
			</div>
			
			<div class="msg">
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
				<s:iterator value="#request.auctionInfoDtoListTop" var="auctionInfoDtoListTop">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property value="#auctionInfoDtoListTop.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
				
		</div>
		<!--end header-->

	<!--main-->
<div class="guid_view">

<div class="content">
<s:property value="#request.auctionGuide.guideContent" escape="false"/>

</div>
</div>
<!--end main--> 
<!--link-->  
<!--footer--> 
<jsp:include page="../main/footer.jsp" flush="true" /></div>
<!--end container-->
</body>
</html>