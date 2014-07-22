$(document).ready(function(){
	
	
});

function doSubmit(){
	var accountPass = $("#accountPass").val();
	var accountPass_pattern = new RegExp("^[a-zA-Z0-9]{3,20}$");
	if(!accountPass_pattern.test(accountPass)){
		$("#accountPass").focus();
		$("#accountPass").val("");
		$("#mess_sp").html("原密码为字母，数字,至少3位！");
		$("#mess_sp").show();
		$("#err_sp").hide();
		return;
	}
	var accountNewPass = $("#accountNewPass").val();
	var accountNewPass_pattern = new RegExp("^[a-zA-Z0-9]{3,20}$");
	if(!accountNewPass_pattern.test(accountNewPass)){
		$("#accountNewPass").focus();
		$("#accountNewPass").val("");
		$("#mess_sp").html("新密码为字母，数字,至少3位！");
		$("#mess_sp").show();
		$("#err_sp").hide();
		return;
	}
	var accountConfirmPass = $("#accountConfirmPass").val();
	var accountConfirmPass_pattern = new RegExp("^[a-zA-Z0-9]{3,20}$");
	if(!accountConfirmPass_pattern.test(accountConfirmPass)){
		$("#accountConfirmPass").focus();
		$("#accountConfirmPass").val("");
		$("#mess_sp").html("确认密码为字母，数字,至少3位！");
		$("#mess_sp").show();
		$("#err_sp").hide();
		return;
	}
	if(accountConfirmPass != accountNewPass){
		$("#accountConfirmPass").focus();
		$("#accountConfirmPass").val("");
		$("#mess_sp").html("2次密码确认不匹配！");
		$("#mess_sp").show();
		$("#err_sp").hide();
		return;
	}
	document.forms[0].action="companyManage_passModify";
	document.forms[0].submit();
}