$(document).ready(function(){
	
	
});

function doUpload(){
	if($("#u_file").val() == ""){
		$("#img_sp_fir").attr("style","display:block");
		$("#img_sp_sec").attr("style","display:none");
		return;
	}
	var file_name = $("#u_file").val();
	if(file_name.substr(file_name.indexOf(".")+1) == "jpg" || file_name.substr(file_name.indexOf(".")+1) == "png"
		|| file_name.substr(file_name.indexOf(".")+1) == "jpeg"){
		$(".large_btn").hide();
		document.forms[0].target = "uploadTarget";
		document.forms[0].action="uploadImage.do?uploadType=1";
		document.forms[0].submit();
	}else{
		$("#img_sp_fir").attr("style","display:none");
		$("#img_sp_sec").attr("style","display:block");
		return;
	}
	
}
function doSubmit(){
	var companyName = $("#companyName").val();
	var companyName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,50}$");
	if(!companyName_pattern.test(companyName)){
		$("#companyName").focus();
		alert("公司名称为中文！");
		return;
	}
	var companyAddress = $("#companyAddress").val();
	var companyAddress_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,100}$");
	if(!companyAddress_pattern.test(companyAddress)){
		$("#companyAddress").focus();
		alert("公司地址为中文，数字，字母！");
		return;
	}
	var companyLinker = $("#companyLinker").val();
	var companyLinker_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z]{1,20}$");
	if(!companyLinker_pattern.test(companyLinker)){
		$("#companyLinker").focus();
		alert("联系人为中文，字母！");
		return;
	}
	var companyPhone = $("#companyPhone").val();	
	var companyPhone_pattern = new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5-/ ]{1,30}$");
	if(!companyPhone_pattern.test(companyPhone)){
		$("#companyPhone").focus();
		alert("联系电话不正确！");
		return;
	}
	var companyTel = $("#companyTel").val();	
	var companyTel_pattern = new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5-/ ]{1,30}$");
	if(companyTel != null && companyTel != ""){
		if(!companyTel_pattern.test(companyTel)){
			$("#companyTel").focus();
			alert("联系手机不正确！"); 
			return;
		}
	}
	var companyPost = $("#companyPost").val();	
	var companyPost_pattern = new RegExp("^[0-9]{6,6}$");
	if(companyPost != null && companyPost != ""){
		if(!companyPost_pattern.test(companyPost)){
			$("#companyPost").focus();
			alert("公司邮编不正确！"); 
			return;
		}
	}
	var companyEmail = $("#companyEmail").val();	
	var companyEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9._-]{1,30}$");
	if(companyEmail != null && companyEmail != ""){
		if(!companyEmail_pattern.test(companyEmail)){
			$("#companyEmail").focus();
			alert("公司email不正确！"); 
			return;
		}
	}
	document.forms[0].encoding = "application/x-www-form-urlencoded";
	document.forms[0].target = "_self";
	document.forms[0].action="companyManage_modify";
	document.forms[0].submit();
}

function fileResourceAction(){
	alert(document.forms[0]);
	document.forms[0].action="auctionManage_fileResource";
	document.forms[0].submit();
}

