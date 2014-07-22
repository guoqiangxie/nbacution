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
  				<div class="l">
  				<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=0" align="center">【全部】</a>
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=1" align="center">【拍卖流程】</a>
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=2" align="center">【疑问解答】</a>
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=3" align="center">【操作规则】</a>
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=4" align="center">【法律法规】</a>
	  			</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideAdd" align="center">【新建】</a> 
	  			</div>
	  			</div> 
	  			
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              
              <td width="60%" bgcolor="#FFFFFF">指南标题</td>
			  <td width="30%" bgcolor="#FFFFFF">指南类型</td>
			  <td width="10%" bgcolor="#FFFFFF">操作</td>
			 
            </tr>
            <s:iterator value="#request.auctionGuideList" var="auctionGuideList">
		            <tr>
		              <td align="center" bgcolor="#FFFFFF">
							<s:property value="#auctionGuideList.guideTitle"/>
					  </td>
					  <td align="center" bgcolor="#FFFFFF">
					  		<s:if test="#auctionGuideList.guideType == 1">拍卖流程</s:if>
							<s:elseif test="#auctionGuideList.guideType == 2">疑问解答</s:elseif>
							<s:elseif test="#auctionGuideList.guideType == 3">操作规则</s:elseif>
							<s:elseif test="#auctionGuideList.guideType == 4">法律法规</s:elseif>
					  </td>
					  <td width="" align="left" bgcolor="#FFFFFF">
							<a href="adminManage_guideEdit?guideFlag=<s:property value="#auctionGuideList.id"/>" >修改</a>
							<a href="javascript:void(0);" onclick="doDelete(<s:property value="#auctionGuideList.id"/>);return false;">删除</a>
					  </td>
            		</tr> 
	        </s:iterator>
          </table>
          
          
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function doDelete(str){
		if(confirm("是否删除该拍卖指南！")){
			location.href="adminManage_guideDelete?guideFlag="+str;
		}
	}
</script>
</body>
</html>
