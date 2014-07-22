<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
<title>宁波市在线同步拍卖交易平台</title>
</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
		
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
		<div class="main">
			<!--left-->
			<div class="left">
			<ul>
				
				<s:if test="#request.guideSearchType == 1">
				<li><a href="auctionIndex_guide?searchFlag=1" class="current">拍卖流程</a></li>
				</s:if>
				<s:else>
				<li><a href="auctionIndex_guide?searchFlag=1">拍卖流程</a></li>
				</s:else>
				<s:if test="#request.guideSearchType == 2">
				<li><a href="auctionIndex_guide?searchFlag=2" class="current">疑问解答</a></li>
				</s:if>
				<s:else>
				<li><a href="auctionIndex_guide?searchFlag=2">疑问解答</a></li>
				</s:else>
				<s:if test="#request.guideSearchType == 3">
				<li><a href="auctionIndex_guide?searchFlag=3" class="current">操作规则</a></li>
				</s:if>
				<s:else>
				<li><a href="auctionIndex_guide?searchFlag=3">操作规则</a></li>
				</s:else>
				<s:if test="#request.guideSearchType == 4">
				<li><a href="auctionIndex_guide?searchFlag=4" class="current">法律法规</a></li>
				</s:if>
				<s:else>
				<li><a href="auctionIndex_guide?searchFlag=4">法律法规</a></li>
				</s:else>
			</ul>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
  				<div class="l">拍卖指南</div> 
	  			<div class="r">
	  			</div>
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            
            <s:iterator value="#request.auctionGuideList" var="auctionGuideList">
		            <tr align="center">
							
		              	<td bgcolor="#FFFFFF">
		              	<a href="auctionIndex_guideDetail?guideFlag=<s:property value="#auctionGuideList.id"/>" target="_blank"><s:property value="#auctionGuideList.guideTitle"/></a>
      					</td>
					
					</tr>
	        </s:iterator>
          </table>
          
          
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
</body>
</html>
