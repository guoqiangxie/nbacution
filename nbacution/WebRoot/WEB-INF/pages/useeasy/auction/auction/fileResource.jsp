<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
<title>宁波市在线同步拍卖交易平台</title>
</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
		
			<div class="msg">
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  >
				<s:iterator value="auctionTopInfo_list" var="aucTopInfo_list">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="###" onclick="alert(<s:property value="#aucTopInfo_list.id"/>)"><s:property value="#aucTopInfo_list.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
		</div>
		<!--end header-->	
		
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
			 <%@include file="/WEB-INF/pages/useeasy/auction/main/left.jsp" %>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
			  <div class="tit">
			  	<div class="l">相关资料下载</div>
			  	<div class="r">	 
			 	 </div>
			  </div> 
	    	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	    		<tr>
	    			<td><a href="downloadFile/software.rar" target="_blank"> 1、系统相关软件及资料</a></td>
	    			<td><a href="downloadFile/1.2.rar" target="_blank"> 2、新模板</a></td>
					<td><a href="downloadFile/media(1).rar" target="_blank"> 3、流媒体</a></td>
	    		</tr>
			</table>
	    </div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function doAuctionDelete(str){
		if(confirm("是否删除该拍卖会！")){
			document.forms[0].action="auctionManage_delete?auctionFlag="+str;
			document.forms[0].submit();
		}
	}
	function doAuctionPublish(str){
		if(confirm("是否发布该拍卖会！")){
			document.forms[0].action="auctionManage_publish?auctionFlag="+str;
			document.forms[0].submit();
		}
	}
	function doToXml(str){
		if(confirm("注意：生成xml文件会自动对所有拍品进行排序，是否生成xml文件！")){
			$(".mess_div").show();
			$(".xml_div").hide();
			$.post("biddingManage_toXml?auctionFlag="+str,function(data){
				if(data == 1){
					alert("成功生成xml文件！");
					location.href = "auctionManage_index?auctionFlag="+str;
				}else if(data == 2){
					alert("对不起，您还未添加任何拍品！");
					$(".mess_div").hide();
					$(".xml_div").show();
				}else{
					alert("对不起，生成xml文件失败！");
					$(".mess_div").hide();
					$(".xml_div").show();
				}
			});
		}
	}
	function doBidController(str){
		document.forms[0].target="_blank";
		document.forms[0].action="biddingManage_controller?auctionFlag="+str;
		document.forms[0].submit();
		
	}
	function doBidBigConsole(str){
		document.forms[0].target="_blank";
		document.forms[0].action="biddingManage_bigConsole?auctionFlag="+str;
		document.forms[0].submit();
		
	}
	function doBidConsole(str){
		document.forms[0].target="_blank";
		document.forms[0].action="biddingManage_console?auctionFlag="+str;
		document.forms[0].submit();
		
	}
</script>
</body>
</html>
