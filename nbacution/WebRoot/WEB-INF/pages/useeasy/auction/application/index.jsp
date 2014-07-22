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
  				<div class="l">我的参拍申请</div> 
	  			<div class="r">
	  			</div>
	  			</div> 
	  			<form name="" action="" method="post" >
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <td width="20%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖公司</td>
			  <td width="20%" bgcolor="#FFFFFF">申请时间</td>
			  <td width="20%" bgcolor="#FFFFFF">拍牌号</td>
			  <td width="10%" bgcolor="#FFFFFF">在线支付</td>
			  <td width="10%" bgcolor="#FFFFFF">状态</td>
			  
            </tr>
            <s:iterator value="applyInfo_list" var="appInfo_list">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#appInfo_list.auctionName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list.companyName"/></td>
					  <!--<td bgcolor="#FFFFFF"><s:property value="#appInfo_list.applyContent"/></td>-->
					  <td bgcolor="#FFFFFF"><s:date name="#appInfo_list.createTime" format="yyyy-MM-dd HH:mm"/></td>
					  <td bgcolor="#FFFFFF"><s:property value="#appInfo_list.bidNum"/></td>
					  <td bgcolor="#FFFFFF" class="state">
					  	<s:if test="#appInfo_list.auctionWebPay == 1 && #appInfo_list.auctionStatus == 0">
       						<a href="guestApplication_showApply?applyFlag=<s:property value="#appInfo_list.id"/>"><font color="red">支付保证金</font></a>
       					</s:if>
       					<s:else>
       						<font color="grey">支付保证金</font>
         				</s:else>
            			
					  </td>
					  <td bgcolor="#FFFFFF" class="state">
					  	<s:if test="#appInfo_list.applyStatus == 0">
           					尚未审核<br/>
           					<a href="###" onclick="doCancelApply(<s:property value="#appInfo_list.id"/>);"><font color="red">取消申请</font></a>
           				</s:if>
           				<s:elseif test="#appInfo_list.applyStatus == 1">
            				尚未授权<br/>
            				<a href="###" onclick="doCancelApply(<s:property value="#appInfo_list.id"/>);"><font color="red">取消申请</font></a>
            			</s:elseif>
            			<s:elseif test="#appInfo_list.applyStatus == 2">
            				已经授权<br/>
            			</s:elseif>
           				
           			</td>
            		
		            </tr>
	        </s:iterator>
          </table>
          </form>
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

function doCancelApply(str){
	if(confirm("请注意：确定后将取消对该场拍卖会的竞买申请，已付保证金会保留，是否取消该申请！")){
		document.forms[0].target = "_self";
	 	document.forms[0].action = "guestApplication_cancelApply?applyFlag="+str;
		document.forms[0].submit();
	}
}
	
</script>
</body>
</html>
