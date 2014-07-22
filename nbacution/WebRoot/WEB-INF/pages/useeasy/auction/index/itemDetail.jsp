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
		window.showModalDialog("auctionIndex_imageDetail?imgUrl="+urlVal, "","dialogWidth=800px;dialogHeight=600px"); 
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
			<a title="<s:property value="#request.auctionInfoDto.auctionName"/>" href="auctionIndex_auctionDetail?auctionFlag=<s:property value="#request.auctionInfoDto.id"/>&currentPage=1"><s:property value="#request.auctionInfoDto.auctionName"/></a> 
			 (<s:property value="#request.auctionInfoDto.companyName"/>)	</div>
		
		<div class="caption">
			<div class="name">
				<h1 title="<s:property value="#request.itemInfoDto.itemName" />" ><s:property value="#request.itemInfoDto.itemName" /></h1>
				<div class="time"><span></span>  拍卖时间：<s:date name="#request.auctionInfoDto.auctionStartTime" format="yyyy-MM-dd HH:mm"/></div>
			</div>
			<div class="btn">
				<ul>
					<s:if test="#request.prevFlag != -1">
					<li><a href="auctionIndex_itemDetail?itemFlag=<s:property value="#request.prevFlag"/>">
					<img src="useeasy/auction/images/main/btn_up.gif"  border="0"/></a></li>
					</s:if>
					<s:if test="#request.nextFlag != -1">
					<li><a href="auctionIndex_itemDetail?itemFlag=<s:property value="#request.nextFlag"/>">
					<img src="useeasy/auction/images/main/btn_down.gif" border="0" /></a></li>
					</s:if>
				</ul>
			</div>
		</div>	
		
		<div class="info">
			<div class="left">
				<div class="wrap_border">
					 <div id="divContainer">
				        <div id="divBigPhotos"> 
				            <div id="divPhoto">
				            <s:if test="#request.uploadImgInfoList.size() > 0">
				           	<img id="img_show" src="" width="240" height="180" border="0" />
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
						<s:if test="#request.uploadImgInfoList.size > 0">
							<s:iterator value="#request.uploadImgInfoList" var="uploadImgInfoList">
								<img src="<%=request.getContextPath()%><s:property value="#uploadImgInfoList.uploadUrl"/>" width="60" height="45" border="0" onmouseover="doShowImg(this.src)"/>
							</s:iterator>
						</s:if>
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
							<p class="item1">拍品编号：<s:property value="#request.itemInfoDto.viewOrder"/> </p>
							<p class="item2" title="<s:property value="#request.itemInfoDto.itemName"/>">标的名称：<s:property value="#request.itemInfoDto.itemName"/></p>
						</li>
						<li>
							<p class="item1">起拍价：<span class="price">--</span></p>
							<p class="item2">参考价：
								 <s:if test="#request.itemInfoDto.itemReferencePriceFir != null && #request.itemInfoDto.itemReferencePriceFir.length() > 0">
								 	<s:property value="#request.itemInfoDto.itemReferencePriceFir"/>
								 	<span class="price">--</span>
								 </s:if>
								 <s:if test="#request.itemInfoDto.itemReferencePriceSec != null && #request.itemInfoDto.itemReferencePriceSec.length() > 0">
								 	<s:property value="#request.itemInfoDto.itemReferencePriceSec"/>
								 </s:if>
							</p>													
						</li>
						<li>
							<p class="item1">佣金：
							<s:if test="#request.itemInfoDto.itemCommissionType == 1">
								固定比率<span class="price">---</span> <s:property value="#request.itemInfoDto.itemCommissionValue"/>%
							</s:if> 
							<s:elseif test="#request.itemInfoDto.itemCommissionType == 2">
								定额佣金 <span class="price">---</span> <s:property value="#request.itemInfoDto.itemCommissionValue"/>元
							</s:elseif>
							<s:elseif test="#request.itemInfoDto.itemCommissionType == 3">
								执行司法规定
							</s:elseif>
							</p>	
							<p class="item2">所需保证金：
							<span><s:property value="#request.itemInfoDto.margin"/>元</span>
							</p>							
						</li>
						<li>
							<p class="item1">
							拍卖方式：
							<s:if test="#request.itemInfoDto.valuationMethod == 1">总价</s:if>
							<s:if test="#request.itemInfoDto.valuationMethod == 2">单价</s:if>
							</p>
							<p class="item2">
							数量/单位：
							<s:property value="#request.itemInfoDto.countNumber"/>
							/
							<s:if test="#request.itemInfoDto.countUnit == 1">件</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 2">台</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 3">个</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 4">批</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 5">组</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 6">平方米</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 7">吨</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 8">千克</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 9">股</s:if>
							<s:if test="#request.itemInfoDto.countUnit == 10">辆</s:if>
							<s:if test="itemInfo.countUnit == 11">
								<s:property value="#request.itemInfoDto.countContent"/>
							</s:if>
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
					<ul>
						<s:if test="#session._listener.auctionAccount == null">
						
							<s:if test="#request.auctionInfoDto.companyInterfaceFlag == 1">
								<%-- 观摩 --%>	
								<li><a title="【注册用户】可以观摩本场拍卖会" href="<s:property value="#request.auctionInfoDto.visitUrl"/>" >观摩网络拍卖</a></li> 
								<%-- 申请 --%>
								<li><a  title="申请获取本场拍卖会的参拍权限"  href="<s:property value="#request.auctionInfoDto.loginUrl"/>">申请网络拍卖</a></li>
								<%-- 进入 --%>
								<li><a title="进入本场拍卖会进行参拍" href="<s:property value="#request.auctionInfoDto.loginUrl"/>">进入网络拍卖</a></li>
							</s:if>
							<s:else>
								<%-- 观摩 --%>
								<li><a title="【注册用户】可以观摩本场拍卖会" href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >观摩网络拍卖</a></li> 
								<%-- 申请 --%>
								<li><a  title="申请获取本场拍卖会的参拍权限" href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>">申请网络拍卖</a></li>
								<%-- 进入 --%>
								<li><a title="进入本场拍卖会进行参拍"  href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>">进入网络拍卖</a></li>
							</s:else>
						</s:if>
						<s:else>
							<s:if test="#request.auctionInfoDto.auctionStatus == 2">
								<%-- 观摩 --%>
								<li><a title="【注册用户】可以观摩本场拍卖会" href="javascript:void(0);" >观摩网络拍卖</a></li> 
								<%-- 申请 --%>
								<li><a  title="申请获取本场拍卖会的参拍权限" href="javascript:void(0);">申请网络拍卖</a></li>
								<%-- 进入 --%>
								<li><a title="进入本场拍卖会进行参拍"  href="javascript:void(0);">进入网络拍卖</a></li>
							</s:if>
							<s:else>
								<s:if test="#session._listener.auctionAccount.accountType == 1">
									<%-- 观摩 --%>
									<li><a title="【注册用户】可以观摩本场拍卖会" href="javascript:void(0);" >观摩网络拍卖</a></li> 
									<%-- 申请 --%>
									<li><a  title="申请获取本场拍卖会的参拍权限" href="javascript:void(0);">申请网络拍卖</a></li>
									<%-- 进入 --%>
									<li><a title="进入本场拍卖会进行参拍"  href="javascript:void(0);">进入网络拍卖</a></li>
								</s:if>
								<s:if test="#session._listener.auctionAccount.accountType == 2">
									<%-- 观摩 --%>
									<li><a title="【注册用户】可以观摩本场拍卖会" href="biddingView_checkViewer?auctionFlag=<s:property value="#request.auctionInfoDto.id"/>" target="_blank" >观摩网络拍卖</a></li> 
									<%-- 申请 --%>
									<li><a  title="申请获取本场拍卖会的参拍权限" href="javascript:void(0);">申请网络拍卖</a></li>
									<%-- 进入 --%>
									<li><a title="进入本场拍卖会进行参拍"  href="javascript:void(0);">进入网络拍卖</a></li>
								</s:if>
								<s:if test="#session._listener.auctionAccount.accountType == 3">
									<s:if test="#request.auctionInfoDto.companyInterfaceFlag == 1">
										<%-- 观摩 --%>	
										<li><a title="【注册用户】可以观摩本场拍卖会" href="<s:property value="#request.auctionInfoDto.visitUrl"/>" >观摩网络拍卖</a></li> 
										<%-- 申请 --%>
										<li><a  title="申请获取本场拍卖会的参拍权限"  href="<s:property value="#request.auctionInfoDto.loginUrl"/>">申请网络拍卖</a></li>
										<%-- 进入 --%>
										<li><a title="进入本场拍卖会进行参拍" href="<s:property value="#request.auctionInfoDto.loginUrl"/>">进入网络拍卖</a></li>
									</s:if>
									<s:else>
										<%-- 观摩 --%>
										<li><a title="【注册用户】可以观摩本场拍卖会" href="biddingView_checkViewer?auctionFlag=<s:property value="#request.auctionInfoDto.id"/>" target="_blank" >观摩网络拍卖</a></li> 
										<%-- 申请 --%>
										<li><a  title="申请获取本场拍卖会的参拍权限"  id="application_key" lang="<s:property value="#request.auctionInfoDto.id"/>" href="javascript:void(0);">申请网络拍卖</a></li>
										<%-- 进入 --%>
										<li><a title="进入本场拍卖会进行参拍"  href="guestApplication_checkCustomer?auctionFlag=<s:property value="#request.auctionInfoDto.id"/>" target="_blank">进入网络拍卖</a></li>
									</s:else>
								</s:if>
							</s:else>
							
							
						</s:else>
					</ul>
				</div>
				</form>
			</div>			
		</div>	
		
		<div class="into">
			<div class="left">
				<div class="title"> <span class="text">值得关注的同类标的</span> <span class="more"></span></div>
				<div class="list">
					<ul>
						<s:iterator value="#request.itemInfoListSimilar" var="itemInfoListSimilar" status="status">
							<li><img src="useeasy/auction/images/main/0<s:property value='#status.index+1'/>.gif"/>
							<a target="_self" href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoListSimilar[0]'/>" title="<s:property value="#itemInfoListSimilar[1]"/>">
							<s:if test="#itemInfoListSimilar[1].length() > 17">
								<s:property value="#itemInfoListSimilar[1].substring(0,17)"/>
							</s:if>
							<s:else>
								<s:property value="#itemInfoListSimilar[1]"/>
							</s:else>
							</a></li>
						</s:iterator>
					</ul>
				</div>
			</div>
			<div class="right">
				<table width="680" border="0" align="center" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="15" background="useeasy/auction/images/main/third_bg.gif">&nbsp;</td>
					<td width="90" align="center" valign="bottom" background="useeasy/auction/images/main/third_tit01.gif" id="health_td_1"   style="cursor:hand"><a   class="red15">标的描述</a></td>
					<td background="useeasy/auction/images/main/third_bg.gif">&nbsp;</td>
				  </tr>
				</table>
				<div class="cont min-height">
					<s:property value="#request.itemInfoDto.itemDescription"/>
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