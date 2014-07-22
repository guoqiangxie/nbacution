$(document).ready(function(){
	$("#validationImage").click(function(){  
		$("#validationImage").attr("src","validationCode_register?t="+Math.random());
	});
});

function doUpload(){
	if($("#u_file").val() == ""){
		$("#u_file").focus();
		alert("请上传自定义图标！");
		return;
	}
	
	var file_name = $("#u_file").val();
	if(file_name.substr(file_name.indexOf(".")+1) == "jpg" || file_name.substr(file_name.indexOf(".")+1) == "png"
		|| file_name.substr(file_name.indexOf(".")+1) == "jpeg" || file_name.substr(file_name.indexOf(".")+1) == "JPEG" || file_name.substr(file_name.indexOf(".")+1) == "JPG"){
		$(".buttonWrapper").hide();
		document.forms[0].target = "uploadTarget";
		document.forms[0].action="uploadImage.do?uploadType=3";
		document.forms[0].submit();
	}else{
		$("#u_file").focus();
		alert("文件类型为jpg,jpeg,png,JPEG！");
		return;
	}
	
}

function checkAccountName(){
	var usAccount = $("#usAccount").val();
	var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9_]{6,19}$");
	var usAccount_pattern1 = new RegExp("^[A-Za-z][A-Za-z0-9_]{6,19}$");
	if(!usAccount_pattern1.test(usAccount)){
		alert("账号名字母开头并长度应大于6位");
		return;
	}
	
	if(!usAccount_pattern.test(usAccount)){
		$("#name_err_fir").show();
		$("#name_err_sec").hide();
		$("#name_suc").hide();
		return;
	}else{
		$.post('registerManage_checkAccount?usAccountFlag='+usAccount, null, function(data){
			if(data==1){
				$("#name_err_fir").hide();
				$("#name_err_sec").hide();
				$("#name_suc").show();
				return;
			}else{
				$("#name_err_fir").hide();
				$("#name_err_sec").show();
				$("#name_suc").hide();
				return;
			}
		});
		
	}
}

function checkAccountPass(){
	var usAccountPass = $("#usAccountPass").val();
	var usAccountPass_pattern = new RegExp("^[A-Za-z0-9]{6,20}$");  
	var usAccountPass_pattern1 = new RegExp("^.*[a-zA-Z]+.*$");  
	var usConfirmPass_val = $("#usConfirmPass").val();
	
	if(!usAccountPass_pattern.test(usAccountPass)){
		$("#pass_err_fir").show();
		$("#pass_suc").hide();
		return;
	}else if(!usAccountPass_pattern1.test(usAccountPass)){
		$("#pass_err_fir").hide();
		alert("密码长度应大于6位并含有字母");
		return;
	}
	
	else{
		$("#pass_err_fir").hide();
		$("#pass_suc").show();
		if(usConfirmPass_val == usAccountPass){
			$("#passCon_err_fir").hide();
			$("#passCon_err_sec").hide();
			$("#passCon_suc").show();
			return;
		}else{
			$("#passCon_err_fir").hide();
			$("#passCon_err_sec").show();
			$("#passCon_suc").hide();
			return;
		}
	}
}

function checkConfirmAccountPass(){
	var usAccountConfirmPass = $("#usConfirmPass").val();
	var usAccountConfirmPass_pattern = new RegExp("^[A-Za-z0-9]{6,20}$");
	var usAccountConfirmPass_pattern1 = new RegExp("^.*[a-zA-Z]+.*$");  
	
	var usAccountPass_val = $("#usAccountPass").val();
	
	if(!usAccountConfirmPass_pattern.test(usAccountConfirmPass)){
		$("#passCon_err_fir").show();
		$("#passCon_err_sec").hide();
		$("#passCon_suc").hide();
		return;
	}else if(!usAccountConfirmPass_pattern1.test(usAccountConfirmPass)){
		alert("密码长度应大于6位并含有字母");
		$("#passCon_err_fir").hide();
		return;
	}
	
	else{
		if(usAccountPass_val == usAccountConfirmPass){
			$("#passCon_err_fir").hide();
			$("#passCon_err_sec").hide();
			$("#passCon_suc").show();
			return;
		}else{
			$("#passCon_err_fir").hide();
			$("#passCon_err_sec").show();
			$("#passCon_suc").hide();
			return;
		}
	}
}

function checkUserName(){
	var userName = $("#userName").val();
	var userName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z]{1,20}$");  
	
	if(!userName_pattern.test(userName)){
		$("#userName_err").show();
		$("#userName_suc").hide();
		return;
	}else{
		$("#userName_err").hide();
		$("#userName_suc").show();
		return;
	}
}

function checkIdentityCard(){
  if( $("#card1").attr("checked") ){
	
	var identityCard = $("#identityCard").val();
	var identityCard_pattern = new RegExp("^([0-9]{15,15}|[0-9]{17,17}[0-9xX])$");  
	
	if(!identityCard_pattern.test(identityCard)){
		$("#identityCard_err").show();
		$("#identityCard_suc").hide();
		return;
	}else{
		$("#identityCard_err").hide();
		$("#identityCard_suc").show();
		return;
	}
	}
  
//  if($("#card2").attr("checked")){
//	  var identityCard = $("#identityCard").val();
//	  var identityCard_pattern = new RegExp("^[A-Za-z0-9]|[- -_&-*_]{40}$"); 
//	  
//	  if(!identityCard_pattern.test(identityCard)){
//			alert("其他证件类型 的编号不为空及特殊字符");
//			return;
//		}
//  }
}

 
function checkUserPhone(){
	var userPhone = $("#userPhone").val();
	var userPhone_pattern = new RegExp("^[0-9]{11,11}$");  //...
	
	if(!userPhone_pattern.test(userPhone)){
		$("#userPhone_err").show();
		$("#userPhone_suc").hide();
		return;
	}else{
		$("#userPhone_err").hide();
		$("#userPhone_suc").show();
		return;
	}
}

function checkUserTel(){
	var userTel = $("#userTel").val();
	var userTel_pattern = new RegExp("^([0-9][0-9][0-9][0-9]-[0-9]{8,8}|[0-9][0-9][0-9][0-9]-[0-9]{8,8})$");
	
	if(userTel != null && userTel != ""){
		if(!userTel_pattern.test(userTel)){
			$("#userTel_err").show();
			$("#userTel_suc").hide();
			return;
		}else{
			$("#userTel_err").hide();
			$("#userTel_suc").show();
			return;
		}
	}else{
		$("#userTel_err").hide();
		$("#userTel_suc").hide();
		return;
	}
}


function checkUserEmail(){
	var userEmail = $("#userEmail").val();
	var userEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9._-]{1,30}$");  
	if(!userEmail_pattern.test(userEmail)){
		$("#userEmail_err").show();
		$("#userEmail_suc").hide();
		return;
	}else{
		$("#userEmail_err").hide();
		$("#userEmail_suc").show();
		return;
	}
}

function doSubmit(){
	
	var usAccount = $("#usAccount").val();
	var usAccount_pattern = new RegExp("^[A-Za-z][A-Za-z0-9]{6,19}$");
	var usAccount_pattern1 = new RegExp("^[A-Za-z][A-Za-z0-9_]{6,19}$");
	if(!usAccount_pattern1.test(usAccount)){
		alert("账号名字母开头并长度应大于6位");
		return;
	}
	if(!usAccount_pattern.test(usAccount)){
		$("#usAccount").focus();
		$("#name_err_fir").show();
		$("#name_err_sec").hide();
		$("#name_suc").hide();
		return;
	}
	
	var usAccountPass = $("#usAccountPass").val();
	var usAccountPass_pattern = new RegExp("^[A-Za-z0-9]{1,20}$");  
	
	if(!usAccountPass_pattern.test(usAccountPass)){
		$("#usAccountPass").focus();
		$("#pass_err_fir").show();
		$("#pass_suc").hide();
		return;
	}
	
	var usAccountConfirmPass = $("#usConfirmPass").val();
	var usAccountConfirmPass_pattern = new RegExp("^[A-Za-z0-9]{1,20}$");  
	
	if(!usAccountConfirmPass_pattern.test(usAccountConfirmPass)){
		$("#usConfirmPass").focus();
		$("#passCon_err_fir").show();
		$("#passCon_err_sec").hide();
		$("#passCon_suc").hide();
		return;
	}else{
		if(usAccountPass != usAccountConfirmPass){
			$("#usConfirmPass").focus();
			$("#passCon_err_fir").hide();
			$("#passCon_err_sec").show();
			$("#passCon_suc").hide();
			return;
		}else{
			$("#pass_suc").show();
		}
	}
	
	var userName = $("#userName").val();
	var userName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z]{1,20}$");  
	
	if(!userName_pattern.test(userName)){
		$("#userName").focus();
		$("#userName_err").show();
		$("#userName_suc").hide();
		return;
	}
	
	if( $("#card1").attr("checked") ){
		
		var identityCard = $("#identityCard").val();
		var identityCard_pattern = new RegExp("^([0-9]{15,15}|[0-9]{17,17}[0-9xX])$");  
		
		if(!identityCard_pattern.test(identityCard)){
			$("#identityCard").focus();
			$("#identityCard_err").show();
			$("#identityCard_suc").hide();
			return;
		} 
  }
	
	
	
 
//	  if($("#card2").attr("checked")){
//		  var identityCard = $("#identityCard").val();
//		  var identityCard_pattern = new RegExp("^[A-Za-z0-9]{1,40}$"); 
//		  
//		  if(!identityCard_pattern.test(identityCard)){
//				alert("其他证件类型 的编号不为空及特殊字符");
//				return;
//			}
//	  }
	
	var userPhone = $("#userPhone").val();
	var userPhone_pattern = new RegExp("^[0-9]{11,11}$"); 
	
	if(!userPhone_pattern.test(userPhone)){
		$("#userPhone").focus();
		$("#userPhone_err").show();
		$("#userPhone_suc").hide();
		return;
	}
	
	var userTel = $("#userTel").val();
	var userTel_pattern = new RegExp("^([0-9][0-9][0-9]-[0-9]{8,8}|[0-9][0-9][0-9][0-9]-[0-9]{8,8})$"); 
	
	if(userTel != null && userTel != ""){
		$("#userTel").focus();
		if(!userTel_pattern.test(userTel)){
			$("#userTel_err").show();
			$("#userTel_suc").hide();
			return;
		}
	}
	
	var userEmail = $("#userEmail").val();
	//var userEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9_-]{1,30}.[a-zA-Z]{1,30}$");  
	var userEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9._-]{1,30}$");
	if(!userEmail_pattern.test(userEmail)){
		$("#userEmail").focus();
		$("#userEmail_err").show();
		$("#userEmail_suc").hide();
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
	
	if(!$("#agreement")[0].checked){
		alert("请确认用户注册协议");
		return;
	}
	
	if($("#u_file").val() == ''){
	}else{
		if($("#customPicVal").val() == ''){
			$("#u_file").focus();
			alert("请确认上传图片");
			return;
		}
	}
	
	document.forms[0].encoding = "application/x-www-form-urlencoded";
	document.forms[0].target = "_self";
	document.forms[0].action="registerManage_doRegister";
	document.forms[0].submit();

}
