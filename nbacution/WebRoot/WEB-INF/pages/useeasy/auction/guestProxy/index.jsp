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
  				<div class="l">我的代理价</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="guestProxy_index?searchType=1">【全部】</a>
	  			<a style="color:blue; font-weight:bold;"  href="guestProxy_index?searchType=2">【可设置】</a>
	  			<a style="color:blue; font-weight:bold;"  href="guestProxy_index?searchType=3">【可查看】</a>
	  			</div>
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <td width="30%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="30%" bgcolor="#FFFFFF">拍卖公司</td>
			  <td width="20%" bgcolor="#FFFFFF">申请时间</td>
			  <td width="20%" bgcolor="#FFFFFF">状态</td>
            </tr>
            <s:iterator value="applyInfoProxy_list" var="appInfoProxy_list">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#appInfoProxy_list.auctionName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfoProxy_list.companyName"/></td>
					  <td bgcolor="#FFFFFF"><s:date name="#appInfoProxy_list.createTime" format="yyyy-MM-dd HH:mm"/></td>
					  <td bgcolor="#FFFFFF" class="state">
					  	<s:if test="#appInfoProxy_list.auctionStatus == 0">
            				尚未开始<br/>
            				<a href="guestProxy_handle?searchType=1&auctionFlag=<s:property value="#appInfoProxy_list.auctionId"/>"><font color="red">设置代理价</font></a>
            			</s:if>
            			<s:elseif test="#appInfoProxy_list.auctionStatus == 1">
            				正在进行<br/>
            				<a href="guestProxy_detail?auctionFlag=<s:property value="#appInfoProxy_list.auctionId"/>"><font color="red">查看代理价</font></a>
            			</s:elseif>
            			<s:elseif test="#appInfoProxy_list.auctionStatus == 2">
            				已经结束<br/>
            				<a href="guestProxy_detail?auctionFlag=<s:property value="#appInfoProxy_list.auctionId"/>"><font color="red">查看代理价</font></a>
            			</s:elseif>
					  </td>
		            </tr>
	        </s:iterator>
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
