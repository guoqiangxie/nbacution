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
  				<div class="l">拍卖公告管理</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="companyBulletin_add" align="center">【新建公告】</a> 
	  			</div>
	  			</div> 
	  			
	  		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              
              <td width="20%" bgcolor="#FFFFFF">拍卖会名称</td>
			  <td width="15%" bgcolor="#FFFFFF">拍卖会形式</td>
			  <td width="30%"  bgcolor="#FFFFFF"><span class="td_left" >超链接</span></td>
			  <td width="20%" bgcolor="#FFFFFF">排序号</td>
			  <td width="15%" bgcolor="#FFFFFF">操作</td>
            </tr>
            <s:iterator value="#request.auctionBulletinList" var="auctionBulletinList">
		            <tr align="center">
							
		              	
					  	<td bgcolor="#FFFFFF"><s:property value="#auctionBulletinList.auctionName"/></td>
					  	<td bgcolor="#FFFFFF">
					  	<s:if test="#auctionBulletinList.auctionForm == 1">
					  	现场拍卖
					  	</s:if>
					  	<s:elseif test="#auctionBulletinList.auctionForm == 2">
					  	网络同步拍卖
					  	</s:elseif>
					  	</td>
					 
					 	<td bgcolor="#FFFFFF">
					 	<s:property value="#auctionBulletinList.connectionUrl"/>
						</td>
						<td bgcolor="#FFFFFF">
		              	<s:property value="#auctionBulletinList.sortFlag"/>
		              	</td>
					  	<td bgcolor="#FFFFFF" class="state">
					  	<a href="companyBulletin_edit?bulletinFlag=<s:property value="#auctionBulletinList.id"/>" >编辑</a>
				   		<a class="innerButton" href="javascript:void(0);" onclick="doBulletinDelete('<s:property value="#auctionBulletinList.id"/>');return false;">删除</a>
							   	
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
	function doBulletinDelete(str){
		if(confirm("是否删除该拍卖会公告！")){
			location.href="companyBulletin_delete?bulletinFlag="+str;
		}
	}
</script>
</body>
</html>
