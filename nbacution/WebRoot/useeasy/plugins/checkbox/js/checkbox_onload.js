$(document).ready(function(){
	$('.checkall').attr("checked",false);
	$('.checkall').checkgroup({groupName:'group'});
});

/*function doCheckboxOnload(){
	$('.checkall').attr("checked",false);
	$('.checkall').checkgroup({groupName:'group'});
}*/

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