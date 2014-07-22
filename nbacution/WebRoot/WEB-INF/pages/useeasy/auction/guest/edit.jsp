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
<script type="text/javascript" src="useeasy/auction/js/guest/edit.js" language="javascript"></script>
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
	  			<div class="tit">
  				<div class="l">我的注册信息</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  			
	  								  

  			<form name="" action="" method="post">

	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>用户名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionGuest.guestName" id="guestName" maxlength="50" size="50" value="<s:property value="auctionGuest.guestName"/>"/>
              	<span><font color="red">(请输入中文，字母)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">证件号码:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionGuest.guestIdentityCard"/>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>联系手机:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionGuest.guestPhone" id="guestPhone" maxlength="50" size="50" value="<s:property value="auctionGuest.guestPhone"/>"/>
              	<br/><span><font color="red">(如:13711111111，该手机号码为密码找回时使用，请正确填写)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">联系电话:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionGuest.guestTel" id="guestTel" maxlength="50" size="50" value="<s:property value="auctionGuest.guestTel"/>"/>
              	<br/><span><font color="red">(如:0513-11111111)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>email:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionGuest.guestEmail" id="guestEmail" maxlength="50" size="50" value="<s:property value="auctionGuest.guestEmail"/>"/>
              	<span><font color="red">(如:xxx@xxx.com)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 证件影像:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:if test="#request.imgUrl == null || #request.imgUrl == ''">
           			<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="120" width="160"/>
              	</s:if>
             	<s:else>
					<img src="<%=request.getContextPath()%><s:property value="#request.imgUrl"/>" height="120" width="160"/>
				</s:else>
              </td>
              
            </tr>
            <tr>
            	<td align="center" colspan="2">
            		<input class="large_btn"  type="button" value="修 改 "  onclick="doSubmit();" />
				</td>
            </tr>
          	
          	</table>
          	</form>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
</body>
</html>
