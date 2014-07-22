<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
	
	<div class="input01">帐 &nbsp;号：
	<span><input name="usAccount" id="usAccount" type="text" size="19" maxlength="20" tabindex="1" onkeydown="if (event.keyCode==13) javascript:doLogin();" /></span>
	</div>
	<div class="input02">密 &nbsp;码：
	<span><input type="password" name="usAccountPass" id="usAccountPass" size="20" maxlength="20" tabindex="2" onkeydown="if (event.keyCode==13) javascript:doLogin();" /></span>
	</div>
	<div class="input03">验证码：
	<span><input name="validatecode" id="validatecode" class="input" maxlength="4" size="6" tabindex="3" onkeydown="if (event.keyCode==13) javascript:doLogin();"/></span>
	<img id="validationImage" title="换一张" src="" style="cursor:pointer;" /> 
	</div>
	<span class="register"><a  href="registerManage_register" target="_blank">注册</a></span>
	<span class="code"><a href="recoverPassManage_phone" target="_blank">找回密码</a></span>
	
	<div class="land">
	<img class="loginpic" src="useeasy/auction/images/main/login_in.gif"  border="0" width="103" height="29" style="cursor: pointer; border: 0;"/>
	</div>   
	<script language="javascript" type="text/javascript">
		$("#validationImage").attr("src","validationCode_login");
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
