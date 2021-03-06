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
	  			<div class="r">
	  			</div>
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <!--<td width="60" bgcolor="#FFFFFF">编号</td>-->
			  <td width="15%" bgcolor="#FFFFFF">LOGO</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖公司</td>
			  <td width="15%" bgcolor="#FFFFFF">开始时间</td>
			  <td width="10%" bgcolor="#FFFFFF">在线支付</td>
			  <td width="10%" bgcolor="#FFFFFF">状态</td>
            </tr>
            <s:iterator value="auction_list" var="aucInfoByCompany_list">
		            <tr align="center">
							
		              	<td bgcolor="#FFFFFF">
		              	<s:if test="#aucInfoByCompany_list.auctionPicType == 1">
		              		<s:if test="#aucInfoByCompany_list.uploadUrl != null && #aucInfoByCompany_list.uploadUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#aucInfoByCompany_list.uploadUrl"/>" height="90" width="120"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120"/>
       						</s:else>
       						
       					</s:if>
       					<s:elseif test="#aucInfoByCompany_list.auctionPicType == 2">
       						<s:if test="#aucInfoByCompany_list.auctionPicVal == 1">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg" height="90" width="120"/>
       						</s:if>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 2">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 3">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 4">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 5">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 6">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#aucInfoByCompany_list.auctionPicVal == 7">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg" height="90" width="120"/>
       						</s:elseif>
       					</s:elseif>
       					<s:elseif test="#aucInfoByCompany_list.auctionPicType == 3">
       						<s:if test="#aucInfoByCompany_list.uploadAucUrl != null && #aucInfoByCompany_list.uploadAucUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#aucInfoByCompany_list.uploadAucUrl"/>" height="90" width="120"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120"/>
       						</s:else>
       						</s:elseif>
      					</td>
					  <td bgcolor="#FFFFFF"><s:property value="#aucInfoByCompany_list.auctionName"/></td>
					  <td bgcolor="#FFFFFF"><s:property value="#aucInfoByCompany_list.companyName"/></td>
					  <td bgcolor="#FFFFFF"><s:date name="#aucInfoByCompany_list.auctionStartTime" format="yyyy-MM-dd HH:mm"/></td>
					 
					 	<td bgcolor="#FFFFFF" class="state">
					 		<s:if test="#aucInfoByCompany_list.auctionWebPay == 1 && #aucInfoByCompany_list.auctionStatus == 2">
	           					<a href="guestDealRecord_itemListPay?auctionFlag=<s:property value="#aucInfoByCompany_list.id"/>"><font color="red">在线支付</font></a>
	           				</s:if>
	           				<s:else>
	           					<font color="grey">在线支付</font>
	           				</s:else>
					 	</td>
					  <td bgcolor="#FFFFFF" class="state">
					    <s:if test="#aucInfoByCompany_list.auctionStatus == 0">
           					<font color="red">尚未开始</font><br/>
           				</s:if>
            			<s:elseif test="#aucInfoByCompany_list.auctionStatus == 1">
            				<font color="blue">正在进行</font><br/>
            			</s:elseif>
            			<s:elseif test="#aucInfoByCompany_list.auctionStatus == 2">
            				已经结束<br/>
            			</s:elseif>
            			<a href="guestDealRecord_itemList?auctionFlag=<s:property value="#aucInfoByCompany_list.id"/>"><font color="red">查看明细</font></a>
					  </td>
		            </tr>
	        </s:iterator>
            <!--<s:iterator value="auction_list" var="auction_list" status="index">
		            <tr align="center">
		            	<td bgcolor="#FFFFFF"><s:property value="#index.count"/></td>
						<td bgcolor="#FFFFFF"><s:property value="#auction_list.auctionName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#auction_list.companyName"/></td>
					  <td bgcolor="#FFFFFF"><s:property value="#appInfo_list.applyContent"/></td>
					  <td bgcolor="#FFFFFF"><s:date name="#auction_list.auctionTime" format="yyyy-MM-dd HH:mm"/></td>
					  <td bgcolor="#FFFFFF">
					  	<s:if test="#auction_list.auctionStatus == 0">
           					未开始
           				</s:if>
            			<s:elseif test="#auction_list.auctionStatus == 1">
            				进行中
            			</s:elseif>
            			<s:elseif test="#auction_list.auctionStatus == 2">
            				已结束
	           			</s:elseif>
					  </td>
					  <td bgcolor="#FFFFFF" class="state">
					  	<s:if test="#auction_list.guestBidCount > 0">
					  		<a href="guestBidRecord_itemList?auctionId=<s:property value="#auction_list.auctionId"/>"><font color="red">查看明细</font></a>
					  	</s:if>
					  	<s:else>
					  		您未出过价
					  	</s:else>
					  </td>
		            </tr>
	        </s:iterator>-->
          </table>
          
          <table cellSpacing="0" cellPadding="0" width="100%" align="center">
								<tbody>
									<tr>
										<td id="tdPages" class="pageBar_style">
											<jsp:include page="../main/pagination.jsp" flush="true"/>
										</td>
									</tr>
								</tbody>
							</table>
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	
	
</script>
</body>
</html>
