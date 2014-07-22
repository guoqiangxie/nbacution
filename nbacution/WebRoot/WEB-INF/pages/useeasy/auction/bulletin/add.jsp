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
  				<div class="l">新建公告(带<span style="color:red">*</span>的为必填项)</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="companyBulletin_index?currentPage=1">【返回】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post" >
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会名称</td>
              <td bgcolor="#ffffff" id="pcnameerr">
              <input type="text" id="auctionName" name="auctionBulletin.auctionName" size="50" maxlength="50"/>
              </td>
            </tr>
            
			<tr>
              <td width="180" align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会形式</td>
              <td bgcolor="#ffffff">
              	<select id="auctionForm" name="auctionBulletin.auctionForm">
              				<option value="0" selected="selected">请选择</option>
							<option value="1">现场拍卖</option>
							<option value="2">网络同步拍卖</option>
				</select>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>排序号</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="sortFlag" name="auctionBulletin.sortFlag"  size="50" maxlength="20"/>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>超链接路径</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="connectionUrl" name="auctionBulletin.connectionUrl"  size="50" maxlength="100"/>
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
	var auctionName = $("#auctionName").val();
	var auctionName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：【】《》（）—/]{1,50}$");
	if(!auctionName_pattern.test(auctionName)){
		$("#auctionName").focus();
		alert("拍卖会名称为中文，数字，字母，符号，。、：【】《》（）—/可使用！");
		return;
	}
	if($("#auctionForm").val() == 0){
		$("#auctionForm").focus();
		alert("请选择拍卖会形式！");
		return;
	}
	var sortFlag = $("#sortFlag").val();
	var sortFlag_pattern = new RegExp("^[0-9]{1,20}$");
	if(!sortFlag_pattern.test(sortFlag)){
		$("#sortFlag").focus();
		alert("排序号为数字！");
		return;
	}
	var connectionUrl = $("#connectionUrl").val();
	var connectionUrl_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9:/.?_&-=%]{1,100}$");
	if(!connectionUrl_pattern.test(connectionUrl)){
		$("#connectionUrl").focus();
		alert("超链接为中文，数字，字母，符号/:.?_&-=%可使用！");
		return;
	}
	
	if(confirm("是否提交该拍卖会公告")){
		document.forms[0].target = "_self";
	 	document.forms[0].action="companyBulletin_save";
		document.forms[0].submit();
	}
}
	
	
	
</script>
</body>
</html>
