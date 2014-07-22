$(document).ready(function(){
	
	$.post('auctionLogin_checkLogined', null, function(data){
		$('.login').html(data);
		$.getScript("useeasy/auction/js/main/login.js");
	});
	
});

function doSearch(){
var search_type = 1;
var company_val = $("#companyName_val").val();
var auction_type = $("#seracher_val").val();
var key_val = $("#key_val").val();

if($("#search_type_fir")[0].checked == true){
	search_type = 1;
}else{
	search_type = 2;
}

var key_val_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9]{0,50}$");
if(!key_val_pattern.test(key_val)){
	$("#key_val").focus();
	alert("关键字为中文，数字，字母1！");
	return;
}

location.href="auctionIndex_search?searchType="
	+search_type+"&companyFlag="+company_val
	+"&auctionType="+auction_type+"&keyVal="+encodeURI(encodeURI(key_val));

}