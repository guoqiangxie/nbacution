<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/main.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="useeasy/auction/js/main/onload.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台--房地产拍卖会频道</title>
<script type="text/javascript"  language="javascript">
$(document).ready(function(){
	$("#index").removeAttr("class").addClass("over");
	$("#house").removeAttr("class").addClass("out");
	$("#automobile").removeAttr("class").addClass("over");
	$("#material").removeAttr("class").addClass("over");
	$("#stock").removeAttr("class").addClass("over");
	$("#mlpllz").removeAttr("class").addClass("over");
	$("#art").removeAttr("class").addClass("over");
	$("#other").removeAttr("class").addClass("over");
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
			<jsp:include page="../main/header.jsp" flush="true"/>
		</div>
		<!--end header-->
		
	
		
		<!--main-->
		<div class="main">
			<!--left-->
			<div class="left">
				<%-- login --%>
				<div class="login"> 
					
				</div>
				<%--bid1 --%>
				<jsp:include page="../main/bid1.jsp" flush="true" />
				<div class="img"><img src="useeasy/auction/images/main/s_ban01.gif" height="100" width="230"/></div>
				<div class="img"><img src="useeasy/auction/images/main/s_ban02.gif" height="70" width="230"/></div>
				<div><img src="useeasy/auction/images/main/s_ban03.gif" height="70" width="230"/></div>
				
				<div class="sidebar">
					<div class="title">
						<span class="text">网络拍卖会员企业</span>
						<span class="more"></span>
					</div>
					<jsp:include page="../main/companyList.jsp" flush="true"/>
					
				</div>
					
				<%-- guide --%>
				<div class="sidebar">
					<div class="title">
						<span class="text">拍卖指南</span>
						<span class="more"></span>
					</div>
					<jsp:include page="../main/leftGuide.jsp" flush="true"/>
				</div>
			</div>
			<!--end left-->
			
			<!--right-->
			<div id="right" class="right" >
			     	<!--banner-->
	              	 <div class="banner"></div>
		            <!--end banner-->
				<div class="sidebar">
					
					<div class="title">
						<span class="text"><img src="useeasy/auction/images/main/title_fdc.gif" /></span>
						<span class="more"></span>
					</div>
					
					<div class="wrap">
						<div class="inside min-height">
							<div class="nav" >
								<ul>
									<li class="t">排序方式：</li>
									<s:if test="#request.searchType != 1">
									<li><a href="auctionIndex_index?searchKind=2&searchType=1&currentPage=1"><img id="img1" src="useeasy/auction/images/main/icon03.gif" class="icon" />
										进行中拍卖会 </a>
									</li>
									</s:if>
									<s:else>
									<li><img id="img1" src="useeasy/auction/images/main/icon02.gif" class="icon" />
										进行中拍卖会 
									</li>
									</s:else>
									<s:if test="#request.searchType != 2">
									<li><a href="auctionIndex_index?searchKind=2&searchType=2&currentPage=1"><img id="img2" src="useeasy/auction/images/main/icon03.gif" class="icon" />
										今天的拍卖会</a>
									</li>
									</s:if>
									<s:else>
									<li><img id="img2" src="useeasy/auction/images/main/icon02.gif" class="icon" />
										今天的拍卖会
									</li>
									</s:else>
									<s:if test="#request.searchType != 3">
									<li><a href="auctionIndex_index?searchKind=2&searchType=3&currentPage=1"><img id="img3" src="useeasy/auction/images/main/icon03.gif" class="icon" />
										近期的拍卖会</a>
									</li>
									</s:if>
									<s:else>
									<li><img id="img3" src="useeasy/auction/images/main/icon02.gif" class="icon" />
										近期的拍卖会
									</li>
									</s:else>
									<s:if test="#request.searchType != 4">
									<li><a href="auctionIndex_index?searchKind=2&searchType=4&currentPage=1"><img id="img4" src="useeasy/auction/images/main/icon03.gif" class="icon" />
										已结束拍卖会</a>
									</li>
									</s:if>
									<s:else>
									<li><img id="img4" src="useeasy/auction/images/main/icon02.gif" class="icon" />
										已结束拍卖会
									</li>
									</s:else>
								</ul>
							</div>
							
							<div> 
								<form action="" method="post">
								<table id="table1" valign="top">
									<s:iterator value="#request.auctionInfoList" var="auctionInfoList">								
									<tr valign="top">
 										<td>
 										<table cellpadding="0" cellspacing="0" width="100%" class="infoList"  >
    										<tbody>
      											<tr title="<s:property value="#auctionInfoList.companyName"/>">
       												<td width="150">
       												<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoList.id'/>&currentPage=1" >
       												<s:if test="#auctionInfoList.auctionPicType == 1">
       													<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
							       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="90" width="120" border="0"/>
							       						</s:if>
							       						<s:else>
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120" border="0"/>
							       						</s:else>
       												</s:if>
							       					<s:elseif test="#auctionInfoList.auctionPicType == 2">
							       						<s:if test="#auctionInfoList.auctionPicVal == 1">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg" height="90" width="120" border="0"/>
							       						</s:if>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 2">
       														<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 3">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 4">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 5">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 6">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       						<s:elseif test="#auctionInfoList.auctionPicVal == 7">
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg" height="90" width="120" border="0"/>
							       						</s:elseif>
							       					</s:elseif>
							       					<s:elseif test="#auctionInfoList.auctionPicType == 3">
							       						<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
							       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="90" width="120" border="0"/>
							       						</s:if>
							       						<s:else>
							       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120" border="0"/>
							       						</s:else>
							       					</s:elseif>
							       					</a>
       												</td>
       												<td ><p class="titleInfo">
       												      
       												     <s:if test="#auctionInfoList.auctionName.length()>20">
       												        <a title="<s:property value="#auctionInfoList.auctionName"/>" target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoList.id'/>&currentPage=1">
       												          <s:property value="#auctionInfoList.auctionName.substring(0, 20)"/>...
       												          </a>
       												     </s:if>
       												     <s:else>
       												        <a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoList.id'/>&currentPage=1">
                                                             <s:property value="#auctionInfoList.auctionName"/>
                                                             </a>
                                                         </s:else>
       												  </p>
            										<p>拍卖时间：<s:date name="#auctionInfoList.auctionStartTime" format="yyyy-MM-dd HH:mm"/>
            											<span class="end">
            											<s:if test="#auctionInfoList.auctionStatus == 0">
            											（尚未开始）
            											</s:if>
            											<s:elseif test="#auctionInfoList.auctionStatus == 1">
            											（正在进行）
            											</s:elseif>
            											<s:elseif test="#auctionInfoList.auctionStatus == 2">
            											（已经结束）
            											</s:elseif>
            											</span>
            										</p>
            										<p>拍卖地点：<s:property value="#auctionInfoList.auctionAddress"/></p>
           											<p>公司名称：<s:property value="#auctionInfoList.companyName"/></p>
            										<p>咨询电话：<s:property value="#auctionInfoList.auctionLinkTel"/></p>
													</td>
													<s:if test="#session._listener.auctionAccount == null">
														<s:if test="#auctionInfoList.companyInterfaceFlag == 1">
														<td align="right">
															<a href="<s:property value="#auctionInfoList.visitUrl"/>" >
														  		<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															<a href="<s:property value="#auctionInfoList.loginUrl"/>" >
													  			<img src="useeasy/auction/images/main/btn_down02.gif" name="Image3"   border="0" id="Image3" /></a><br/>
														  	<a href="<s:property value="#auctionInfoList.loginUrl"/>"  >
														  		<img src="useeasy/auction/images/main/btn_down03.gif" name="Image3"   border="0" id="Image3" /></a>
														  	</td>		
														</s:if>
														<s:else>
															<td align="right">
																<a href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
															  	<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
															  	<img src="useeasy/auction/images/main/btn_down02.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="auctionLogin_specialLogin?requestUrl=<s:property value="#request.requestUrl"/>" >
															  	<img src="useeasy/auction/images/main/btn_down03.gif" name="Image3"   border="0" id="Image3" /></a>
														  </td>
														</s:else>
													</s:if>
													<s:else>
														<s:if test="#auctionInfoList.auctionStatus == 2">
																<td align="right">
																  	<a href="javascript:void(0);">
															  	<img src="useeasy/auction/images/main/pm02_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="javascript:void(0);" >
															  	<img src="useeasy/auction/images/main/pm01_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="javascript:void(0);" >
															  	<img src="useeasy/auction/images/main/pm03_over.gif" name="Image3"   border="0" id="Image3" /></a>
																</td>
														</s:if>
														<s:else>
															<s:if test="#session._listener.auctionAccount.accountType == 1">
															
																<td align="right">
																  	<a href="javascript:void(0);">
															  	<img src="useeasy/auction/images/main/pm02_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="javascript:void(0);" >
															  	<img src="useeasy/auction/images/main/pm01_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
															  	<a  href="javascript:void(0);" >
															  	<img src="useeasy/auction/images/main/pm03_over.gif" name="Image3"   border="0" id="Image3" /></a>
																</td>
														  	</s:if>
															
															<s:elseif test="#session._listener.auctionAccount.accountType == 2">
																<s:if test="#auctionInfoList.companyInterfaceFlag == 1">
																	<td align="right">
																	<a href="<s:property value="#auctionInfoList.visitUrl"/>" >
																  	<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																	<a  href="javascript:void(0);" >
																  		<img src="useeasy/auction/images/main/pm01_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																  	<a  href="javascript:void(0);" >
																  		<img src="useeasy/auction/images/main/pm03_over.gif" name="Image3"   border="0" id="Image3" /></a>
																	</td>		
																</s:if>
																<s:else>
																	<td align="right">
																	<a href="biddingView_checkViewer?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">
																		<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																  	<a  href="javascript:void(0);" >
																  		<img src="useeasy/auction/images/main/pm01_over.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																  	<a  href="javascript:void(0);" >
																  		<img src="useeasy/auction/images/main/pm03_over.gif" name="Image3"   border="0" id="Image3" /></a>
																	</td>
																</s:else>
															</s:elseif>
															
															<s:elseif test="#session._listener.auctionAccount.accountType == 3">
																<s:if test="#auctionInfoList.companyInterfaceFlag == 1">
																	<td align="right">
																	<a href="<s:property value="#auctionInfoList.visitUrl"/>" >
																  	<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																	<a href="<s:property value="#auctionInfoList.loginUrl"/>" >
															  			<img src="useeasy/auction/images/main/btn_down02.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																  	<a href="<s:property value="#auctionInfoList.loginUrl"/>"  >
																  		<img src="useeasy/auction/images/main/btn_down03.gif" name="Image3"   border="0" id="Image3" /></a>
																  	</td>		
																</s:if>
																<s:else>
																	<td align="right">
																	<a href="biddingView_checkViewer?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">
																  	<img src="useeasy/auction/images/main/btn_down01.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																	<a class="application_key" lang="<s:property value="#auctionInfoList.id"/>" href="javascript:void(0);" >
															  			<img src="useeasy/auction/images/main/btn_down02.gif" name="Image3"   border="0" id="Image3" /></a><br/>
																  	<a href="guestApplication_checkCustomer?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">
																  		<img src="useeasy/auction/images/main/btn_down03.gif" name="Image3"   border="0" id="Image3" /></a>
																  	</td>
																</s:else>
															</s:elseif>
															
														</s:else>
														
													</s:else>
												</tr>
     										</tbody>
										</table>
 										</td>
 									</tr>
 									</s:iterator>
								</table>
								</form>
							</div>
							
							<table cellSpacing="0" cellPadding="0" width="100%" align="center">
								<tbody>
									<tr>
										<td id="tdPages" class="pageBar_style">
											<jsp:include page="../main/pagination_s.jsp" flush="true"/>
										</td>
									</tr>
								</tbody>
							</table>
							
						</div> 
					</div>
					
					<div class="bottom"></div>
				</div>
				
				<div class="blank"></div>
				
			</div>
			<!--end right-->
		</div>
		<!--end main-->
		<div class="biao">
					<div class="title">
						<span class="text01"></span>
						<span class="more"></span>
					</div>
					<div class="wrap">
						<jsp:include page="../main/itemRecommend.jsp" flush="true"/>
					</div>
					<div class="bottom"></div>
				</div>
		<!--link-->
		<jsp:include page="../main/link.jsp" flush="true"/>
		<!--submenu-->
		<jsp:include page="../main/submenu.jsp" flush="true"/>
		<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
	<!--end container-->
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$(".application_key").click(function(){
		var auction_key = $(this).attr("lang");
		var apply_url = "guestApplication_checkApply?auctionFlag="
			+auction_key;
		$.post(apply_url,function(data){
			if(data == 1){
				alert("您已经申请过该拍卖会的参拍要求！");	
			}else if(data == 2){
				alert("拍卖会已经结束！");	
			}else{
				location.href="guestApplication_apply?auctionFlag="
					+auction_key;
			}
		});
	});
	
	$(".customer_key").click(function(){
		var auction_key = $(this).attr("lang");
		var apply_url = "guestApplication_checkCustomer?auctionFlag="
			+auction_key;
		$.post(apply_url,function(data){
			if(data == 0){
				alert("对不起 ，您不能进入该场拍卖会！");	
			}else if(data == 2){
				document.forms[0].target="_blank";
				document.forms[0].action="guestApplication_customer?auctionFlag="
					+auction_key;
				document.forms[0].submit();
			}else{
				document.forms[0].target="_blank";
				document.forms[0].action="guestApplication_customerWait?auctionFlag="
					+auction_key;
				document.forms[0].submit();
			}
		});
	});
	
	$(".viewer_key").click(function(){
		var auction_key = $(this).attr("lang");
		var apply_url = "biddingView_checkViewer?auctionFlag="
			+auction_key;
		$.post(apply_url,function(data){
			if(data == 0){
				alert("对不起 ，您不能观摩该场拍卖会！");	
			}else if(data == 2){
				document.forms[0].target="_blank";
				document.forms[0].action="biddingView_viewer?auctionFlag="
					+auction_key;
				document.forms[0].submit();
			}else if(data == 3){
				alert("对不起 ，人数已经达到上限！");	
			}else{
				document.forms[0].target="_blank";
				document.forms[0].action="biddingView_viewerWait?auctionFlag="
					+auction_key;
				document.forms[0].submit();
			}
		});
	});
	
});

</script>
</body>
</html>