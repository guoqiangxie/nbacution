$(document).ready(function(){
	$('.checkall').attr("checked",false);
	$('.checkall').checkgroup({groupName:'group'});
});

function doDeleteAuctionTeamType(str){
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
			document.forms[0].target="_self";
		 	document.forms[0].action="auctionManage_removeTeamType?auctionFlag="+str+"&boxes_flag="+boxes;
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