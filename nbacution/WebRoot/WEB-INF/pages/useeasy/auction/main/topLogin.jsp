<%@ page contentType="text/html; charset=utf-8"%>	
 <%@taglib uri="/struts-tags"  prefix="s"%>
<div class="topnav"> 
	<a href="http://www.gpai.net"><div class="logo" style="cursor:pointer"></div></a>
	
	<div class="sidenav">
          <s:if test="#session._listener.auctionAccount.accountType==1">
             <div><font color="red"> <s:property value="#session._listener.auctionAdmin.adminName"/></font>&nbsp; 欢迎登录&nbsp;帐号:<s:property value="#session._listener.auctionAccount.accountName"/></div>
          </s:if>
            <s:if test="#session._listener.auctionAccount.accountType==2">
             <div> <font color="red"><s:property value="#session._listener.auctionCompany.companyName"/></font>&nbsp; 欢迎登录&nbsp;帐号:<s:property value="#session._listener.auctionAccount.accountName"/></div>
          </s:if>
            <s:if test="#session._listener.auctionAccount.accountType==3">
             <div> <font color="red"><s:property value="#session._listener.auctionGuest.guestName"/></font>&nbsp; 欢迎登录&nbsp;帐号:<s:property value="#session._listener.auctionAccount.accountName"/></div>
          </s:if>

    </div>
</div>

		
