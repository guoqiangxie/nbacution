$(document).ready(function(){
	
	$("#validationImage").click(function(){  
		$("#validationImage").attr("src","validationCode_login?t="+Math.random());
	});
	
	$(".loginpic").click(function(){
		doLogin();
	});
	
	$("#logout_a").click(function(){
		doLogout();
	});
	
});

function doLogin(){
	var usAccount = $("#usAccount").val();
	var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9_]{0,19}$");
	if(!usAccount_pattern.test(usAccount)){
		$("#usAccount").focus();
		alert("账号名以字母开头，字母与数字，_为合法输入！");
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
	$.post('auctionLogin_login'+str, null, function(data){
		$('.login').html(data);
		$.getScript("useeasy/auction/js/main/login.js");
		
	});
}

function doLogout(){
	$.post('auctionLogin_logout', null, function(data){
		$('.login').html(data);
		$.getScript("useeasy/auction/js/main/login.js");
		 //$("#validationImage").attr("src","validationCode_login?t="+Math.random());
	});
	var oldUrl = top.location.href;
	var newSize = oldUrl.indexOf("#");
	if(newSize==-1){
		var newUrl = oldUrl;
	}else{
		var newUrl = oldUrl.substring(0, oldUrl.indexOf("#"));
	}
	top.location.href=newUrl;
	
}