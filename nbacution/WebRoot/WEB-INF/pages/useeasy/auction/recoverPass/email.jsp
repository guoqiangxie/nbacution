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
<link href="useeasy/auction/css/register/signup.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="useeasy/auction/js/recoverPass/email.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台--邮箱找回密码</title>

</head>
<body>
<div class="container">
	<div class="container">
		<div class="topnav">
			<div class="logo"></div>				 
		</div>
	</div>
	<div class="nav">
		<div class="line"></div>
		
	</div>
	
	<!--main-->
	<div class="main">
		<!--left-->
		<div class="left">
			<ul>
			<li><a href="recoverPassManage_phone">手机找回密码</a></li>
			<li><span>邮箱找回密码</span></li>
			</ul>
		</div>
		<!--end left-->
		
		<!--right-->
		<div class="right">
	  	<div class="title">邮箱找回密码</div>
		<form  action="" name="passwordForm" method="post">
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
        	<tr>
            	<td width="40%" align="right" bgcolor="#FFFFFF"><font color="red">*</font> 账号名:</td>
              	<td width="60%" bgcolor="#FFFFFF">
			 		<input type="text" id="usAccount" name="usAccount"  size="20" maxlength="20" tabindex="1"/> 
			  	</td>
            </tr>
            <tr>
              	<td align="right" bgcolor="#FFFFFF"><font color="red">*</font> 验证码:</td>
              	<td bgcolor="#FFFFFF">
			 		<span><input name="validatecode" id="validatecode" class="input" maxlength="4" size="6" tabindex="2"/></span>
					<img id="validationImage" title="换一张" src="" style="cursor:pointer;" />
			  	</td>
            </tr>
			<tr>
              	<td bgcolor="#FFFFFF" align="right"><font color="red">*</font> 邮箱密码:</td>
              	<td bgcolor="#FFFFFF">
                	<input name="passcode" id="passcode" type="password" maxlength="6" size="6" tabindex="3"/>
                	<span id="getPass_div">
                 	<a href="###" onclick="sendEmailPass();" ><font color="red">获取邮箱密码</font></a>
                 	</span>
                 	<span id="getPass_mes">
                 	<font color="red">处理中，请稍等</font>
                 	</span>
			  	</td>
            </tr> 
            <tr>
            	<td colspan="2" align="center">
					<input type="button" onclick="doSubmit();" value="登  录 "/>
				</td>
            </tr>
       	</table>
        </form>
         <p>温馨提示：<br/>
        	 账号名+邮箱密码<br/>
        	1、获取邮箱密码：请您输入所要的账号名，验证码，点击“<font color="red">获取邮箱密码</font>”，<br/>
         	您的email将收到邮箱临时密码（六位数字，当日内有效），凭此临时密码进行身份验证。<br/>
         	如您没有收到随机邮箱密码，请稍等片刻后重新点击“<font color="red">获取邮箱密码</font>”，系统将为您进行重发，请确保您的网络正常接收Email。<br/>
         	2、系统登录：请您输入所要的账号名，验证码以及获取的邮箱密码，点击“登录”即可登录账号管理进行密码设置。<br/>
         	3、每天最多发送3次邮箱密码。
        </p>
	    </div>
		<!--end right-->
	</div>
	<!--end main-->
	
	<!--footer-->
	<jsp:include page="../main/footer.jsp" flush="true"/>
</div>
	<script language="javascript" type="text/javascript">
		$("#validationImage").attr("src","validationCode_recoverPassEmail");
	</script>
	<s:if test="#request.checkFlag == 1">
		<script language="javascript" type="text/javascript">
		alert("账号不正确！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 2">
		<script language="javascript" type="text/javascript">
			$("#validatecode").val("");
			$("#validatecode").focus();
			alert("验证码不正确！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 3">
		<script language="javascript" type="text/javascript">
			alert("邮件发送次数超过3次了，每天只能发送3次！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 4">
		<script language="javascript" type="text/javascript">
			alert("账号未激活，请先在邮箱中激活此账号！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 5">
		<script language="javascript" type="text/javascript">	
			alert("账号被停用，请联系上拍协管理员！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 6">
		<script language="javascript" type="text/javascript">
			alert("邮件已经发送，请确认接收！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 7">
		<script language="javascript" type="text/javascript">
		alert("账号或密码不正确！");
		</script>
	</s:if>
	<s:if test="#request.checkFlag == 8">
	<script language="javascript" type="text/javascript">
		alert("密码修改成功！");
	</script>
	</s:if>
</body>
</html>