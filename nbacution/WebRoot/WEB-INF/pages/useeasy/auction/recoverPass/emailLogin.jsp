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
<script type="text/javascript" src="useeasy/auction/js/recoverPass/email.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台</title>

</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			
		
			<div class="msg">
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  >
				<s:iterator value="auctionTopInfo_list" var="aucTopInfo_list">
				</s:iterator>
				</MARQUEE>
			</div>
		</div>
		<!--end header-->	
		
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
			<ul>
				<li><span>密码修改</span></li>
			</ul>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
  				<div class="l">密码修改</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  		<form name="myform" action="" method="post">
	   		<input type="hidden" name="usAccount" value="<s:property value='#request.usAccount'/>" />
	   		<input type="hidden" name="validatecode" value="<s:property value='#request.validatecode'/>" />
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	
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
              	
              </td>
            </tr>
          	<tr>
            	<td align="center" colspan="2">
            		<input class=large_btn  type=button value="修 改 "  onclick="doPassModify();" />
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
<s:if test="checkValidateFlag == 7">
	<script language="javascript" type="text/javascript">
		alert("密码修改成功！");
	</script>
</s:if>
</body>
</html>
