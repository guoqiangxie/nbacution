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
<script type="text/javascript" src="useeasy/auction/js/admin/passEdit.js" language="javascript"></script>
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
			<span class="topbtn">
			<a href="auctionSpecial_index">
			<img src="useeasy/auction/images/main/top_btn01.gif" border=0/></a>
			<a href="auctionInteration_index">
			<img src="useeasy/auction/images/main/top_btn02.gif" border=0/></a>
			</span> 
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
  				<div class="l">密码修改</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">账号名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:property value="#session._listener.auctionAccount.accountName"/>
              </td>
            </tr>
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>原密码:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="password" name="accountPass" id="accountPass" maxlength="50" size="50" value=""/>
              	<span><font color="red">(请输入数字，字母,至少3位)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>新密码:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="password" name="accountNewPass" id="accountNewPass" maxlength="50" size="50" value=""/>
              	<span><font color="red">(请输入数字，字母,至少3位)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>确认密码:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="password" name="accountConfirmPass" id="accountConfirmPass" maxlength="50" size="50" value=""/>
              	<span><font color="red">(请输入数字，字母,至少3位)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"></td>
              <td bgcolor="#FFFFFF">
              	<font color="red">&nbsp;<span id="mess_sp" style="display:none"></span></font>
              	<s:if test="#request.checkFlag == 1">
              	<font color="red"><span id="err_sp">原密码不正确！</span></font> 
              	</s:if>
              	<s:elseif test="#request.checkFlag == 2">
             	<font color="blue"><span id="err_sp">密码修改成功！</span></font> 
              	</s:elseif>
              </td>
            </tr>
          	<tr>
            	<td align="center" colspan="2">
            		<input class=large_btn  type=button value="修 改 "  onclick="doSubmit();" />
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
