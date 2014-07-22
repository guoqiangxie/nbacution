$(document).ready(function(){
	$('.checkall').attr("checked",false);
	$('.checkall').checkgroup({groupName:'group'});
});

function doDeleteCheckedbox(str){
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认删除这些拍品！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_remove",{boxesFlag : "" + boxes, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doOpenResultCheckedbox(str){
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认公开这些拍品！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_openResult",{boxesFlag : "" + boxes, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doCloseResultCheckedbox(str){
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认不公开这些拍品！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_closeResult",{boxesFlag : "" + boxes, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doBathcMarginCheckedbox(str){
	var bzj_batch = $("#bzj_batch").val();
	var bzj_batch_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(!bzj_batch_pattern.test(bzj_batch)){
		$("#bzj_batch").focus();
		alert("保证金为整数！");
		return;
	}
	
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认更新这些拍品保证金！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_batchMargin",{boxesFlag : "" + boxes, marginFlag: bzj_batch, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doBathcPriceRangeCheckedbox(str){
	var itemPriceRange_batch = $("#itemPriceRange_batch").val();
	var itemPriceRange_batch_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	if(!itemPriceRange_batch_pattern.test(itemPriceRange_batch)){
		$("#itemPriceRange_batch").focus();
		alert("加价幅度为整数！");
		return;
	}
	
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认更新这些拍品加价幅度！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_batchPriceRange",
				{boxesFlag : "" + boxes, priceRangeFlag: itemPriceRange_batch, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doBathcCommissionCheckedbox(str){
	var commissionType_flag = "";
	var commissionVal_flag = "";
	if($("#yjfs_batch_fir")[0].checked == false 
			&& $("#yjfs_batch_sec")[0].checked == false 
			&& $("#yjfs_batch_thi")[0].checked == false){
		$("#yjfs_batch_fir").focus();
		alert("请选择佣金类型！");
		return;
	}
	
	if($("#yjfs_batch_fir")[0].checked == true){
		var gdbl_batch = $("#gdbl_batch").val();
		var gdbl_batch_pattern = new RegExp("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10}|[0]{1,1})$");
		if(!gdbl_batch_pattern.test(gdbl_batch)){
			$("#gdbl_batch").focus();
			alert("固定比率为正数！");
			return;
		}
		commissionType_flag = "1";
		commissionVal_flag = gdbl_batch;
	}
	if($("#yjfs_batch_sec")[0].checked == true){
		var deyj_batch = $("#deyj_batch").val();
		var deyj_batch_pattern = new RegExp("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10}|[0]{1,1})$");
		if(!deyj_batch_pattern.test(deyj_batch)){
			$("#deyj_batch").focus();
			alert("定额佣金为正数！");
			return;
		}
		commissionType_flag = "2";
		commissionVal_flag = deyj_batch;
	}
	if($("#yjfs_batch_thi")[0].checked == true){
		commissionType_flag = "3";
		commissionVal_flag = "";
	}
	
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认更新这些拍品佣金类型！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_batchCommission",
				{boxesFlag : "" + boxes, commissionTypeFlag: commissionType_flag, commissionValFlag:commissionVal_flag, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}

function doBatchEditCheckedbox(str){
	var boxes=Array();
	var sortVal=Array();
	var viewOrderVal=Array();
	var itemNameVal=Array();
	var marginVal=Array();
	var itemPriceVal=Array();
	var itemPriceRangeVal=Array();
	
	var check_flag = "1";
	var sort_var_pattern = new RegExp("^[1-9]{1}[0-9]{0,5}$");
	var viewOrder_var_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*()+-【】《》（）—/]{1,20}$");
	var itemName_var_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*() 【】《》（）—/]{1,300}$");
	var margin_var_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	var itemPrice_var_pattern = new RegExp("^(0|[1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$");
	var itemPriceRange_var_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,10}$");
	
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked && check_flag == "1") {
			boxes[$i] = this.value;
			
			var sort_var = $(this).parent().next().children().val();
			if(!sort_var_pattern.test(sort_var)){
				$(this).parent().next().children().focus();
				alert("序号为整数！");
				check_flag = "0";
				return;
			}
			sortVal[$i] = sort_var;
			
			var viewOrder_var = $(this).parent().next().next().children().val();
			if(!viewOrder_var_pattern.test(viewOrder_var)){
				$(this).parent().next().next().children().focus();
				alert("显示编号为中文，数字，字母，符号，。、：“”.*()+-【】《》（）—/可使用！");
				check_flag = "0";
				return;
			}
			viewOrderVal[$i] = viewOrder_var;
			
			var itemName_var = $(this).parent().next().next().next().children().val();
			/*if(!itemName_var_pattern.test(itemName_var)){
				$(this).parent().next().next().next().children().focus();
				alert("拍品名称为中文，数字，字母，符号，。、：“”.*()【】《》（）—/可使用！");
				check_flag = "0";
				return;
			}*/
			itemNameVal[$i] = itemName_var;
			
			var margin_var = $(this).parent().next().next().next().next().children().val();
			if(!margin_var_pattern.test(margin_var)){
				$(this).parent().next().next().next().next().children().focus();
				alert("保证金为整数！");
				check_flag = "0";
				return;
			}
			marginVal[$i] = margin_var;
			
			var itemPrice_var = $(this).parent().next().next().next().next().next().children().val();
			if(!itemPrice_var_pattern.test(itemPrice_var)){
				$(this).parent().next().next().next().next().next().children().focus();
				alert("起拍价为正数！");
				check_flag = "0";
				return;
			}
			itemPriceVal[$i] = itemPrice_var;
			
			var itemPriceRange_var = $(this).parent().next().next().next().next().next().next().children().val();
			if(!itemPriceRange_var_pattern.test(itemPriceRange_var)){
				$(this).parent().next().next().next().next().next().next().children().focus();
				alert("加价幅度为整数！");
				check_flag = "0";
				return;
			}
			itemPriceRangeVal[$i] = itemPriceRange_var;
			
			$i++;
		}
	});
	if(check_flag == "0"){
		return;
	}
	
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认编辑这些拍品！")){
			$('#message_span').show();
			$('#button_span').hide();
			$.post("itemManage_batchEdit",
				{boxesFlag: "" + boxes, sortValFlag: "" + sortVal, 
				viewOrderValFlag: "" + viewOrderVal, itemNameValFlag: "" + itemNameVal,
				marginValFlag: "" + marginVal, itemPriceValFlag: "" + itemPriceVal, 
				itemPriceRangeValFlag: "" + itemPriceRangeVal, auctionFlag: str},
				function(data){
					location.href="itemManage_index?auctionFlag="+str;
			});
		}
	}
}






function doDeleteItemPic(){
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍品！");
	}else {
		if(confirm("是否确认删除这些拍品！")){
			document.forms[0].target = "_self";
		 	document.forms[0].action="itemManage_removePic?boxes_flag=" + boxes;
		 	//alert(boxes);
		 	document.forms[0].submit();
		}
	}
}

function doDeleteAuctionTeamType(){
	var boxes=Array();
	var $i=0;
	$(".groupclass").each(function(){
		if (this.checked) {
			boxes[$i] = this.value;
			$i++;
		}
	});
	if (boxes.length==0){
		alert("请选择相关拍卖组别！");
	}else {
		if(confirm("是否确认删除这些拍卖组别！")){
			document.forms[0].target = "_self";
		 	document.forms[0].action="auctionManage_removeTeamType?boxes_flag=" + boxes;
		 	document.forms[0].submit();
		}
	}
}


function doSelectCheckboxFull(){
	$(".groupclass").each(function(){
		this.checked=true;
	});
}
function doSelectCheckboxReflect(){
	$(".groupclass").each(function(){
		if (this.checked) {
			this.checked=false;
		}else {
			this.checked=true;	
		}
	});
}
function doSelectCheckboxNone(){
	$(".groupclass").each(function(){
		this.checked=false;
	});
}