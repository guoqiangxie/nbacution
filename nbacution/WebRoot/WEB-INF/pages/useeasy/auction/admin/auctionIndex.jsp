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
<title>宁波市司法拍卖交易平台</title>
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
  				<div class="l">拍卖会列表</div> 
	  			<div class="r">
	  			<!--<a style="color:blue; font-weight:bold;"  href="auctionManage_add" align="center">【拍卖提起】</a>--> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<input type="hidden" id="currentPage" name="currentPage" value="<s:property value="#request.currentPage" />"/>
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              
              <td width="20%" bgcolor="#FFFFFF">LOGO</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="15%" bgcolor="#FFFFFF">开始时间</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖公司</td>
			  <td width="10%" bgcolor="#FFFFFF">发布状态</td>
			  <td width="15%"  bgcolor="#FFFFFF"><span class="td_left" >管理</span></td>
			 
            </tr>
            <s:iterator value="#request.auctionInfoList" var="auctionInfoList">
		            <tr align="center">
							
		              	<td bgcolor="#FFFFFF">
		              	<s:if test="#auctionInfoList.auctionPicType == 1">
		              		<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="60" width="80"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="60" width="80"/>
       						</s:else>
       					</s:if>
       					<s:elseif test="#auctionInfoList.auctionPicType == 2">
       						<s:if test="#auctionInfoList.auctionPicVal == 1">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg" height="60" width="80"/>
       						</s:if>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 2">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg" height="60" width="80"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 3">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg" height="60" width="80"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 4">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg" height="60" width="80"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 5">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg" height="60" width="80"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 6">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg" height="60" width="80"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 7">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg" height="60" width="80"/>
       						</s:elseif>
       					</s:elseif>
       					<s:elseif test="#auctionInfoList.auctionPicType == 3">
       						<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="60" width="80"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="60" width="80"/>
       						</s:else>
    					</s:elseif>
      					</td>
					  	<td bgcolor="#FFFFFF"><s:property value="#auctionInfoList.auctionName"/></td>
					  	<td bgcolor="#FFFFFF"><s:date name="#auctionInfoList.auctionStartTime" format="yyyy-MM-dd HH:mm"/></td>
					 	<td bgcolor="#FFFFFF"><s:property value="#auctionInfoList.companyName"/></td>
					  	<td bgcolor="#FFFFFF">
							<s:if test="#auctionInfoList.publishFlag == 0">
							尚未发布
							</s:if>
            				<s:elseif test="#auctionInfoList.publishFlag == 1">
            				已经发布
            				</s:elseif>
            			</td>
					  	<td bgcolor="#FFFFFF">
							<s:if test="#auctionInfoList.auctionStatus == 0">
								<span style="color:green; font-weight:bold;">尚未开始</span>
	           			 		<br/>
	           			 		<a href="javascript:void(0);" onclick="doGoingAuction(<s:property value="#auctionInfoList.id"/>);return false;">正在拍卖</a>
		              			<br/>
		              			<a href="javascript:void(0);" onclick="doEndAuction(<s:property value="#auctionInfoList.id"/>);return false;">已经结束</a>
					  		</s:if>
            				<s:elseif test="#auctionInfoList.auctionStatus == 1">
            					<a href="javascript:void(0);" onclick="doReadyAuction(<s:property value="#auctionInfoList.id"/>);return false;">尚未开始</a>
	           			 		<br/>
	           			 		<span style="color:green; font-weight:bold;">正在拍卖</span>
            					<br/>
            					<a href="javascript:void(0);" onclick="doEndAuction(<s:property value="#auctionInfoList.id"/>);return false;">已经结束</a>
            				</s:elseif>
            				<s:elseif test="#auctionInfoList.auctionStatus == 2">
            					<a href="javascript:void(0);" onclick="doReadyAuction(<s:property value="#auctionInfoList.id"/>);return false;">尚未开始</a>
	           			 		<br/>
	           			 		<a href="javascript:void(0);" onclick="doGoingAuction(<s:property value="#auctionInfoList.id"/>);return false;">正在拍卖</a>
            					<br/>
            					<span style="color:green; font-weight:bold;">已经结束</span>
            				</s:elseif>
						</td>
					  
		            </tr>
	        </s:iterator>
	      
          </table>
          
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
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function doReadyAuction(str){
		if(confirm("是否重置拍卖会状态为尚未开始！")){
			location.href="adminManage_ready?auctionFlag="+str+"&currentPage="+$("#currentPage").val();
		}
	}
	function doGoingAuction(str){
		if(confirm("是否重置拍卖会状态为正在进行！")){
			location.href="adminManage_going?auctionFlag="+str+"&currentPage="+$("#currentPage").val();
		}
	}
	function doEndAuction(str){
		if(confirm("是否重置拍卖会状态为已经结束！")){
			location.href="adminManage_end?auctionFlag="+str+"&currentPage="+$("#currentPage").val();
		}
	}
</script>
</body>
</html>
