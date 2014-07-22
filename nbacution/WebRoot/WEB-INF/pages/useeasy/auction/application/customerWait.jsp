<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
	<title>宁波市在线同步拍卖交易平台</title>
	
</head>
<body>
		<br/>
		<input type="hidden" id="auction_key" value="<s:property value="#request.auctionId"/>"/>
		<table  align="center" >
			<tr>
				<td><img src="useeasy/auction/images/main/pp.jpg"/></td>
			</tr>
		</table>
		<script language="javascript" type="text/javascript">
			setInterval(toPage,10000);
			
			function toPage(){
				var apply_url = "guestApplication_checkAuction?auctionFlag="
					+$("#auction_key").val();
				$.post(apply_url,function(data){
					if(data == 2){
						location.href="guestApplication_customer?auctionFlag="
							+$("#auction_key").val();	
					}else{
					}
				});
			}
		</script>
	</body>
   
</html>
