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
		<div id="shx"></div>
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
	  	  <div class="tit">
		  	<div class="l">拍卖标的目录</div>
		  	<div class="r">
		  		<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
  			</div>
		  </div>
		  
 		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">
			  
              <td width="10%" bgcolor="#FFFFFF">拍品序号</td>
              <td width="10%" bgcolor="#FFFFFF">显示编号</td>
			  <td width="20%" align="center" bgcolor="#FFFFFF">拍品名称</td>
		 	  <td width="10%" bgcolor="#FFFFFF">保证金</td>
			  <td width="10%" bgcolor="#FFFFFF">起拍价</td>
			  <td width="10%" bgcolor="#FFFFFF">加价幅度</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金方式</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金数额</td>
			  <td width="10%" bgcolor="#FFFFFF">管理</td>
            </tr>
            	
            	<s:iterator value="#request.itemInfoDtoList" var="iInfo_list" status="status">
            		<tr align="center" id="">
		
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemNumber"/></td>
			              <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.viewOrder"/></td>
						  <td bgcolor="#FFFFFF"  width="100"><s:property value="#iInfo_list.itemName"/></td>
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.margin"/></td>
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemPrice"/></td>
						  <td bgcolor="#FFFFFF"><s:property value="#iInfo_list.itemPriceRange"/></td>
						  <td bgcolor="#FFFFFF">
						  	<s:if test="#iInfo_list.itemCommissionType == 1">
						  	固定比率
						  	</s:if>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
						  	定额佣金
						  	</s:elseif>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
						  	执行最高院司法规定
						  	</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 4">
						            浙江省高级人民法院 
						       </s:elseif>
							<s:elseif test="#iInfo_list.itemCommissionType == 5">
						           慈溪市人民法院 
						       </s:elseif>
							<s:elseif test="#iInfo_list.itemCommissionType == 6">
							 镇海区人民法院 
						  </s:elseif>
						  </td>
						  <td bgcolor="#FFFFFF">
						  	<s:if test="#iInfo_list.itemCommissionType == 1">
						  		<s:property value="#iInfo_list.itemCommissionValue"/>%
						  	</s:if>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
						  		<s:property value="#iInfo_list.itemCommissionValue"/>
						  	</s:elseif>
						 <s:elseif test="#iInfo_list.itemCommissionType == 4">
						 浙江省高级人民法院 
						</s:elseif>
							<s:elseif test="#iInfo_list.itemCommissionType == 5">
						 慈溪市人民法院 
						</s:elseif>
							<s:elseif test="#iInfo_list.itemCommissionType == 6">
							 镇海区人民法院 
						</s:elseif>
						  	
						  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
						  		执行最高院司法规定
						  	</s:elseif>
						  </td>
						  <td bgcolor="#FFFFFF">
							  <s:if test="#iInfo_list.itemLockFlag == 0"><img src="useeasy/auction/images/main/lock.gif"/></s:if>
							  <a href="itemManage_detail?itemFlag=<s:property value="#iInfo_list.id"/>" >查看</a>
						  	  <a href="javascript:void(0);" onclick="showItemPrice('<s:property value="#iInfo_list.id"/>');return false;">竞买记录</a>
						  </td>
						</tr>
			</s:iterator>
			<tr align="left" >
				
			</tr>
          </table>
         </div>
		<!--end right-->
		</div>
		<!--end main-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	 	<!--footer-->
	</div>
<script language="javascript" type="text/javascript">
	function showItemPrice(str){
		window.showModalDialog("itemManage_showPrice?itemFlag="+str, "","dialogWidth=500px;dialogHeight=500px"); 
	}
</script>
</body>
</html>
