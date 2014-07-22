$(document).ready(function(){
	
	
});
function doUpload(){
	if($("#u_file").val() == ""){
		$("#u_file").focus();
		alert("请上传自定义图标！");
		return;
	}
	var file_name = $("#u_file").val();
	if(file_name.substr(file_name.indexOf(".")+1) == "jpg" || file_name.substr(file_name.indexOf(".")+1) == "png"
		|| file_name.substr(file_name.indexOf(".")+1) == "jpeg"){
		$(".large_btn").hide();
		document.forms[0].target = "uploadTarget";
		document.forms[0].action="uploadImage.do?uploadType=2";
		document.forms[0].submit();
	}else{
		$("#u_file").focus();
		alert("文件类型为jpg,jpeg,png！");
		return;
	}
	
}
function doSubmit(){
	var auctionName = $("#auctionName").val();
	var auctionName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,50}$");
	if(!auctionName_pattern.test(auctionName)){
		$("#auctionName").focus();
		alert("拍卖会名称为中文，数字，字母，符号，。、：“”【】《》（）—/可使用！");
		return;
	}
	var auctionAddress = $("#auctionAddress").val();
	var auctionAddress_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,100}$");
	if(!auctionAddress_pattern.test(auctionAddress)){
		$("#auctionAddress").focus();
		alert("拍卖会地点为中文，数字，字母，符号，。、：“”【】《》（）—/！");
		return;
	}
	var auctionStartTime = $("#auctionStartTime").val();
	if(auctionStartTime == null || auctionStartTime == ""){
		$("#auctionStartTime").focus();
		alert("请选择拍卖会时间！");
		return;
	}
	var auctionLinkTel = $("#auctionLinkTel").val();	
	var auctionLinkTel_pattern = new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5-/ ]{1,30}$");
	if(!auctionLinkTel_pattern.test(auctionLinkTel)){
		$("#auctionLinkTel").focus();
		alert("联系电话不正确！");
		return;
	}
	if($("#auctionType").val() == 0){
		$("#auctionType").focus();
		alert("请选择拍卖标的！");
		return;
	}
	if($("#auctionNature").val() == 0){
		$("#auctionNature").focus();
		alert("请选择拍卖会属性分类！");
		return;
	}
	if($("#auctionDelegation").val() == 0){
		$("#auctionDelegation").focus();
		alert("请选择拍卖委托分类！");
		return;
	}
	if($("#auctionForm").val() == 0){
		$("#auctionForm").focus();
		alert("请选择拍卖会形式！");
		return;
	}
	var auctionOnlineMaxUser = $("#auctionOnlineMaxUser").val();
	var auctionOnlineMaxUser_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
	if(!auctionOnlineMaxUser_pattern.test(auctionOnlineMaxUser)){
		$("#auctionOnlineMaxUser").focus();
		alert("最大竞买人在线人数为整数！");
		return;
	}else{
		if(auctionOnlineMaxUser > 50){
			$("#auctionOnlineMaxUser").focus();
			alert("最大竞买人在线人数不能大于50！");
			return;
		}
	}
	
	if($("#auctionWebPay").val() == 0){
		$("#auctionWebPay").focus();
		alert("请选择是否网上支付！");
		return;
	}else if($("#auctionWebPay").val() == 1){
		if($("#auctionWebPayCheck").val() == 0){
			$("#auctionWebPayCheck").focus();
			alert("请选择是否审核网络交付保证金！");
			return;
		}
		if($("#auctionWebPayCheck").val() == 2){
			var autoBidNum = $("#autoBidNum").val();
			var autoBidNum_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
			if(!autoBidNum_pattern.test(autoBidNum)){
				$("#autoBidNum").focus();
				alert("自动牌号为整数！");
				return;
			}
		}
		var auctionMarginMax = $("#auctionMarginMax").val();
		var auctionMarginMax_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
		if(!auctionMarginMax_pattern.test(auctionMarginMax)){
			$("#auctionMarginMax").focus();
			alert("最大保证金为整数！");
			return;
		}
		var auctionMarginLevelFir = $("#auctionMarginLevelFir").val();
		var auctionMarginLevelFir_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
		if(!auctionMarginLevelFir_pattern.test(auctionMarginLevelFir)){
			$("#auctionMarginLevelFir").focus();
			alert("第一档保证金为整数！");
			return;
		}
		if(Number(auctionMarginLevelFir) > Number(auctionMarginMax)){
			$("#auctionMarginLevelFir").focus();
			alert("第一档保证金不能大于最大保证金！");
			return;
		}
		var auctionMarginLevelSec = $("#auctionMarginLevelSec").val();
		if(auctionMarginLevelSec == ""){
		}else{
			var auctionMarginLevelSec_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
			if(!auctionMarginLevelSec_pattern.test(auctionMarginLevelSec)){
				$("#auctionMarginLevelSec").focus();
				alert("第二档保证金为整数！");
				return;
			}
			if(Number(auctionMarginLevelSec) > Number(auctionMarginMax)){
				$("#auctionMarginLevelSec").focus();
				alert("第二档保证金不能大于最大保证金！");
				return;
			}
			if(Number(auctionMarginLevelSec) < Number(auctionMarginLevelFir)){
				$("#auctionMarginLevelSec").focus();
				alert("第二档保证金不能小于最小保证金！");
				return;
			}
		}
		var auctionMarginLevelThi = $("#auctionMarginLevelThi").val();
		if(auctionMarginLevelThi == ""){
		}else{
			var auctionMarginLevelThi_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
			if(!auctionMarginLevelThi_pattern.test(auctionMarginLevelThi)){
				$("#auctionMarginLevelThi").focus();
				alert("第三档保证金为整数！");
				return;
			}
			if(Number(auctionMarginLevelThi) > Number(auctionMarginMax)){
				$("#auctionMarginLevelThi").focus();
				alert("第三档保证金不能大于最大保证金！");
				return;
			}
			if(Number(auctionMarginLevelThi) < Number(auctionMarginLevelFir)){
				$("#auctionMarginLevelThi").focus();
				alert("第三档保证金不能小于最小保证金！");
				return;
			}
		}
		if($("#auctionWebPayGoods").val() == 0){
			$("#auctionWebPayGoods").focus();
			alert("请选择是否保证金抵扣货款！");
			return;
		}
	}else{
		
	}
	
	if(!$("#auctionPicType_fir")[0].checked && 
			!$("#auctionPicType_sec")[0].checked &&
			!$("#auctionPicType_thi")[0].checked){
		$("#auctionPicType_fir").focus();
		alert("请选择拍卖会图标！");
		return;
	}else{
		if($("#auctionPicType_fir")[0].checked){
		}
		if($("#auctionPicType_sec")[0].checked){
			if($("#auctionPicVal").val() == 0){
				$("#auctionPicVal").focus();
				alert("请选择专场拍卖会图标！");
				return;
			}
		}
		if($("#auctionPicType_thi")[0].checked){
			var pic_val = $("#auctionUpLoadImgThi").attr("src");
			var pic_val_s = $("#auctionUpLoadImgFou").attr("src");
			if(pic_val.indexOf("nopic") != -1 && pic_val_s.indexOf("nopic") != -1){
				$("#u_file").focus();
				alert("请上传自定义图标！");
				return;
			}
		}
	}
	
	var auctionShortName = $("#auctionShortName").val();
	var auctionShortName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/]{1,15}$");
	if(auctionShortName == ""){
	}else{
		if(!auctionShortName_pattern.test(auctionShortName)){
			$("#auctionShortName").focus();
			alert("拍卖会简称中文，数字，字母，符号，。、：【】《》（）—/可使用！");
			return;
		}
	}
	
	/*var auctionBulletin = $("#auctionBulletin").val();
	var auctionBulletin_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,15}$");
	if(auctionBulletin == ""){
	}else{
		if(!auctionBulletin_pattern.test(auctionBulletin)){
			$("#auctionBulletin").focus();
			alert("拍卖公告为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
			return;
		}
	}
	
	var auctionNotice = $("#auctionNotice").val();
	var auctionNotice_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,2500}$");
	if(auctionNotice == ""){
	}else{
		if(!auctionNotice_pattern.test(auctionNotice)){
			$("#auctionNotice").focus();
			alert("拍卖规则为^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,2500}$！");
			return;
		}
	}
	
	var auctionGuide = $("#auctionGuide").val();
	var auctionGuide_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,2500}$");
	if(auctionGuide == ""){
	}else{
		if(!auctionGuide_pattern.test(auctionGuide)){
			$("#auctionGuide").focus();
			alert("特别规定为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
			return;
		}
	}
	
	var auctionDescription = $("#auctionDescription").val();
	var auctionDescription_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,2500}$");
	if(auctionDescription == ""){
	}else{
		if(!auctionDescription_pattern.test(auctionDescription)){
			$("#auctionDescription").focus();
			alert("备注说明为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
			return;
		}
	}*/
	
	if(confirm("是否提交该拍卖会")){
		document.forms[0].encoding = "application/x-www-form-urlencoded";
		document.forms[0].target = "_self";
	 	document.forms[0].action="auctionManage_modify";
		document.forms[0].submit();
	}
	
}