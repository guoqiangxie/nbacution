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
<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
<title>宁波市在线同步拍卖交易平台</title>
<script type="text/javascript">
window.onload = function(){	
	var oFCKeditor1 = new FCKeditor( 'auctionGuide.guideContent' ) ;
	oFCKeditor1.BasePath	="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor1.ToolbarSet = "Custom";
	oFCKeditor1.Height = 400;
	oFCKeditor1.ReplaceTextarea() ;
};
</script>
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
  				<div class="l">拍卖指南</div>
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="adminManage_guideIndex?searchType=0" align="center">【返回】</a>
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>指南标题:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionGuide.guideTitle" id="guideTitle" maxlength="50" size="50" value="<s:property value="auctionGuide.guideTitle"/>"/>
              </td>
            </tr>
          	
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span style="color:red">*</span>指南类型</td>
              <td bgcolor="#ffffff">
              	<select id="guideType" name="auctionGuide.guideType">
              				<s:if test="auctionGuide.guideType == 1">
              					<option value="0">请选择</option>
								<option value="1" selected="selected">拍卖流程</option>
								<option value="2">疑问解答</option>
								<option value="3">操作规则</option>
								<option value="4">法律法规</option>
              				</s:if>
              				<s:elseif test="auctionGuide.guideType == 2">
              					<option value="0">请选择</option>
								<option value="1">拍卖流程</option>
								<option value="2" selected="selected">疑问解答</option>
								<option value="3">操作规则</option>
								<option value="4">法律法规</option>
              				</s:elseif>
              				<s:elseif test="auctionGuide.guideType == 3">
              					<option value="0">请选择</option>
								<option value="1">拍卖流程</option>
								<option value="2">疑问解答</option>
								<option value="3" selected="selected">操作规则</option>
								<option value="4">法律法规</option>
              				</s:elseif>
              				<s:elseif test="auctionGuide.guideType == 4">
              					<option value="0">请选择</option>
								<option value="1">拍卖流程</option>
								<option value="2">疑问解答</option>
								<option value="3">操作规则</option>
								<option value="4" selected="selected">法律法规</option>
              				</s:elseif>
				</select>
              </td>
            </tr>
          	
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 指南内容:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="auctionGuide.guideContent" rows="20" cols="180" style="width:100%;height:200px"><s:property value="auctionGuide.guideContent"/></textarea>
              </td>
            </tr> 
            
            <tr>
            	<td align="center" colspan="2">
            		<input class="large_btn"  type="button" value="修 改 "  onclick="doSubmit();" />
				</td>
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
	<script language="javascript" type="text/javascript">
		function doSubmit(){
			var guideTitle = $("#guideTitle").val();
			var guideTitle_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9:()、]{1,50}$");
			if(!guideTitle_pattern.test(guideTitle)){
				$("#guideTitle").focus();
				alert("指南标题为中文，数字，字母，:()、等符号！");
				return;
			}
			
			if($("#guideType").val() == 0){
				$("#guideType").focus();
				alert("请选择指南类型！");
				return;
			}
			if(confirm("是否提交该拍卖指南")){
				document.forms[0].target = "_self";
			 	document.forms[0].action="adminManage_guideModify";
				document.forms[0].submit();
			}
		}
	</script>
</body>
</html>
