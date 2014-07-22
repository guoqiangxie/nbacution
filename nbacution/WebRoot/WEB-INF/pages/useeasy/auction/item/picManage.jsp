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
<script type="text/javascript" src="useeasy/auction/js/item/picManage.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台</title>
</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		<div id="shx"></div>
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
		  	<div class="l">拍品图片管理</div>
		  	<div class="r">
		  		<s:if test="#request.itemPicInfoList.size() < 6">
	  				<a style="color:blue; font-weight:bold;" onclick="doUploadItemPic('<s:property value="#request.itemFlag"/>')" href="###">【上传图片】</a> 
	  			</s:if>
	  			<s:if test="#request.itemPicInfoList.size() > 0">
	  				<a style="color:blue; font-weight:bold;" onclick="doDeleteItemPic('<s:property value="#request.itemFlag"/>')" href="###">【删除图片】</a> 
	  			</s:if>
	  			<a style="color:blue; font-weight:bold;"  href="itemManage_index?auctionFlag=<s:property value="#request.auctionFlag"/>">【返回】</a> 
  			</div>
		  </div>
		  <form action="" method="post">
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">
			  <td width="10" align="center" bgcolor="#FFFFFF">
			  <input type="checkbox" class="checkall"/>
			  </td>
              <td width="40%" bgcolor="#FFFFFF">图片序号</td>
              <td width="60%" align="center" bgcolor="#FFFFFF">图片</td>
			  
            </tr>
            	
            	<s:iterator value="#request.itemPicInfoList" var="iPicInfo_list" status="status">
            		<!--<s:property value="#status.index+1"/>-->
            	
			            <tr align="center" id="">
		
						  <td bgcolor="#FFFFFF" >
						  	<input class="groupclass" name="group" type="checkbox" value="<s:property value="#iPicInfo_list.id"/>"/>
						  </td>
						  <td bgcolor="#FFFFFF">
						  	<s:property value="#status.index+1"/>
						  </td>
			              
						  <td bgcolor="#FFFFFF">
							  <img src="<%=request.getContextPath()%><s:property value="#iPicInfo_list.uploadUrl"/>" height="90" width="120"/>
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
		<jsp:include page="../main/footer.jsp" flush="true"/>
	 	<!--footer-->
	</div>
<script language="javascript" type="text/javascript">
	function doUploadItemPic(str){
		var url = "itemManage_uploadPic?itemFlag=" + str;
		var sRet = window.showModalDialog(url,"","dialogHeight:500px;dialogWidth:800px");
		if(sRet == "refresh"){   
			location.href='itemManage_picManage?itemFlag=<s:property value="#request.itemFlag"/>';   
		} 
	}
	  

</script>
</body>
</html>
