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
<script type="text/javascript" src="useeasy/plugins/checkbox/js/checkboxgroup.js" language="javascript"></script>
<script type="text/javascript" src="useeasy/plugins/checkbox/js/checkbox_onload.js" language="javascript"></script>

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
  				<div class="l">我的代理价</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="guestProxy_index?searchType=1">【返回】</a>
	  			</div>
	  			</div> 
	  			
	  		<form action="" method="post"  enctype="multipart/form-data">
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <!--<td width="5%" bgcolor="#FFFFFF">
              <input type="checkbox" class="checkall"/>
              </td>-->
              <td width="5%" bgcolor="#FFFFFF">序号</td>
              <td width="10%" bgcolor="#FFFFFF">显示编号</td>
			  <td width="20%" bgcolor="#FFFFFF">拍品名称</td>
			  <td width="25%" bgcolor="#FFFFFF">代理价</td>
			  <td width="15%" bgcolor="#FFFFFF">佣金方式</td>
			  <td width="15%" bgcolor="#FFFFFF">佣金数额</td>
			  <td width="10%" bgcolor="#FFFFFF">保证金</td>
            </tr>
            <s:iterator value="proxyItemInfoDto_list" var="proItemInfoDto_list">
		            <tr align="center">
		            	<!--<td bgcolor="#FFFFFF" >
						  	<input class="groupclass" name="group" type="checkbox" value="<s:property value="#proItemInfoDto_list.proxyPriceId"/>"/>
					  	</td>-->
						<td bgcolor="#FFFFFF"><s:property value="#proItemInfoDto_list.itemNumber"/></td>
				 	 	<td bgcolor="#FFFFFF"><s:property value="#proItemInfoDto_list.viewOrder"/></td>
				 	 	<td bgcolor="#FFFFFF"><s:property value="#proItemInfoDto_list.itemName"/></td>
				 	 	<td bgcolor="#FFFFFF">
				 	 		<s:property value="#proItemInfoDto_list.proxyPrice"/>
				 	 	</td>
						<td bgcolor="#FFFFFF">
				 	 		<s:if test="#proItemInfoDto_list.itemCommissionType == 1">
						  	固定比率
						  	</s:if>
						  	<s:elseif test="#proItemInfoDto_list.itemCommissionType == 2">
						  	定额佣金
						  	</s:elseif>
						  	<s:elseif test="#proItemInfoDto_list.itemCommissionType == 3">
						  	执行司法规定
						  	</s:elseif>
				 	 	</td>
				 	 	<td bgcolor="#FFFFFF">
				 	 		<s:if test="#proItemInfoDto_list.itemCommissionType == 1">
						  		<s:property value="#proItemInfoDto_list.itemCommissionValue"/>%
						  	</s:if>
						  	<s:elseif test="#proItemInfoDto_list.itemCommissionType == 2">
						  		<s:property value="#proItemInfoDto_list.itemCommissionValue"/>
						  	</s:elseif>
						  	<s:elseif test="#proItemInfoDto_list.itemCommissionType == 3">
						  		--
						  	</s:elseif>
				 	 	</td>
				 	 	
				 	 	<td bgcolor="#FFFFFF"><s:property value="#proItemInfoDto_list.margin"/></td>
		           </tr>
	        </s:iterator>
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

	
	
	
</script>
</body>
</html>
