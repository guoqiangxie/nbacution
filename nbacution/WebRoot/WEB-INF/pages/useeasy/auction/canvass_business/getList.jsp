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
  				<div class="l">招商管理</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"    href="businessAction_addUI">新加</a> &nbsp;&nbsp;
	  			</div>
	  			</div> 
	  			
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
              <tr>
                <td bgcolor="#FFFFFF">序号</td>
          <td bgcolor="#FFFFFF">标题</td>
          <td bgcolor="#FFFFFF">标题图片</td>
           <td bgcolor="#FFFFFF">点击次数</td>
           <td bgcolor="#FFFFFF">发布时间</td>
           <td bgcolor="#FFFFFF">基本操作</td>
                  
              </tr>
             <s:iterator value="#request.list" var="list" status="flag">
            <tr>
                 <td bgcolor="#FFFFFF"><s:property value="#flag.index+1"/>  </td>
                 <td bgcolor="#FFFFFF" title="<s:property value="#list.title"/>">
                   <a href="businessAction_get?id=<s:property value='#list.id'/>">
                     <s:if test="#list.title.length()>20"> <s:property value="#list.title.substring(0,20)"/>...</s:if>
                     <s:else>  <s:property value="#list.title"/></s:else>
                  </a>
                    </td> 
                 <td bgcolor="#FFFFFF"><img src="<s:property value="#list.imgPath"/>" width="70" height="50"/>   </td> 
                 <td bgcolor="#FFFFFF"><s:property value="#list.hitcount"/>  </td> 
                 <td bgcolor="#FFFFFF"><s:date name="#list.createTime" format="yyyy-MM-dd"/>  </td> 
                 <td bgcolor="#FFFFFF">
                    <a href="businessAction_delete?id=<s:property value='#list.id'/>">删除</a>
                     <a href="businessAction_updateUI?id=<s:property value='#list.id'/>">修改</a>
                  </td> 
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
