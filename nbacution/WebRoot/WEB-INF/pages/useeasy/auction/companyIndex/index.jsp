<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/company.css"	rel="stylesheet" type="text/css" />
<title>宁波市在线同步拍卖交易平台--首页</title>
<script type="text/javascript"  language="javascript">

</script>
</head>
<body>
<div class="container">
	<!--header-->
	<div class="header">
		<div class="topnav">
			<div class="logo">
				<div class="logo_img"></div>
				<div class="name"><s:property value="#request.auctionCompany.companyName" /></div>
			</div>
			
			<div class="sidenav">
				<span>
					<!--  <ul>
						<li>
							<a href="http://www.staa.com.cn"><img src="useeasy/auction/images/main/r_08.gif"  border="0"/> </a>
						</li>
						<li>
							<a href="http://www.gpai.net"><img src="useeasy/auction/images/main/r_04.gif"  border="0"/> </a>
						</li>
						<s:if test="#request.auctionCompany.companyMainPage != null && #request.auctionCompany.companyMainPage != ''">
						<li>
							<a href="<s:property value="#request.auctionCompany.companyMainPage" />"><img src="useeasy/auction/images/main/r_09.gif" border="0" /></a>
						</li>
						</s:if>
					</ul>-->
				</span>
			<a target=_top href="javascript:void(0);" onclick="window.external.addFavorite(location.href,document.title);return false;"></a>  <a href="<%=request.getContextPath()%>"></a>
			</div>
		</div>
		<div class="mainnav">
			<ul>
				<li class="out"><a href="companyIndex_index?currentPage=1&searchType=1&companyId=<s:property value="#request.auctionCompany.id" />"><span>&nbsp;首  页&nbsp;</span></a></li>
				<li class="over"><a href="companyIndex_about?companyId=<s:property value="#request.auctionCompany.id" />"><span>关于我们</span></a></li>
				<li class="over"><a href="<%=request.getContextPath()%>/"><span>网拍首页</span></a></li>
				<li class="over"><a href="companyIndex_bulletin?pageNo=1&companyId=<s:property value="#request.auctionCompany.id" />"><span>拍卖公告</span></a></li>
				<li class="over"><a href="#"><span>参拍指南</span></a></li>
				<!--<li class="over"><a href=""><span>在线留言</span></a></li>
				<li class="over"><a href=""><span>咨询解答</span></a></li>-->
				<li class="over"><a href="companyIndex_connection?companyId=<s:property value="#request.auctionCompany.id" />"><span>联系我们</span></a></li>
			</ul>
		</div>
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
	<!--main-->
	<div class="main">
		<!--left-->
		<div class="left">
					<%-- login --%>
				<!--<div class="login"> 
					
				</div>-->
			<div class="sidebar">
				<div class="title">
					<span class="text">拍卖公告</span>
					<span class="more"><a href="companyIndex_bulletin?pageNo=1&companyId=<s:property value="#request.auctionCompany.id" />">更多>></a></span>
				</div>
				<div class="list">
					<ul>
							 <%@include  file="/WEB-INF/pages/useeasy/auction/notice/notice_Show_five_count.jsp"%>
							
						
					</ul>
			  </div>
			</div>
			<div class="sidebar">
				<div class="title">
					<span class="text">标的展示</span>
				</div>
				<div class="listpic">
					<table cellpadding="0" cellspacing="0" width="100%">
                    	<tbody>
                    		<s:iterator value="#request.itemInfoListTop" var="itemInfoListTop">
                            <tr>
                              <td height="72">
								<a href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoListTop[0]'/>" target="_blank">
									
	                              	<s:if test="#itemInfoListTop[2] == null || #itemInfoListTop[2] == '' ">
	                              	<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" width="80" height="60" border="0" />
	                              	</s:if>
	                              	<s:else>
	                              	<img src="<%=request.getContextPath()%><s:property value="#itemInfoListTop[2]"/>" width="80" height="60" border="0" />
	                              	</s:else>
                              	
								</a> 
                              </td>
                              <td valign="top">
                              		<span title=""><s:property value="#itemInfoListTop[1]"/></span>
                              </td>
                            </tr>
                            </s:iterator>
                        </tbody>
                  </table>
			  </div>
			</div>
		</div>
		<!--end left-->
		<!--right-->
		<div class="right">
			<div class="sidebar">
				<div class="title">
					<span class="text_pmh"></span>
					<span class="btn">
						<ul>
							<li>
								<a href="companyIndex_index?currentPage=1&searchType=2&companyId=<s:property value="#request.auctionCompany.id" />">司法委托拍卖会</a>
							</li>
							<li>
								<a href="companyIndex_index?currentPage=1&searchType=3&companyId=<s:property value="#request.auctionCompany.id" />">社会委托拍会卖</a>
							</li>
						</ul>
					</span>
				</div>
				<div class="wrap">
					<div class="inside">		
						<table id="table1" valign="top">
									<s:iterator value="#request.auctionInfoList" var="auctionInfoList">								
									<tr valign="top">
 										<td>
 										<table cellpadding="0" cellspacing="0" width="100%" class="infoList"  >
    										<tbody>
      											<tr title="<s:property value="#auctionInfoList.companyName"/>">
       												<td width="150">
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
       												</td>
       												<td ><p class="titleInfo"><a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoList.id'/>&currentPage=1"><s:property value="#auctionInfoList.auctionName"/></a></p>
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
													
												</tr>
     										</tbody>
										</table>
 										</td>
 									</tr>
 									</s:iterator>
								</table>
						<table width="98%" align="center">	
							<tr>
								<td>
									<jsp:include page="../main/pagination_s.jsp" flush="true"/>
								</td>
							</tr>
						</table>
							
					</div>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<!--end right-->
		
	</div><div style="clear:both;"></div>
	<!--end main-->
	<!--footer-->
<div>		
<jsp:include page="../main/footer.jsp" flush="true"/>
</div>
	<!--end footer-->
</div>
</body>
</html>