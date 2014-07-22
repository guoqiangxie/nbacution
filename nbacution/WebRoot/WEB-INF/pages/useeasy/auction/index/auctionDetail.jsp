<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/Detaillayout.css" rel="stylesheet" type="text/css" />
<link href="useeasy/auction/css/main/public.css" rel="stylesheet" type="text/css" />

<title>宁波在线同步拍卖交易平台</title>
<script type="text/javascript"  language="javascript">
$(document).ready(function(){
	$("#index").removeAttr("class").addClass("over");
	$("#house").removeAttr("class").addClass("over");
	$("#automobile").removeAttr("class").addClass("over");
	$("#material").removeAttr("class").addClass("over");
	$("#stock").removeAttr("class").addClass("over");
	$("#mlpllz").removeAttr("class").addClass("over");
	$("#art").removeAttr("class").addClass("over");
	$("#other").removeAttr("class").addClass("over");

	$(".titbtn").find("li").each(function(){
		$(this).hover(function(){
		$(".list").attr("style","display:none");	
		$(".titbtn").find("li").removeClass("lion");
		$(".titbtn").find("li").addClass("liout");
		$(this).addClass("lion");
		$("#"+$(this).attr("id")+"1").attr("style","display:block");
		},function(){
		});	
	});
});


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
		
		
		<div class="loca"><a href="auctionIndex_index?searchType=1&currentPage=1">首页</a>  
			<a title="<s:property value="#request.auctionInfoDtoIndex.auctionName"/>" href="javascript:void(0);"><s:property value="#request.auctionInfoDtoIndex.auctionName"/></a> 
			 (<s:property value="#request.auctionInfoDtoIndex.companyName"/>)	</div>
		
		<!--main-->
		<div class="main">
		<!--left-->
		
		
		<div class="left">
			<div class="sidebar min-height">
					<div class="titbtn">
						<ul>
							<li id="gonggao" class="lion">拍卖公告</li>
							<li id="guize" class="liout">拍卖规则</li>
							<li id="guiding" class="liout">特别规定</li>
							<li id="shuoming"  class="liout">备注说明</li>
						</ul>
					</div>
					<form action="" method="post" class="inlineBlock">
					<table width="226" border="0" align="center" cellpadding="0" cellspacing="0" class="btn">
						<s:if test="#session._listener.auctionAccount == null">
						<tr >
							<s:if test="#request.auctionInfoDtoIndex.companyInterfaceFlag == 1">
								<td align="right">
								<a href="<s:property value="#request.auctionInfoDtoIndex.visitUrl"/>" >
							  		<img src="useeasy/auction/images/main/btn_out01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								<a href="<s:property value="#request.auctionInfoDtoIndex.loginUrl"/>" >
						  			<img src="useeasy/auction/images/main/btn_out02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	<a href="<s:property value="#request.auctionInfoDtoIndex.loginUrl"/>"  >
							  		<img src="useeasy/auction/images/main/btn_out03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>		
							</s:if>
							<s:else>
								<td align="right"><a href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
								  	<img src="useeasy/auction/images/main/btn_out01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  </td>
								  <td align="right"><a href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
								  	<img src="useeasy/auction/images/main/btn_out02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  </td>
					  			  <td align="right"><a href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
								  	<img src="useeasy/auction/images/main/btn_out03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>	
							</s:else>
						</tr>
						</s:if>
						<s:else>
							<s:if test="#request.auctionInfoDtoIndex.auctionStatus == 2">
								<tr >
								<td align="right"><a href="javascript:void(0);">
								  	<img src="useeasy/auction/images/main/btn_up01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								</td>
							  	<td align="right"><a href="javascript:void(0);" >
						  			<img src="useeasy/auction/images/main/btn_up02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>
						  		<td align="right"><a href="javascript:void(0);" >
							  		<img src="useeasy/auction/images/main/btn_up03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>		
								</tr>
							</s:if>
							<s:else>
								<s:if test="#session._listener.auctionAccount.accountType == 1">
								<tr >
								<td align="right"><a href="javascript:void(0);">
								  	<img src="useeasy/auction/images/main/btn_up01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								</td>
							  	<td align="right"><a href="javascript:void(0);" >
						  			<img src="useeasy/auction/images/main/btn_up02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>
						  		<td align="right"><a href="javascript:void(0);" >
							  		<img src="useeasy/auction/images/main/btn_up03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>		
								</tr>
							</s:if>
							<s:if test="#session._listener.auctionAccount.accountType == 2">
								<tr >
								<td align="right">
								<a href="biddingView_checkViewer?auctionFlag=<s:property value="#request.auctionInfoDtoIndex.id"/>" target="_blank">
								  	<img src="useeasy/auction/images/main/btn_out01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								</td>
							  	<td align="right"><a href="javascript:void(0);" >
						  			<img src="useeasy/auction/images/main/btn_up02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>
						  		<td align="right"><a href="javascript:void(0);" >
							  		<img src="useeasy/auction/images/main/btn_up03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
							  	</td>		
								</tr>
							</s:if>
							<s:if test="#session._listener.auctionAccount.accountType == 3">
								<tr >
								<s:if test="#request.auctionInfoDtoIndex.companyInterfaceFlag == 1">
									<td align="right">
									<a href="<s:property value="#request.auctionInfoDtoIndex.visitUrl"/>" >
								  		<img src="useeasy/auction/images/main/btn_out01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
									<a href="<s:property value="#request.auctionInfoDtoIndex.loginUrl"/>" >
							  			<img src="useeasy/auction/images/main/btn_out02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  	<a href="<s:property value="#request.auctionInfoDtoIndex.loginUrl"/>"  >
								  		<img src="useeasy/auction/images/main/btn_out03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  	</td>		
								</s:if>
								<s:else>
									<td align="right">
									<a href="biddingView_checkViewer?auctionFlag=<s:property value="#request.auctionInfoDtoIndex.id"/>" target="_blank">
									  	<img src="useeasy/auction/images/main/btn_out01.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
									</td>
								  	<td align="right"><a id="application_key" lang="<s:property value="#request.auctionInfoDtoIndex.id"/>" href="javascript:void(0);" >
							  			<img src="useeasy/auction/images/main/btn_out02.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  	</td>
							  		<td align="right">
							  			<a href="guestApplication_checkCustomer?auctionFlag=<s:property value="#request.auctionInfoDtoIndex.id"/>" target="_blank">
							  			<img src="useeasy/auction/images/main/btn_out03.gif" name="Image3" width="69" height="54" border="0" id="Image3" /></a>
								  	</td>
								</s:else>
								</tr>
								
									
								
							</s:if>
							</s:else>
						</s:else>
				  </table>
				  </form>
				  
				  <div class="list" id="gonggao1">
				  <s:if test="#request.auctionInfoDtoIndex.auctionBulletin.length() > 450">
				  	<s:property value="#request.auctionInfoDtoIndex.auctionBulletin.substring(0,450)"  escape="false" />...<br/>
			  		<a href='javascript:void(0);' onclick="showAll('<s:property value="#request.auctionInfoDtoIndex.id"/>','1');return false;" ><font color=red>详细</font></a>
				  </s:if>
				  <s:else>
				  	<s:property value="#request.auctionInfoDtoIndex.auctionBulletin"  escape="false" />
				  </s:else>
				  </div>
				  <div class="list" id="guize1" style="display:none" >
				  <s:if test="#request.auctionInfoDtoIndex.auctionNotice.length() > 450">
				  	<s:property value="#request.auctionInfoDtoIndex.auctionNotice.substring(0,450)"  escape="false" />...<br/>
			  		<a href='javascript:void(0);' onclick="showAll('<s:property value="#request.auctionInfoDtoIndex.id"/>','2');return false;" ><font color=red>详细</font></a>
				  </s:if>
				  <s:else>
				  	<s:property value="#request.auctionInfoDtoIndex.auctionNotice"  escape="false" />
				  </s:else>
				  </div>
				  <div class="list" id="guiding1"  style="display:none">
				  <s:if test="#request.auctionInfoDtoIndex.auctionGuide.length() > 450">
				  	<s:property value="#request.auctionInfoDtoIndex.auctionGuide.substring(0,450)"  escape="false" />...<br/>
			  		<a href='javascript:void(0);' onclick="showAll('<s:property value="#request.auctionInfoDtoIndex.id"/>','3');return false;" ><font color=red>详细</font></a>
				  </s:if>
				  <s:else>
				  	<s:property value="#request.auctionInfoDtoIndex.auctionGuide"  escape="false" />
				  </s:else>
				  </div>
				  <div class="list" id="shuoming1" style="display:none">
				  <s:if test="#request.auctionInfoDtoIndex.auctionDescription.length() > 450">
				  	<s:property value="#request.auctionInfoDtoIndex.auctionDescription.substring(0,450)"  escape="false" />...<br/>
			  		<a href='javascript:void(0);' onclick="showAll('<s:property value="#request.auctionInfoDtoIndex.id"/>','4');return false;" ><font color=red>详细</font></a>
				  </s:if>
				  <s:else>
				  	<s:property value="#request.auctionInfoDtoIndex.auctionDescription"  escape="false" />
				  </s:else>
				  </div>
		 
			</div>
		</div>
		<!--end left-->		
		<!--right-->
		<div class="right">
			<div class="right">
			<div class="sidebar">
				<div class="title">
					<span class="text_s"></span>
					<span class="more"></span>
				</div>
				<div class="wrap">
					<div class="inside min-height" >
					
					  <table cellpadding="0" cellspacing="0" class="info" id="table1" >
                          <thead>
                            <tr>
                              <th class="picCol">图片</th>
                              <th class="nameCol">标的名称</th>
                              <th class="introCol">标的简介</th>
                              <th class="priceCol">参考价<%--/佣金--%></th> 
                              <th class="resultCol">拍卖结果</th>
                            </tr>
                          </thead>
                          <tbody>
                          
                          <s:iterator value="#request.itemInfoDtoList" var="itemInfoDtoList">
                          <tr valign="top">
                              <td>
                              	<p>
                              	<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoDtoList.id'/>">
                              	<s:if test="#itemInfoDtoList.imgUrl == null || #itemInfoDtoList.imgUrl == '' ">
                              	<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" width="88" height="66" border="0" />
                              	</s:if>
                              	<s:else>
                              	<img src="<%=request.getContextPath()%><s:property value="#itemInfoDtoList.imgUrl"/>" width="88" height="66" border="0" />
                              	</s:else>
                              	</a>
                              	</p>
                              	<s:property value="#itemInfoDtoList.itemNumber"/>
                              </td>
                              <td>
                              	<p>
                              	<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoDtoList.id'/>">
                              	<s:if test="#itemInfoDtoList.itemName.length() > 30">
                              		<s:property value="#itemInfoDtoList.itemName.substring(0,30)"/>...
                              	</s:if>
                              	<s:else>
                              		<s:property value="#itemInfoDtoList.itemName"/>
                              	</s:else>
                              	</a>  
                              	<s:if test="#itemInfoDtoList.imgCountFlag == 1">
                                	<span style="color:red">[多图]</span> 
                                </s:if>                            	
                              	</p>
                              	
                              </td>
                              <td>
                              	<s:if test="#itemInfoDtoList.itemDescription.length() > 80">
                              		<p class="intro" title="<s:property value="#itemInfoDtoList.itemDescription;.substring(0,80)"/>...">
										<s:property value="#itemInfoDtoList.itemDescription.substring(0,80)"/>...
									</p>
                              	</s:if>
                              	<s:else>
	                              	<p class="intro" title="<s:property value="#itemInfoDtoList.itemDescription"/>">
										<s:property value="#itemInfoDtoList.itemDescription"/>
									</p>
                              	</s:else>
                              	
                              </td>
                              <td>
                              	  <p class="priceInfo">
                              	  <s:if test="#itemInfoDtoList.itemReferencePriceFir != null && #itemInfoDtoList.itemReferencePriceSec != null">
                              	  <s:property value="#itemInfoDtoList.itemReferencePriceFir"/>
                              	  -
                              	  <s:property value="#itemInfoDtoList.itemReferencePriceSec"/>
                              	  </s:if>
                              	  </p>
                              </td> 
                              <td>
                              	  <p>
                              	  <s:if test="#itemInfoDtoList.itemStatus == 0">
                              	  尚未开始
                              	  </s:if>
                              	  <s:elseif test="#itemInfoDtoList.itemStatus == 1 || 
                              	  	#itemInfoDtoList.itemStatus == 2 
                              	  	|| #itemInfoDtoList.itemStatus == 3
                              	  	|| #itemInfoDtoList.itemStatus == 4">
                              	  正在进行
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoDtoList.itemStatus == 5">
                              	  成交
                              	  	<s:if test="#itemInfoDtoList.itemLockFlag == 1">
                              	  	<br/>
                              	  	<s:property value="#itemInfoDtoList.itemCurrentPrice"/>
                              	  	</s:if>
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoDtoList.itemStatus == 6">
                              	  流标
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoDtoList.itemStatus == 7">
                              	  撤拍
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoDtoList.itemStatus == 8">
                              	  缓拍
                              	  </s:elseif>
                              	  </p>
                              	  <p class="lock"> 
                              	   <s:if test="#itemInfoDtoList.itemLockFlag == 0">
                              	   	<img src="useeasy/auction/images/main/lock.gif"/>
                              	   </s:if>
                              	  </p>
                              	  
                              	  
                              </td>
                            </tr>
                          </s:iterator>
                            
                           
                            
                           
                          </tbody>
                      </table>
                      <jsp:include page="../main/pagination_s.jsp" flush="true"/>
                       </div>
					  
				 
				</div>
				<div class="bottom"> </div>
			</div>
		</div>
	 
	</div>
		<!--end main-->
		
		
		<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
	</div>
	<!--end container-->
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

function showAll(auctionId,detailType){ 
	window.showModalDialog("auctionIndex_auctionDetailAll?detailType="+detailType+"&auctionFlag="+auctionId, "","dialogWidth=1024px;dialogHeight=800px"); 
}
	 
</script>
</body>
</html>