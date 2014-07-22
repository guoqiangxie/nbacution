<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/layout.css" rel="stylesheet" type="text/css" />
<link href="useeasy/auction/css/main/public.css" rel="stylesheet" type="text/css" />
<link href="useeasy/auction/css/main/third.css" rel="stylesheet" type="text/css" /> 
 
<title>宁波市在线同步拍卖交易平台</title>
<script type="text/javascript"  language="javascript">
$(document).ready(function(){
	$("#img_show").click(function(){
		var urlVal = $("#img_show").attr("src");
		//window.showModalDialog("auctionIndex_imageDetail?imgUrl="+urlVal, "","dialogWidth=800px;dialogHeight=600px"); 
	});
});
function doShowImg(str){
	$("#img_show").attr("src",str);
}

</script>
</head>
<body>
	<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<!--header-->
		<div class="header">
			
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
			
			<div class="msg">
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
				<s:iterator value="#request.auctionInfoDtoListTop" var="auctionInfoDtoListTop">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property value="#auctionInfoDtoListTop.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
				
		</div>
		<!--end header-->
		
		<div class="sale">
		<div class="path"><a href="auctionIndex_index?searchType=1&currentPage=1">首页</a>>>  
			<a title="<s:property value="#request.auctionInfoDto.auctionName"/>" href="auctionIndex_auctionDetail?auctionFlag=<s:property value="#request.item.id"/>&currentPage=1"><s:property value="#request.item.auctionName"/></a> 
			 	</div>
		
		<div class="caption">
			<div class="name">
				<h1 title="<s:property value="#request.item.itemName" />" ><s:property value="#request.item.itemName" /></h1>
				<div class="time"><span></span>  拍卖时间：<s:date name="#request.item.auctionStartTime" format="yyyy-MM-dd HH:mm"/></div>
			</div>
			<div class="btn">
				 
			</div>
		</div>	
		
		<div class="info">
			<div class="left">
				<div class="wrap_border">
					 <div id="divContainer">
				        <div id="divBigPhotos"> 
				            <div id="divPhoto">
				            <s:if test="#request.item.imgUrl!=null">
				           	<img id="img_show" src="<s:property value="#request.item.imgUrl"/>" width="240" height="180" border="0" />
				           	</s:if>
				           	<s:else>
				           	<img id="img_show" src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" width="240" height="180" border="0" />
				           	</s:else>
							</div>
				        </div>
				    </div>
				</div> 
				<div id="picdata">
					<ul>
						<li>
						<!--  
						<s:if test="#request.uploadImgInfoList.size > 0">
							<s:iterator value="#request.uploadImgInfoList" var="uploadImgInfoList">
								<img src="<%=request.getContextPath()%><s:property value="#uploadImgInfoList.uploadUrl"/>" width="60" height="45" border="0" onmouseover="doShowImg(this.src)"/>
							</s:iterator>
						</s:if>-->
						
						</li>
					</ul>
				</div>
				<div id="divPhotosBar"></div> 
			</div>
			
			<div class="right" >
				<div class="top-min-height">
				<div class="list">
					<ul>
						<li>
							<p class="item1">拍品编号：<s:property value="#request.item.viewOrder"/> </p>
							<p class="item2" title="<s:property value="#request.item.itemName"/>">标的名称：<s:property value="#request.item.itemName"/></p>
						</li>
						<li>
							<p class="item1">起拍价：<span class="price">--</span></p>
							<p class="item2">参考价：
									<s:property value="#request.item.itemReferencePriceFir"/>
		                                 -- 
		                         <s:property value="#request.item.itemReferencePriceSec"/>	 	
							</p>													
						</li>
						<li>
							<p class="item1">佣金：
							<s:if test="#request.item.itemCommissionType == 1">
								固定比率<span class="price">---</span> <s:property value="#request.item.itemCommissionValue"/>%
							</s:if> 
							<s:elseif test="#request.item.itemCommissionType == 2">
								定额佣金 <span class="price">---</span> <s:property value="#request.item.itemCommissionValue"/>元
							</s:elseif>
							<s:elseif test="#request.item.itemCommissionType == 3">
								执行司法规定
							</s:elseif>
							</p>	
							<p class="item2">所需保证金：
							<span><s:property value="#request.item.margin"/>元</span>
							</p>							
						</li>
						<li>
							<p class="item1">
							拍卖方式：
							<s:if test="#request.item.valuationMethod == 1">总价</s:if>
							<s:if test="#request.item.valuationMethod == 2">单价</s:if>
							</p>
							<p class="item2">
							数量/单位：
							<s:property value="#request.item.countNumber"/>
							/
							<s:if test="#request.item.countUnit == 1">件</s:if>
							<s:if test="#request.item.countUnit == 2">台</s:if>
							<s:if test="#request.item.countUnit == 3">个</s:if>
							<s:if test="#request.item.countUnit == 4">批</s:if>
							<s:if test="#request.item.countUnit == 5">组</s:if>
							<s:if test="#request.item.countUnit == 6">平方米</s:if>
							<s:if test="#request.item.countUnit == 7">吨</s:if>
							<s:if test="#request.item.countUnit == 8">千克</s:if>
							<s:if test="#request.item.countUnit == 9">股</s:if>
							<s:if test="#request.item.countUnit == 10">辆</s:if>
							<s:if test="itemInfo.countUnit == 11">
								<s:property value="#request.item.countContent"/>
							</s:if>
							</p>													
						</li>
						<li>
						   <p class="item1"> 
						   
						     <s:if test="#request.item.auctionStatus == 0">		
		                                                          拍卖会尚未开始
		                    </s:if>	 
		                    <s:elseif test="#request.item.auctionStatus == 1">
		                                                       拍卖会正在进行
		                      </s:elseif>
		                      <s:else>
		                                                        拍卖会已经结束
	                        </s:else>	 		
						   
						   </p>
						
						 	
						</li>
						<!--<li>						
							
									代理价：<input type="text" id='rgmoney' name="objectRG" size="10"/>元
									<input type="button" onclick="setObjectRg()" value=" 设置 "/>
								
									当前代理价：元
									<input type="button" onclick="cancelRG()" value=" 取消 "/>
								
						</li>-->
					</ul>
						
				</div>
				</div>
				<form action="" method="post">
				<div class="btn"> 
				 
				</div>
				</form>
			</div>			
		</div>	
		
		<div class="into">
			 
			<div class="right">
				<table width="680" border="0" align="center" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="15" background="useeasy/auction/images/main/third_bg.gif">&nbsp;</td>
					<td width="90" align="center" valign="bottom" background="useeasy/auction/images/main/third_tit01.gif" id="health_td_1"   style="cursor:hand"><a   class="red15">标的描述</a></td>
					<td background="useeasy/auction/images/main/third_bg.gif">&nbsp;</td>
				  </tr>
				</table>
				<div class="cont min-height">
					<s:property value="#request.item.itemDescription"/>
				</div>
				<div class="note">声明：本系统图文信息仅供竞买人参考</div>
			</div>
		</div>	
		
		</div>
		<!--end main-->
		
		<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
	
	<!--end container-->
	<s:if test="#request.uploadImgInfoList.size > 0">
		<input id="img_hidden" type="hidden" value="<%=request.getContextPath()%><s:property value='#request.uploadImgInfoList.get(0).uploadUrl'/>" />
		<script type="text/javascript"  language="javascript">
		$("#img_show").attr("src",$("#img_hidden").val());
		</script>
		
	</s:if>
	
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$("#application_key").click(function(){
		var apply_url = "guestApplication_checkApply?auctionFlag="
			+$("#application_key").attr("lang");
		$.post(apply_url,function(data){
			if(data == 1){
				alert("您已经申请过该拍卖会的参拍要求！");	
			}else if(data == 2){
				alert("拍卖会已经结束！");	
			}else{
				location.href="guestApplication_apply?auctionFlag="
					+$("#application_key").attr("lang");
			}
		});
	});
	
	$("#customer_key").click(function(){
		var apply_url = "guestApplication_checkCustomer?auctionFlag="
			+$("#customer_key").attr("lang");
		$.post(apply_url,function(data){
			if(data == 0){
				alert("对不起 ，您不能进入该场拍卖会！");	
			}else if(data == 2){
				document.forms[0].target="_blank";
				document.forms[0].action="guestApplication_customer?auctionFlag="
					+$("#customer_key").attr("lang");
				document.forms[0].submit();
			}else{
				document.forms[0].target="_blank";
				document.forms[0].action="guestApplication_customerWait?auctionFlag="
					+$("#customer_key").attr("lang");
				document.forms[0].submit();
			}
		});
	});
	
	$("#viewer_key").click(function(){
		var apply_url = "biddingView_checkViewer?auctionFlag="
			+$("#viewer_key").attr("lang");
		$.post(apply_url,function(data){
			if(data == 0){
				alert("对不起 ，您不能观摩该场拍卖会！");	
			}else if(data == 2){
				document.forms[0].target="_blank";
				document.forms[0].action="biddingView_viewer?auctionFlag="
					+$("#viewer_key").attr("lang");
				document.forms[0].submit();	
			}else{
				document.forms[0].target="_blank";
				document.forms[0].action="biddingView_viewerWait?auctionFlag="
					+$("#viewer_key").attr("lang");
				document.forms[0].submit();
			}
		});
	});
	
});
</script>
</body>
</html>