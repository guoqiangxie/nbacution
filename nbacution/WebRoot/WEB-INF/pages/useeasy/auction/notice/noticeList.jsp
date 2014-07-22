<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%>
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
  				<div class="l">公告管理</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"    href="noticeAction_addUI">新建公告</a> &nbsp;&nbsp;
	  			</div>
	  			</div> 
	  			
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
              <tr>
                <td bgcolor="#FFFFFF">公告标题 </td>
                 <td bgcolor="#FFFFFF">拍卖时间</td>
                  <td bgcolor="#FFFFFF">公司电话</td>
                 <td bgcolor="#FFFFFF"> 拍卖公司</td>
                  <td bgcolor="#FFFFFF"> 拍卖会名称 </td>
                 <td bgcolor="#FFFFFF">公告类型</td>
                 <td bgcolor="#FFFFFF">基本操作 </td>
                  
              </tr>
              <s:iterator value="#request.list" var="list">
             <tr>
               <td bgcolor="#FFFFFF" title="<s:property value="#list.title"/>"> 
                   <s:if test="#list.title.length()>20">
                   <s:property value="#list.title.substring(0,15)"/>...</s:if>
                   <s:else><s:property value="#list.title"/></s:else>
               
                </td>
                 <td bgcolor="#FFFFFF"><s:date name="#list.createtime" format="yyyy-MM-dd"/></td>
                 <td bgcolor="#FFFFFF"><s:property value="#list.phone"/></td>
                 <td bgcolor="#FFFFFF"><s:property value="#list.company"/></td>
                 <td bgcolor="#FFFFFF" title=" <s:property value="#list.pmhName"/>">
                      <s:if test="#list.pmhName.length()>20">
                    <s:property value="#list.pmhName.substring(0,15)"/>...</s:if>
                   <s:else>
                      <s:property value="#list.pmhName"/>
                   
                   </s:else>
                   
                 </td>
                 <td bgcolor="#FFFFFF"><s:select theme="simple"  disabled="true" list="#{'1':'房地产','2':'艺术品','3':'民品','4':'机动车','5':'物资设备','6':'股权','7':'其他'}" listKey="key" listValue="value" value="#list.notice_type"></s:select></td>
                 <td bgcolor="#FFFFFF"><a href="noticeAction_delete?id=<s:property value='#list.id'/>">删除</a>
                 <a href="noticeAction_updateUI?id=<s:property value='#list.id'/>">修改</a></td>
                  
                   
             
             </tr>
             </s:iterator>
          </table>
	  								  
  			
	   		 
          <pmh:pageTag gotoURI="noticeAction_getCPlist" pageSize="${requestScope.pageSize}"></pmh:pageTag>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
 
</body>
</html>
