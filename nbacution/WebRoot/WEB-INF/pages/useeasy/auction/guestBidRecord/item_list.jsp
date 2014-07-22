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
	  				<div class="l">我的出价记录</div> 
	  				<div class="r"><a style="color:blue; font-weight:bold;"  href="guestBidRecord_auctionList">【返回】</a> 
	  				</div>
		  			<!--<div class="r">
		  				<a onclick="showAll();" style="color:blue; font-weight:bold;"  href="#">【全部】</a> 
		  				<a onclick="showGet();" style="color:blue; font-weight:bold;"  href="#">【竞得】</a>
		  				<a onclick="showNotGet();" style="color:blue; font-weight:bold;"  href="#">【未竞得】</a>
	  				</div>-->
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
	  		<!--<tr>
	  			<td colspan="7">
	  			拍卖公司：<s:property value="#request.auctionInfo.companyName"/>&nbsp;&nbsp;&nbsp;&nbsp;
	  			拍卖会名称：<s:property value="#request.auctionInfo.auctionName"/>&nbsp;&nbsp;&nbsp;&nbsp;
	  			拍卖时间：<s:date name="#request.auctionInfo.auctionStartTime" format="yyyy-MM-dd HH:mm"/></td>
	  		</tr>-->
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">拍品序号</td>
              <td width="10%" bgcolor="#FFFFFF">显示编号</td>
			  <td width="20%" align="center" bgcolor="#FFFFFF">拍品名称</td>
		 	  <td width="10%" bgcolor="#FFFFFF">保证金</td>
			  <!--<td width="10%" bgcolor="#FFFFFF">起拍价</td>-->
			  <td width="10%" bgcolor="#FFFFFF">加价幅度</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金方式</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金数额</td>
			  <td width="10%" bgcolor="#FFFFFF">管理</td>
            
            
           	  <!--<td width="5%" bgcolor="#FFFFFF">序号</td>
              <td width="35%" bgcolor="#FFFFFF">拍品名称</td>
			  <td width="10%" bgcolor="#FFFFFF">起拍价</td>
			  <td width="15%" bgcolor="#FFFFFF">成交价</td>
			  <td width="15%" bgcolor="#FFFFFF">我的最终出价</td>
			  <td width="12%" bgcolor="#FFFFFF">我的代理价</td>
			  <td width="8%" bgcolor="#FFFFFF">状态</td>-->
            </tr>
            <s:iterator value="item_list" var="iInfo_list" status="status">
            		
            	
			            <tr align="center" id="">
		
						  
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemNumber"/></td>
			              <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.viewOrder"/></td>
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemName"/></td>
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.margin"/></td>
						  <!--<td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemPrice"/></td>-->
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemPriceRange"/></td>
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
						  <td bgcolor="#FFFFFF">
							  <s:if test="#iInfo_list.publishFlag == 0"><img src="useeasy/auction/images/main/lock.gif"/></s:if>
							  <a href="###" onclick="openW('guestBidRecord_priceList?itemFlag=<s:property value="#iInfo_list.id"/>')">出价信息</a>
						  </td>
						</tr>
			</s:iterator>
            <!--<s:iterator value="item_list" var="item_list" status="index">
            		<s:if test="#request.itemInfo[#index.index].itemStatus == 5 && #request.itemInfo[#index.index].priceUserId == #item_list.accountId">
            			<tr align="center" id="tr_y_<s:property value="#index.count"/>">
            		</s:if>
            		<s:else>
						<tr align="center" id="tr_n_<s:property value="#index.count"/>">
            		</s:else>
		            
		            	<td bgcolor="#FFFFFF"><s:property value="#index.count"/></td>
						<td bgcolor="#FFFFFF"><s:property value="#request.itemInfo[#index.index].itemName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#request.itemInfo[#index.index].itemPrice"/></td>
		              	<td bgcolor="#FFFFFF">
		              		<s:if test="#request.itemInfo[#index.index].itemStatus == 5">
		              			<s:property value="#request.itemInfo[#index.index].itemCurrentPrice"/>
		              		</s:if>
		              	</td>
		              	<td bgcolor="#FFFFFF">
		              		<s:property value="#item_list.priceValue"/>
		              	</td>
					  	<td bgcolor="#FFFFFF">
					  		<s:if test="#request.itemProxyPrice[#index.index] > 0">
					  			<s:property value="#request.itemProxyPrice[#index.index]"/>
					  		</s:if>
					  	</td>
					 	<td bgcolor="#FFFFFF">
					 		<s:if test="#request.itemInfo[#index.index].itemStatus == 5 && #request.itemInfo[#index.index].priceUserId == #item_list.accountId">
					 			竞得
					 		</s:if>
					 		<s:else>
					 			未竞得
					 		</s:else>
					 	</td>
		            </tr>
	        </s:iterator>-->
          </table>
       
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function openW(arg){ 
	 	window.showModalDialog(arg, "","dialogWidth=800px;dialogHeight=700px"); 
 	}
	
	function showAll(){
		$("tr[id*='tr']").show();
	}
	function showGet(){
		$("tr[id*='tr_y']").show();
		$("tr[id*='tr_n']").hide();
	}
	function showNotGet(){
		$("tr[id*='tr_y']").hide();
		$("tr[id*='tr_n']").show();
	}
</script>
</body>
</html>
