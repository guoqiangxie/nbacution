<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%> 
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
<script type="text/javascript" src="useeasy/auction/js/company/passEdit.js" language="javascript"></script>
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
			<span class="topbtn">
			<a href="auctionSpecial_index">
			<img src="useeasy/auction/images/main/top_btn01.gif" border=0/></a>
			<a href="auctionInteration_index">
			<img src="useeasy/auction/images/main/top_btn02.gif" border=0/></a>
			</span> 
			</div>
			<!--end mainnav-->
		
			<div class="msg">
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  >
				<s:iterator value="auctionTopInfo_list" var="aucTopInfo_list">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="###" onclick="alert(<s:property value="#aucTopInfo_list.id"/>)"><s:property 

value="#aucTopInfo_list.auctionName"/></a>
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
  				<div class="l">行业信息列表</div>
	  			<div class="r"><a href="auctionIndexVocationnews_index_add">添加行业信息</a></div>
	  			</div> 
	  			
	  		 <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
      
      <tr><td  bgcolor="#FFFFFF">行业动态标题</td> <td  bgcolor="#FFFFFF">发布时间</td><td  bgcolor="#FFFFFF">图片</td>
      <td  bgcolor="#FFFFFF">修改</td> <td  bgcolor="#FFFFFF">删除</td></tr>
     <s:iterator value="#request.vocation_list_all" var="list">
     <tr><td  bgcolor="#FFFFFF"><s:property value="#list.vnewstitle"/></td> 
     <td  bgcolor="#FFFFFF"><s:date name="#list.vnewsdate" format="yyyy-MM-dd"/></td>
     <td  bgcolor="#FFFFFF"><img src="<s:property value="#list.vnewsimagepath"/>" width="100" height="100" /></td>
     <td  bgcolor="#FFFFFF"><a href="auctionIndexVocationnews_queryid?id=<s:property value="#list.vnewsid"/>">修改</a></td>
      <td  bgcolor="#FFFFFF"><a href="auctionIndexVocationnews_delete?id=<s:property value="#list.vnewsid"/>">删除</a></td></tr>
     </s:iterator>
     </table>
     <pmh:pageTag gotoURI="auctionIndexVocationnews_vocationmangerindex" pageSize="${requestScope.pageSize}"></pmh:pageTag>   
	   	 	</div>
	   	 	
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
</body>
</html>
