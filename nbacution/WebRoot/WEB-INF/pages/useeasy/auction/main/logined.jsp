<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
	<s:if test="#session._listener.auctionAccount.accountType == 1">
		<div class='input01'><s:property value="#session._listener.auctionAdmin.adminName"/></div>
		<div class='input02'>超级管理员</div>
		<span class='code'><a href='adminManage_auctionIndex?currentPage=1'>
		进入管理</a></span>
		<div class='land1'>
		<a id="logout_a" href="###">退出系统</a>
		</div>  
		</s:if>
	<s:elseif test="#session._listener.auctionAccount.accountType == 2">
		<div class='input01'><s:property value="#session._listener.auctionCompany.companyName"/>
		</div>
		<div class='input02'>会员拍卖公司</div>
		<span class='code'><a href='auctionManage_index?currentPage=1'>
		进入管理</a></span>
		<div class='land1'>
		<a id="logout_a" href="###">退出系统</a>
		</div>  
	</s:elseif>
	<s:elseif test="#session._listener.auctionAccount.accountType == 3">
		<div class='input01'><s:property value="#session._listener.auctionGuest.guestName"/></div>
		<div class='input02'>会员用户</div>
		<span class='code'><a href='guestManage_edit'>
		进入管理</a></span>
		<div class='land1'>
		<a id="logout_a" href="###">退出系统</a>
		</div>  
	</s:elseif>
	<s:elseif test="#session._listener.auctionAccount.accountType == 4">
		<div class='input01'><s:property value="#session._listener.auctionCompany.companyName"/>
		</div>
		<div class='input02'>普通拍卖公司</div>
		<span class='code'><a href='auctionManage_index?currentPage=1'>
		进入管理</a></span>
		<div class='land1'>
		<a id="logout_a" href="###">退出系统</a>
		</div>  
	</s:elseif>
	
	<s:elseif test="#session._listener.auctionAccount.accountType == 5"><!-- 工商 -->
	    <script language="javascript" type="text/javascript">
		 	location.href = "business_index";	
		 </script>	
	</s:elseif>
	
<s:if test="#request.checkFlag == 99">
<script language="javascript" type="text/javascript">
var oldUrl = top.location.href;
var newSize = oldUrl.indexOf("#");
if(newSize==-1){
	var newUrl = oldUrl;
}else{
	var newUrl = oldUrl.substring(0, oldUrl.indexOf("#"));
}
top.location.href=newUrl;

</script>
</s:if>
