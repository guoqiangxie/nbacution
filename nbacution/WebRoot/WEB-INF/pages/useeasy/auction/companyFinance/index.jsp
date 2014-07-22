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
  				<div class="l">拍卖会账务中心</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
	  			</div>
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <td width="20%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="20%" bgcolor="#FFFFFF">账号名称</td>
			  <td width="20%" bgcolor="#FFFFFF">申请时间</td>
			  <td width="20%" bgcolor="#FFFFFF">状态</td>
			  <td width="20%" bgcolor="#FFFFFF">保证金</td>
            </tr>
            <s:iterator value="#request.companyFinance_list" var="cFinance_list" status="cFinance_index">
            	<s:iterator value="#request.finance_list" var="f_list" status="f_index">
            		<s:if test="#f_index.index == #cFinance_index.index">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#cFinance_list.auctionName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#cFinance_list.accountName"/></td>
					  <td bgcolor="#FFFFFF"><s:date name="#cFinance_list.createTime" format="yyyy-MM-dd HH:mm"/></td>
					  
					  <td bgcolor="#FFFFFF" class="state">
					  	
					  		
            				<s:if test="#f_list[1] == 1">
            					<font color="blue">已结算</font>
            					<br/>
					  			<font color="grey">查看支付信息</font>
            				</s:if>
            				<s:else>
            					<s:if test="#f_list[0] == 0">
						  			<font color="red">未结算</font>
	            				</s:if>
	            				<s:else>
	            					<font color="blue">已结算</font>
	            				</s:else><br/>
            					<a href="companyFinance_detail?applyFlag=<s:property value="#cFinance_list.id"/>"><font color="red">查看支付信息</font></a>
            				</s:else>
            				
            			
           			  </td>
           			  
           			  <td bgcolor="#FFFFFF" class="state">
					  	<s:if test="#f_index.index == #cFinance_index.index">
					  		<s:if test="#f_list[1] == 1">
					  			<font color="grey">退还保证金</font>
            				</s:if>
            				<s:else>
            					<a href="companyFinance_marginBack?applyFlag=<s:property value="#cFinance_list.id"/>"><font color="red">退还保证金</font></a>
            				</s:else><br/>
            				
            			</s:if>
           			  </td>
           			  
		            </tr>
		            </s:if>
	        	</s:iterator>
	        </s:iterator>
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
