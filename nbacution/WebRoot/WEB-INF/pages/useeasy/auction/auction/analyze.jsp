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
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  >
				<s:iterator value="auctionTopInfo_list" var="aucTopInfo_list">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="###" onclick="alert(<s:property value="#aucTopInfo_list.id"/>)"><s:property value="#aucTopInfo_list.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
		</div>
		<!--end header-->	
		
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
			 <%@include file="/WEB-INF/pages/useeasy/auction/main/left.jsp" %>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right">
		  <div class="title" >拍卖成果分析
		  	
		  </div>
		  
		  
		  <table width="100%" border="0" cellpadding="0" cellspacing="3" bgcolor="#FFFFFF" >
            <tr align="left" >
			  <td bgcolor="#F8F2C9" width="140">拍卖会编号</td>
              <td width="190"><s:property value="#request.auctionInfo.auctionNum"/></td>
			  <td bgcolor="#F8F2C9" width="140">拍卖会名称</td>
			  <td ><s:property value="#request.auctionInfo.auctionName"/></td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">开始时间</td>
              <td ><s:date name="#request.auctionInfo.auctionStartTime" format="yyyy-MM-dd HH:mm"/></td>
			  <td bgcolor="#F8F2C9">拍卖会地址</td>
			  <td ><s:property value="#request.auctionInfo.auctionAddress"/></td>
            </tr>
			
          </table>
		  <div class="title" >统计数据</div>
		  <table width="100%" border="0" cellpadding="0" cellspacing="3" bgcolor="#FFFFFF" >
		    <tr align="left" >
		      <td width="220" colspan="2">成交率:<s:property value="#request.dealRate"/>%</td>
              <td width="220" colspan="2">标的总数:<s:property value="#request.itemAll"/>件</td>
			  <td width="220" colspan="2">出价总数:<s:property value="#request.itemPriceAll"/>次</td>
		    </tr>
            <tr align="left" >
              <td bgcolor="#F8F2C9" width="140">网络成交率</td>
			  <td width="80"><s:property value="#request.dealRateInNet"/>%</td>
			  <td bgcolor="#F8F2C9" width="140">网络成交</td>
			  <td width="80"><s:property value="#request.itemDealInNet"/>件</td>
			  <td bgcolor="#F8F2C9" width="140">网络出价次数</td>
			  <td width="80"><s:property value="#request.itemPriceNet"/>次</td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">现场成交率</td>
			  <td ><s:property value="#request.dealRateInAlive"/>%</td>
			  <td bgcolor="#F8F2C9">现场成交</td>
			  <td ><s:property value="#request.itemDealInAlive"/>件</td>
			  <td bgcolor="#F8F2C9">现场出价次数</td>
			  <td ><s:property value="#request.itemPriceAlive"/>次</td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">流标率</td>
			  <td ><s:property value="#request.passRate"/>%</td>
			  <td bgcolor="#F8F2C9">流标</td>
			  <td ><s:property value="#request.itemPass"/>件</td>
			  <td bgcolor="#F8F2C9">网络出价的拍品数量</td>
			  <td ><s:property value="#request.pricedItemNet"/>件</td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">撤拍/缓拍 率</td>
			  <td ><s:property value="#request.cheRate"/>%/<s:property value="#request.huanRate"/>%</td>
			  <td bgcolor="#F8F2C9">撤拍/缓拍</td>
			  <td ><s:property value="#request.itemChe"/>件/<s:property value="#request.itemHuan"/>件</td>
			  <td bgcolor="#F8F2C9">现场出价的拍品数量</td>
			  <td ><s:property value="#request.pricedItemAlive"/>件</td>
            </tr>
			<tr align="left" >
		      <td width="220" colspan="2">拍卖成交总额:<s:property value="#request.dealedItemCurrentPriceAll"/>元</td>

			  <td width="220" colspan="2"></td>
			  <td width="220" colspan="2"></td>
		    </tr>
            <tr align="left" >
			  <td bgcolor="#F8F2C9" width="140">网络成交起拍价总额</td>
			  <td width="80"><s:property value="#request.dealedItemPriceNet"/>元</td>


			  <td width="140"></td>
			  <td width="80"></td>
			  <td width="140"></td>
			  <td width="80"></td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">现场成交起拍价总额</td>
			  <td ><s:property value="#request.dealedItemPriceAlive"/>元</td>


			  <td ></td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">网络成交价总额</td>
			  <td ><s:property value="#request.dealedItemCurrentPriceNet"/>元</td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">现场成交价总额</td>
			  <td ><s:property value="#request.dealedItemCurrentPriceAlive"/>元</td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
            </tr>
			<tr align="left">
			  <td bgcolor="#F8F2C9">涨幅</td>
			  <td ><s:property value="#request.rateIncrease"/>%</td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
			  <td ></td>
            </tr>
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
