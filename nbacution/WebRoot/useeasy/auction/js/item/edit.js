$(document).ready(function(){
	
	
});

function doSubmit(){
	/*var itemName = $("#itemName").val();
	var itemName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*() 【】《》（）—/]{1,300}$");
	if(!itemName_pattern.test(itemName)){
		$("#itemName").focus();
		alert("拍品名称为中文，数字，字母，符号，。、：“”.*()【】《》（）—/可使用！");
		return;
	}*/
	var itemName = $("#itemName").val();
	if(itemName == ""){
		$("#itemName").focus();
		alert("拍品名称为必填字段！");
		return;
	}
	var itemNumber = $("#itemNumber").val();
	var itemNumber_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,5}$");
	if(!itemNumber_pattern.test(itemNumber)){
		$("#itemNumber").focus();
		alert("拍品序号为整数！");
		return;
	}
	var viewOrder = $("#viewOrder").val();
	var viewOrder_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*()+-【】《》（）—/]{1,20}$");
	if(!viewOrder_pattern.test(viewOrder)){
		$("#viewOrder").focus();
		alert("显示编号为中文，数字，字母，符号，。、：“”.*()+-【】《》（）—/可使用！");
		return;
	} 
	if(!$("#valuationMethod_fir")[0].checked && 
			!$("#valuationMethod_sec")[0].checked){
		$("#valuationMethod_fir").focus();
		alert("请选择拍卖方式！");
		return;
	}
	var countNumber = $("#countNumber").val();
	var countNumber_pattern = new RegExp("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$");
	if(!countNumber_pattern.test(countNumber)){
		$("#countNumber").focus();
		alert("数量为正数！");
		return;
	}
	if($("#countUnit").val() == 0){
		$("#countUnit").focus();
		alert("请选择单位！");
		return;
	}
	if($("#countUnit").val() == 11){
		var countContent = $("#countContent").val();
		var countContent_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9()]{1,20}$");
		if(!countContent_pattern.test(countContent)){
			$("#countContent").focus();
			alert("单位为中文，数字，字母()！");
			return;
		} 
	}
	
	if($("#itemCommissionType").val() == 0){
		$("#itemCommissionType").focus();
		alert("请选择佣金方式！");
		return;
	}
	if($("#itemCommissionType").val() == 1 || $("#itemCommissionType").val() == 2){
		var itemCommissionValue = $("#itemCommissionValue").val();
		var itemCommissionValue_pattern = new RegExp("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10}|[0]{1,1})$");
		if(!itemCommissionValue_pattern.test(itemCommissionValue)){
			$("#itemCommissionValue").focus();
			alert("佣金数额为正数！");
			return;
		} 
	}
	var margin = $("#margin").val();
	var margin_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(!margin_pattern.test(margin)){
		$("#margin").focus();
		alert("保证金为整数！");
		return;
	}
	if($("#marginFlag").val() == 0){
		$("#marginFlag").focus();
		alert("请选择保证金限制！");
		return;
	}
	var itemBasePrice = $("#itemBasePrice").val();
	var itemBasePrice_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(itemBasePrice == ""){
	}else{
		if(!itemBasePrice_pattern.test(itemBasePrice)){
			$("#itemBasePrice").focus();
			alert("底价为整数！");
			return;
		}
	}
	var itemReferencePriceFir = $("#itemReferencePriceFir").val();
	var itemReferencePriceFir_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(itemReferencePriceFir == ""){
	}else{
		if(!itemReferencePriceFir_pattern.test(itemReferencePriceFir)){
			$("#itemReferencePriceFir").focus();
			alert("参考价为整数！");
			return;
		}
	}
	var itemReferencePriceSec = $("#itemReferencePriceSec").val();
	var itemReferencePriceSec_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(itemReferencePriceSec == ""){
	}else{
		if(!itemReferencePriceSec_pattern.test(itemReferencePriceSec)){
			$("#itemReferencePriceSec").focus();
			alert("参考价为整数！");
			return;
		}
	}
	var itemPrice = $("#itemPrice").val();
	var itemPrice_pattern = new RegExp("^(0|[1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$");
	if(itemPrice == ""){
	}else{
		if(!itemPrice_pattern.test(itemPrice)){
			$("#itemPrice").focus();
			alert("起拍价为正数！");
			return;
		}
	}
	/*var itemDescription = $("#itemDescription").val();
	var itemDescription_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：；“”.*()+-【】《》（）—/. \n]{1,5000}$");
	if(itemDescription == ""){
	}else{
		if(!itemDescription_pattern.test(itemDescription)){
			$("#itemDescription").focus();
			alert("拍品描述为中文，数字，字母，符号，。、：；“”.*()+-【】《》（）—/.可使用！");
			return;
		}
	}*/
	if($("#itemType").val() == 0){
		$("#itemType").focus();
		alert("请选择拍品模板！");
		return;
	}
	
	/*var globle_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：；“”.*()+-【】《》（）—/ \n]{1,300}$");
	if($("#itemType").val() == 1){
		var lb2 = $("#lb2").val();
		if(lb2 == ""){
		}else{
			if(!globle_pattern.test(lb2)){
				$("#lb2").focus();
				alert("类别为中文，数字，字母，符号，。、：；“”.*()+-【】《》（）—/.可使用！");
				return;
			}
		}
		var tdsyqly = $("#tdsyqly").val();
		if(tdsyqly == ""){
		}else{
			if(!globle_pattern.test(tdsyqly)){
				$("#tdsyqly").focus();
				alert("土地使用权来源为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var jzmj = $("#jzmj").val();
		if(jzmj == ""){
		}else{
			if(!globle_pattern.test(jzmj)){
				$("#jzmj").focus();
				alert("建筑面积为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var jtzk = $("#jtzk").val();
		if(jtzk == ""){
		}else{
			if(!globle_pattern.test(jtzk)){
				$("#jtzk").focus();
				alert("交通状况为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		
	}
	if($("#itemType").val() == 2){
		var cphm = $("#cphm").val();
		if(cphm == ""){
		}else{
			if(!globle_pattern.test(cphm)){
				$("#cphm").focus();
				alert("车牌号码为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var cjhVIN = $("#cjhVIN").val();
		if(cjhVIN == ""){
		}else{
			if(!globle_pattern.test(cjhVIN)){
				$("#cjhVIN").focus();
				alert("车架号(VIN)为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var syxz = $("#syxz").val();
		if(syxz == ""){
		}else{
			if(!globle_pattern.test(syxz)){
				$("#syxz").focus();
				alert("使用性质为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var bxlc = $("#bxlc").val();
		if(bxlc == ""){
		}else{
			if(!globle_pattern.test(bxlc)){
				$("#bxlc").focus();
				alert("表显里程为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var djqyrq = $("#djqyrq").val();
		if(djqyrq == ""){
		}else{
			if(!globle_pattern.test(djqyrq)){
				$("#djqyrq").focus();
				alert("登记启用日期为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var pzszsf = $("#pzszsf").val();
		if(pzszsf == ""){
		}else{
			if(!globle_pattern.test(pzszsf)){
				$("#pzszsf").focus();
				alert("牌照所在省份为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var pzszcs = $("#pzszcs").val();
		if(pzszcs == ""){
		}else{
			if(!globle_pattern.test(pzszcs)){
				$("#pzszcs").focus();
				alert("牌照所在城市为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var pzlx = $("#pzlx").val();
		if(pzlx == ""){
		}else{
			if(!globle_pattern.test(pzlx)){
				$("#pzlx").focus();
				alert("牌照类型（公/私）为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var pmsfhpz = $("#pmsfhpz").val();
		if(pmsfhpz == ""){
		}else{
			if(!globle_pattern.test(pmsfhpz)){
				$("#pmsfhpz").focus();
				alert("拍卖是否含牌照为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var njdqny = $("#njdqny").val();
		if(njdqny == ""){
		}else{
			if(!globle_pattern.test(njdqny)){
				$("#njdqny").focus();
				alert("年检到期年月为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var bxdqny = $("#bxdqny").val();
		if(bxdqny == ""){
		}else{
			if(!globle_pattern.test(bxdqny)){
				$("#bxdqny").focus();
				alert("保险到期年月为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var txfdqny = $("#txfdqny").val();
		if(txfdqny == ""){
		}else{
			if(!globle_pattern.test(txfdqny)){
				$("#txfdqny").focus();
				alert("通行费到期年月为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var cldjz = $("#cldjz").val();
		if(cldjz == ""){
		}else{
			if(!globle_pattern.test(cldjz)){
				$("#cldjz").focus();
				alert("车辆登记证为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var ychgz = $("#ychgz").val();
		if(ychgz == ""){
		}else{
			if(!globle_pattern.test(ychgz)){
				$("#ychgz").focus();
				alert("原车合格证为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var xsz = $("#xsz").val();
		if(xsz == ""){
		}else{
			if(!globle_pattern.test(xsz)){
				$("#xsz").focus();
				alert("行驶证为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var dk = $("#dk").val();
		if(dk == ""){
		}else{
			if(!globle_pattern.test(dk)){
				$("#dk").focus();
				alert("底卡为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var gzsz = $("#gzsz").val();
		if(gzsz == ""){
		}else{
			if(!globle_pattern.test(gzsz)){
				$("#gzsz").focus();
				alert("购置税证为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var ccs = $("#ccs").val();
		if(ccs == ""){
		}else{
			if(!globle_pattern.test(ccs)){
				$("#ccs").focus();
				alert("车船税为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var hbbz = $("#hbbz").val();
		if(hbbz == ""){
		}else{
			if(!globle_pattern.test(hbbz)){
				$("#hbbz").focus();
				alert("环保标志为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		
		
	}
	if($("#itemType").val() == 3){
		var lb3 = $("#lb3").val();
		if(lb3 == ""){
		}else{
			if(!globle_pattern.test(lb3)){
				$("#lb3").focus();
				alert("类别为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var dw = $("#dw").val();
		if(dw == ""){
		}else{
			if(!globle_pattern.test(dw)){
				$("#dw").focus();
				alert("单位为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var sl2 = $("#sl2").val();
		if(sl2 == ""){
		}else{
			if(!globle_pattern.test(sl2)){
				$("#sl2").focus();
				alert("数量为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
	}
	if($("#itemType").val() == 4){
		var lb3 = $("#lb3").val();
		if(lb3 == ""){
		}else{
			if(!globle_pattern.test(lb3)){
				$("#lb3").focus();
				alert("类别为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var dw = $("#dw").val();
		if(dw == ""){
		}else{
			if(!globle_pattern.test(dw)){
				$("#dw").focus();
				alert("单位为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var sl2 = $("#sl2").val();
		if(sl2 == ""){
		}else{
			if(!globle_pattern.test(sl2)){
				$("#sl2").focus();
				alert("数量为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		
		
	}
	if($("#itemType").val() == 5){
		var lb3 = $("#lb3").val();
		if(lb3 == ""){
		}else{
			if(!globle_pattern.test(lb3)){
				$("#lb3").focus();
				alert("类别为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var dw = $("#dw").val();
		if(dw == ""){
		}else{
			if(!globle_pattern.test(dw)){
				$("#dw").focus();
				alert("单位为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var sl2 = $("#sl2").val();
		if(sl2 == ""){
		}else{
			if(!globle_pattern.test(sl2)){
				$("#sl2").focus();
				alert("数量为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
	}
	if($("#itemType").val() == 6){
		var lb1 = $("#lb1").val();
		if(lb1 == ""){
		}else{
			if(!globle_pattern.test(lb1)){
				$("#lb1").focus();
				alert("类别为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var zz = $("#zz").val();
		if(zz == ""){
		}else{
			if(!globle_pattern.test(zz)){
				$("#zz").focus();
				alert("作者为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var nd = $("#nd").val();
		if(nd == ""){
		}else{
			if(!globle_pattern.test(nd)){
				$("#nd").focus();
				alert("年代为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var cc = $("#cc").val();
		if(cc == ""){
		}else{
			if(!globle_pattern.test(cc)){
				$("#cc").focus();
				alert("尺寸为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var sl1 = $("#sl1").val();
		if(sl1 == ""){
		}else{
			if(!globle_pattern.test(sl1)){
				$("#sl1").focus();
				alert("数量为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var ks = $("#ks").val();
		if(ks == ""){
		}else{
			if(!globle_pattern.test(ks)){
				$("#ks").focus();
				alert("款识为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		

	}
	if($("#itemType").val() == 7){
		var lb3 = $("#lb3").val();
		if(lb3 == ""){
		}else{
			if(!globle_pattern.test(lb3)){
				$("#lb3").focus();
				alert("类别为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var dw = $("#dw").val();
		if(dw == ""){
		}else{
			if(!globle_pattern.test(dw)){
				$("#dw").focus();
				alert("单位为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
		var sl2 = $("#sl2").val();
		if(sl2 == ""){
		}else{
			if(!globle_pattern.test(sl2)){
				$("#sl2").focus();
				alert("数量为中文，数字，字母，符号，。、：【】《》（）—/.可使用！");
				return;
			}
		}
	}*/
	
	if(confirm("是否提交该拍品")){
		document.forms[0].target = "_self";
	 	document.forms[0].action="itemManage_modify";
		document.forms[0].submit();
	}
	
}