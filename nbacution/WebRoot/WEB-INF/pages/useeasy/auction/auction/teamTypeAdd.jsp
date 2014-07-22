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
  				<div class="l">拍卖组别(带<span style="color:red">*</span>的为必填项)</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_teamTypeIndex?auctionFlag=<s:property value="#request.auctionFlag"/>">【返回】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post" enctype="multipart/form-data" >
	   		
	   		<input type="hidden"  name="auctionFlag" value="<s:property value="#request.auctionFlag"/>"/>
            
            <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖组别</td>
              <td bgcolor="#ffffff" id="pcnameerr">
              <input type="text" id="teamType" name="auctionTeamType.teamType" size="50" maxlength="50"/>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF">说明</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="teamDescription" name="auctionTeamType.teamDescription" size="50" maxlength="50"/>
              </td>
            </tr>
			
			
            <tr>
              <td align="center" bgcolor="#FFFFFF" colspan="2">
				<input class="large_btn"  type="button" value="提交 " onclick="doSubmit();" />
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

	var teamType = $("#teamType").val();
	var teamType_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,50}$");
	if(!teamType_pattern.test(teamType)){
		$("#teamType").focus();
		alert("拍卖组别为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
		return;
	}
	
	var teamDescription = $("#teamDescription").val();
	var teamDescription_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/ \n]{1,100}$");
	if(teamDescription == ""){
	}else{
		if(!teamDescription_pattern.test(teamDescription)){
			$("#teamDescription").focus();
			alert("说明为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
			return;
		}
	}
	
	
	if(confirm("是否提交该拍卖组别")){
		document.forms[0].target = "_self";
	 	document.forms[0].action="auctionManage_saveTeamType";
		document.forms[0].submit();
	}
}
	
</script>
</body>
</html>
