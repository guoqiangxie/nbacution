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
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
			 <%@include file="/WEB-INF/pages/useeasy/auction/main/left.jsp" %>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
	  				<div class="l">我的成交记录</div> 
	  				<div class="r"><a style="color:blue; font-weight:bold;"  href="guestDealRecord_auctionList">【返回】</a> 
	  				</div>
		  			<!--<div class="r">
		  				<a onclick="showAll();" style="color:blue; font-weight:bold;"  href="#">【全部】</a> 
		  				<a onclick="showGet();" style="color:blue; font-weight:bold;"  href="#">【竞得】</a>
		  				<a onclick="showNotGet();" style="color:blue; font-weight:bold;"  href="#">【未竞得】</a>
	  				</div>-->
	  			</div> 
	  			<form name="" action="" method="post">
	  		<input type="hidden" id="orderId_val" value="<s:property value="#request.orderId"/>"/>
        	<input type="hidden" id="orderDate_val" value="<s:property value="#request.orderDate"/>"/>
      		<input type="hidden" id="orderTime_val" value="<s:property value="#request.orderTime"/>"/>
           
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
	  		<tr>
	  			<td colspan="9" bgcolor="#FFFFFF">
		  			拍卖会名称：<s:property value="#request.auctionInfo.auctionName"/><br />
		  			拍卖时间：<s:date name="#request.auctionInfo.auctionStartTime" format="yyyy-MM-dd HH:mm"/><br />
					本场拍卖会保证金是否可以抵扣：
					<s:if test="#request.auctionInfo.auctionWebPayGoods == 1">
						<font color="blue">可以</font>
					</s:if>
					<s:else>
						<font color="red">不可以</font>
					</s:else>
					<br />
					结算状态：
					<s:if test="#request.isSettlement == 0">
						<font color="red">未结算</font>
					</s:if>
					<s:else>
						<font color="blue">已结算</font>
					</s:else>
					<br />
					合计金额：<font color="red"><s:property value="#request.totalPrice"/></font> &nbsp;&nbsp;&nbsp;&nbsp;
	        		<br />
	        		现场支付：<font color="red"><s:property value="#request.aliveMargin"/></font>
              		网络支付：<font color="red"><s:property value="#request.webMargin"/></font>
              		<br />
	        		现场已付货款：<font color="red"><s:property value="#request.aliveGoods"/></font>
	        		网络已付货款：<font color="red"><s:property value="#request.webGoods"/></font>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<br />
	        		应付金额：<font color="red"><s:property value="#request.payPrice"/></font> &nbsp;&nbsp;&nbsp;&nbsp;
	        		<br />
	        		<input class=large_btn  type=button value="支付明细" onclick="doPayDetail(<s:property value="#request.auctionInfo.id"/>);" />
	  			</td>
	  		</tr>
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">拍品序号</td>
              <td width="10%" bgcolor="#FFFFFF">显示编号</td>
			  <td width="20%" align="center" bgcolor="#FFFFFF">拍品名称</td>
		 	  <td width="10%" bgcolor="#FFFFFF">佣金方式</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金数额</td>
			  <td width="10%" bgcolor="#FFFFFF">成交价</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金金额</td>
			  <td width="10%" bgcolor="#FFFFFF">含佣金总价</td>
            </tr>
            <s:iterator value="item_list" var="iInfo_list" status="status">
         		<tr align="center" id="">
					<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemNumber"/></td>
	              	<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.viewOrder"/></td>
				  	<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemName"/></td>
				  	<td bgcolor="#FFFFFF">
					  	<s:if test="#iInfo_list.itemCommissionType == 1">
					  	固定比率
					  	</s:if>
					  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
					  	定额佣金
					  	</s:elseif>
					  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
					  	执行司法规定
					  	</s:elseif>
				  	</td>
				  	<td bgcolor="#FFFFFF">
					  	<s:if test="#iInfo_list.itemCommissionType == 1">
					  		<s:property value="#iInfo_list.itemCommissionValue"/>%
					  	</s:if>
					  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
					  		<s:property value="#iInfo_list.itemCommissionValue"/>
					  	</s:elseif>
					  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
					  		执行司法规定
					  	</s:elseif>
				  	</td>
				 	<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemCurrentPrice"/></td>
				  	<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.commissionValue"/></td>
				  	<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.countValue"/></td>
				  	
				</tr>
			</s:iterator>
            	 	
	        <!--<s:if test="#request.isSettlement == 0">
		        <s:if test="#request.payPrice > 0">
				<tr>
	            	<td align="center" colspan="9">
	            		<input type="hidden" id="payPrice_val" value="<s:property value="#request.payPrice"/>"/>
	       
	            		<input class=large_btn  type=button value="支付货款 " onclick="doSubmit(<s:property value="#request.auctionInfo.id"/>);" />
	            	</td>
	            </tr>
	            </s:if>
            </s:if>-->
          </table>
         	</form>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
function doSubmit(str){
	var goods_flag = $("#payPrice_val").val();
	var orderId = $("#orderId_val").val();
	var orderDate = $("#orderDate_val").val();
	var orderTime = $("#orderTime_val").val();
	
	if(confirm("是否支付货款金，金额为： " + goods_flag + " ！")){
		document.forms[0].target = "_self";
	 	document.forms[0].action="guestDealRecord_doWebGoods?auctionFlag="+str
	 				+"&goodsVal="+goods_flag+"&orderId="+orderId+"&orderDate="+orderDate+"&orderTime="+orderTime;
		document.forms[0].submit();
	}
}

function doPayDetail(str){
	var arg = "guestFinance_payDetail?auctionFlag="+str;
	window.showModalDialog(arg, "","dialogWidth=800px;dialogHeight=700px");
}
</script>
</body>
</html>
