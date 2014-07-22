$(document).ready(function(){
	
	
});


function doSubmit(){
	var guestName = $("#guestName").val();
	var guestName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z]{1,20}$");
	if(!guestName_pattern.test(guestName)){
		$("#guestName").focus();
		alert("公司名称为中文，字母！");
		return;
	}

	var guestPhone = $("#guestPhone").val();
	var guestPhone_pattern = new RegExp("^[0-9]{11,11}$");  //...
	if(!guestPhone_pattern.test(guestPhone)){
		$("#guestPhone").focus();
		alert("联系手机不正确！"); 
		return;
	}
	
	var guestTel = $("#guestTel").val();
	var guestTel_pattern = new RegExp("^([0-9][0-9][0-9]-[0-9]{8,8}|[0-9][0-9][0-9][0-9]-[0-9]{8,8})$");  //...
	if(guestTel != null && guestTel != ""){
		if(!guestTel_pattern.test(guestTel)){
			$("#guestTel").focus();
			alert("联系电话不正确！");
			return;
		}
	}
	
	var guestEmail = $("#guestEmail").val();
	var guestEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9._-]{1,30}$");  //...
	if(!guestEmail_pattern.test(guestEmail)){
		$("#guestEmail").focus();
		alert("email不正确！");
		return;
	}
	
	document.forms[0].action="guestManage_modify";
	document.forms[0].submit();
}