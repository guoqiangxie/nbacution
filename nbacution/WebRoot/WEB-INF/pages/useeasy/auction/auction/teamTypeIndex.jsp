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
<script type="text/javascript" src="useeasy/plugins/checkbox/js/checkboxgroup.js" language="javascript"></script>
<script type="text/javascript" src="useeasy/auction/js/teamType/teamType.js" language="javascript"></script>
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
		  	<div class="l">拍卖会特别资质管理</div>
		  	<div class="r">
		  		
	  			<a style="color:blue; font-weight:bold;" href="auctionManage_addTeamType?auctionFlag=<s:property value="#request.auctionFlag"/>">【新建拍卖组别】</a> 
	  			<s:if test="#request.auctionTeamTypeList.size() > 0">
	  				<a style="color:blue; font-weight:bold;" onclick="doDeleteAuctionTeamType(<s:property value="#request.auctionFlag"/>);return false;" href="javascript:void(0);">【删除拍卖组别】</a> 
	  			</s:if>
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_index">【返回】</a> 
  			</div>
		  </div>
		  <form action="" method="post">
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">
			  <td width="10" align="center" bgcolor="#FFFFFF">
			  <input type="checkbox" class="checkall"/>
			  </td>
              <td width="20%" bgcolor="#FFFFFF">序号</td>
              <td width="40%" align="center" bgcolor="#FFFFFF">拍卖组别</td>
			  <td width="40%" align="center" bgcolor="#FFFFFF">说明</td>
            </tr>
            	
            	<s:iterator value="#request.auctionTeamTypeList" var="auctionTeamTypeList" status="status">
            		<!--<s:property value="#status.index+1"/>-->
            	
			            <tr align="center" id="">
		
						  <td bgcolor="#FFFFFF" >
						  	<input class="groupclass" name="group" type="checkbox" value="<s:property value="#auctionTeamTypeList.id"/>"/>
						  </td>
						  <td bgcolor="#FFFFFF">
						  	<s:property value="#status.index+1"/>
						  </td>
			              
						  <td bgcolor="#FFFFFF">
							  <s:property value="#auctionTeamTypeList.teamType"/>
						  </td>
					   	  <td bgcolor="#FFFFFF">
							  <s:property value="#auctionTeamTypeList.teamDescription"/>
						  </td>
			            </tr>
			</s:iterator>
			<tr align="left" >
				
			</tr>
          </table>
          
          
		  </form>
		 </div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>

</body>
</html>
