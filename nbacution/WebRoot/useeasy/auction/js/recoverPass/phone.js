$(document).ready(function(){
	$("#getPass_div").show();
	$("#getPass_mes").hide();
	
	$("#validationImage").click(function(){  
		$("#validationImage").attr("src","validationCode_recoverPassPhone?t="+Math.random());
	});
});

function sendPhonePass(){
	var usAccount = $("#usAccount").val();
	var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9]{0,19}$");
	
	if(!usAccount_pattern.test(usAccount)){
		$("#usAccount").val("");
		$("#usAccount").focus();
		alert("账号名不正确！");
		return;
	}
	
	var authCode = $("#validatecode").val();
	var authCode_pattern = new RegExp("^[0-9]{4,4}$"); 
	if(!authCode_pattern.test(authCode)){  
		alert("验证码以数字为合法输入！");
		$("#validatecode").val("");
		$("#validatecode").focus();
		return;
	}
	
	$("#getPass_div").hide();
	$("#getPass_mes").show();
	
	document.forms[0].action="recoverPassManage_getPhonePass";
	document.forms[0].submit();
}

function doSubmit(){
	
	var usAccount = $("#usAccount").val();
	var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9]{0,19}$");
	if(!usAccount_pattern.test(usAccount)){
		$("#usAccount").val("");
		$("#usAccount").focus();
		alert("账号名不正确！");
		return;
	}
	
	var authCode = $("#validatecode").val();
	var authCode_pattern = new RegExp("^[0-9]{4,4}$"); 
	if(!authCode_pattern.test(authCode)){  
		alert("验证码以数字为合法输入！");
		$("#validatecode").val("");
		$("#validatecode").focus();
		return;
	}

	var passcode = $("#passcode").val();
	var passcode_pattern = new RegExp("^[A-Za-z0-9]{6,6}$");
	if(!passcode_pattern.test(passcode)){
		$("#passcode").val("");
		$("#passcode").focus();
		alert("邮箱密码不正确！");
		return;
	}
	
	document.forms[0].action="recoverPassManage_doPhoneSubmit";
	document.forms[0].submit();
}

function doPassModify(){
	
	var accountNewPass = $("#accountNewPass").val();
	var accountNewPass_pattern = new RegExp("^[a-zA-Z0-9]{3,50}$");
	if(!accountNewPass_pattern.test(accountNewPass)){
		$("#accountNewPass").focus();
		$("#accountNewPass").val("");
		alert("新密码为字母，数字,至少3位！");
		return;
	}
	var accountConfirmPass = $("#accountConfirmPass").val();
	var accountConfirmPass_pattern = new RegExp("^[a-zA-Z0-9]{3,50}$");
	if(!accountConfirmPass_pattern.test(accountConfirmPass)){
		$("#accountConfirmPass").focus();
		$("#accountConfirmPass").val("");
		alert("确认密码为字母，数字,至少3位！");
		return;
	}
	if(accountConfirmPass != accountNewPass){
		$("#accountConfirmPass").focus();
		$("#accountConfirmPass").val("");
		alert("2次密码确认不匹配！");
		return;
	}
	
	document.forms[0].action="recoverPassManage_phoneModifySubmit";
	document.forms[0].submit();
}
