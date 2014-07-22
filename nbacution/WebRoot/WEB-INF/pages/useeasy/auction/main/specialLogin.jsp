<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/login.css"	rel="stylesheet" type="text/css" />
<link href="css/admin/login.css" rel="stylesheet" type="text/css" />
<title>网络拍卖信息系统--登录</title>
</head> 

<body>
<form name="" method="post">
<div class="container">
	<div class="main">
		<div class="left"></div>
		<div class="right">
			<div class="login">
			<ul>
			<li><img src="useeasy/auction/images/main/login_icon.gif" width="168" height="40" /></li>
			<li>帐&nbsp;&nbsp;号: <input name="usAccount" id="usAccount" type="text" size="19" maxlength="20" tabindex="1" onkeydown="if (event.keyCode==13) javascript:doLogin();" /></li>
			<li>密&nbsp;&nbsp;码: <input type="password" name="usAccountPass" id="usAccountPass" size="20" maxlength="20" tabindex="2" onkeydown="if (event.keyCode==13) javascript:doLogin();" /></li>
			<li>验证码: <input name="validatecode" id="validatecode" class="input" maxlength="4" size="6" tabindex="3" onkeydown="if (event.keyCode==13) javascript:doLogin();"/>&nbsp;<img id="validationImage" title="换一张" src="" style="cursor:pointer;" /></li>
			<li>
			<span>
			<img class="loginpic" src="useeasy/auction/images/main/login_btn01over.gif"  border="0" width="87" height="29" style="cursor: pointer; border: 0;"/>
			<input  type="hidden" value="<s:property value="#request.requestUrl"/>" name="requestUrl"/>
			</span>&nbsp;&nbsp;
			<a href="recoverPassManage_phone" target="_blank"><img src="useeasy/auction/images/main/login_btn02over.gif" border="0" /></a></li>
			</ul>
			</div>
			<div class="register">
				<span class="text">还没有自己的账号吗？</span>
				<span class="btn"><a  href="registerManage_register" target="_blank"><img src="useeasy/auction/images/main/login_ok.gif" border="0"/></a></span>
			</div>
		</div>
	</div> 
</div>
</form> 
<!--footer-->
<jsp:include page="../main/footer.jsp" flush="true"/>
<!--end footer-->
<script language="javascript" type="text/javascript">
	$("#validationImage").attr("src","validationCode_specialLogin");
	
	$("#validationImage").click(function(){  
		$("#validationImage").attr("src","validationCode_specialLogin?t="+Math.random());
	});
	
	$(".loginpic").click(function(){
		doLogin();
	});
	
	function doLogin(){
		var usAccount = $("#usAccount").val();
		var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9]{0,19}$");
		if(!usAccount_pattern.test(usAccount)){
			$("#usAccount").focus();
			alert("账号名以字母开头，字母与数字为合法输入！");
			return;
		}
		
		var usAccountPass = $("#usAccountPass").val();
		var usAccountPass_pattern = new RegExp("^[A-Za-z0-9]{1,20}$");
		if(!usAccountPass_pattern.test(usAccountPass)){
			$("#usAccountPass").val("");
			$("#usAccountPass").focus();
			alert("密码以字母与数字为合法输入！");
			return;
		}
		
		var validatecode = $("#validatecode").val();
		var validatecode_pattern = new RegExp("^[0-9]{4,4}$"); 
		if(!validatecode_pattern.test(validatecode)){  
			alert("验证码以数字为合法输入！");
			$("#validatecode").val("");
			$("#validatecode").focus();
			return;
		}
		
		var str = "?usAccount="+usAccount+"&usAccountPass="+usAccountPass+"&validatecode="+validatecode;
		document.forms[0].action="auctionLogin_specialDoLogin"+str;
		document.forms[0].submit();
	
	}
</script>
<s:if test="#request.checkFlag == 1">
	<script language="javascript" type="text/javascript">	
		$("#validatecode").focus(); 
		alert("验证码不正确！");
	</script>
</s:if>
<s:if test="#request.checkFlag == 2">
	<script language="javascript" type="text/javascript">
		$("#usAccount").focus();
		$("#usAccount").val("");
		$("#usAccountPass").val("");
		alert("用户名密码不正确！");
	</script>
</s:if>
<s:if test="#request.checkFlag == 3">
	<script language="javascript" type="text/javascript">	
		$("#usAccount").focus();
		$("#usAccount").val("");
		$("#usAccountPass").val("");
		alert("账号未激活，请在邮箱中激活账号！");
	</script>
</s:if>
<s:if test="#request.checkFlag == 4">
	<script language="javascript" type="text/javascript">	
		$("#usAccount").focus();
		$("#usAccount").val("");
		$("#usAccountPass").val("");
		alert("账号被停用，请联系上拍协管理员！");
	</script>
</s:if>
<s:if test="#request.checkFlag == 5">
	<script language="javascript" type="text/javascript">	
		$("#usAccount").focus();
		$("#usAccount").val("");
		$("#usAccountPass").val("");
		alert("账号状态出现异常，请联系上拍协管理员！");
	</script>
</s:if>
<s:if test="#request.checkFlag == 6">
	<script language="javascript" type="text/javascript">	
		$("#usAccount").focus();
		$("#usAccount").val("");
		$("#usAccountPass").val("");
		alert("账号出现重复，请联系上拍协管理员！");
	</script>
</s:if>
</body>
</html>




	
