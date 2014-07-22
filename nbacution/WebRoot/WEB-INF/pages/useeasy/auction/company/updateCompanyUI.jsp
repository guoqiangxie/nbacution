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
<title>网络拍卖信息系统</title>
<script type="text/javascript">
window.onload = function(){	
	var oFCKeditor1 = new FCKeditor( 'auctionCompany.companyIntro' ) ;
	oFCKeditor1.BasePath	="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor1.ToolbarSet = "Custom";
	oFCKeditor1.Height = 400;
	oFCKeditor1.ReplaceTextarea() ;

	var oFCKeditor2 = new FCKeditor( 'auctionCompany.companyConnection' ) ;
	oFCKeditor2.BasePath ="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor2.ToolbarSet = "Custom";
	oFCKeditor2.Height = 400;
	oFCKeditor2.ReplaceTextarea() ;
};
</script>
  <script>
 function doSubmit(){
 
	var companyName = $("#companyName").val();
	var companyName_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,50}$");
	if(!companyName_pattern.test(companyName)){
		$("#companyName").focus();
		alert("公司名称为中文！");
		return;
	}
	var companyAddress = $("#companyAddress").val();
	var companyAddress_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”【】《》（）—/]{1,100}$");
	if(!companyAddress_pattern.test(companyAddress)){
		$("#companyAddress").focus();
		alert("公司地址为中文，数字，字母！");
		return;
	}
	var companyLinker = $("#companyLinker").val();
	var companyLinker_pattern = new RegExp("^[\u4e00-\u9fa5a-zA-Z]{1,20}$");
	if(!companyLinker_pattern.test(companyLinker)){
		$("#companyLinker").focus();
		alert("联系人为中文，字母！");
		return;
	}
	var companyPhone = $("#companyPhone").val();	
	var companyPhone_pattern = new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5-/ ]{1,30}$");
	if(!companyPhone_pattern.test(companyPhone)){
		$("#companyPhone").focus();
		alert("联系电话不正确！");
		return;
	}
	var companyTel = $("#companyTel").val();	
	var companyTel_pattern = new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5-/ ]{1,30}$");
	if(companyTel != null && companyTel != ""){
		if(!companyTel_pattern.test(companyTel)){
			$("#companyTel").focus();
			alert("联系手机不正确！"); 
			return;
		}
	}
	var companyPost = $("#companyPost").val();	
	var companyPost_pattern = new RegExp("^[0-9]{6,6}$");
	if(companyPost != null && companyPost != ""){
		if(!companyPost_pattern.test(companyPost)){
			$("#companyPost").focus();
			alert("公司邮编不正确！"); 
			return;
		}
	}
	var companyEmail = $("#companyEmail").val();	
	var companyEmail_pattern = new RegExp("^[a-zA-Z0-9_-]{1,30}[@][a-zA-Z0-9._-]{1,30}$");
	if(companyEmail != null && companyEmail != ""){
		if(!companyEmail_pattern.test(companyEmail)){
			$("#companyEmail").focus();
			alert("公司email不正确！"); 
			return;
		}
	}
	
	document.getElementById("updateCompanyform").action="adminManage_updateCompany";
	document.getElementById("updateCompanyform").submit();
	}
	</script>
</head>
<body>
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
  				<div class="l">拍卖公司编辑</div> 
	  			<div class="r">
	  			<!--<a style="color:blue; font-weight:bold;"  href="auctionManage_add" align="center">【拍卖提起】</a>--> 
	  			</div>
	  			</div> 
   			 	  
  			<form id="updateCompanyform"    name="" action="" method="post" enctype="multipart/form-data">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF">
               <input type="hidden" value="<s:property value="#request.auctionCompany.id"/>" name="cid"/>
              <span class="td_left"><font color="red">*</font>公司名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyName" id="companyName" maxlength="50" size="50" value="<s:property value="#request.auctionCompany.companyName"/>"/>
              	<span><font color="red">(请输入中文)</font></span>
              </td>
            </tr>
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>公司地址:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyAddress" id="companyAddress" maxlength="50" size="50" value="<s:property value="#request.auctionCompany.companyAddress"/>"/>
              	<span><font color="red">(请输入中文，数字，字母)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>联系人:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyLinker" id="companyLinker" maxlength="20" size="50" value="<s:property value="#request.auctionCompany.companyLinker"/>"/>
              	<span><font color="red">(请输入中文，字母)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>联系电话:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyPhone" id="companyPhone" maxlength="25" size="50" value="<s:property value="#request.auctionCompany.companyPhone"/>"/>
              	<br/><span><font color="red">(如:021-11111111或0511-1111111)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">联系手机:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyTel" id="companyTel" maxlength="11" size="50" value="<s:property value="#request.auctionCompany.companyTel"/>"/>
              	<span><font color="red">(如:13711111111)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">邮编:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyPost" id="companyPost" maxlength="50" size="50" value="<s:property value="#request.auctionCompany.companyPost"/>"/>
              	<span><font color="red">(如:200001)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">email:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="companyEmail" id="companyEmail" maxlength="50" size="50" value="<s:property value="#request.auctionCompany.companyEmail"/>"/>
              	<span><font color="red">(如:xxx@xxx.com)</font></span>
              </td>
            </tr>
            
             
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 公司简介:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="companyIntro" id="auctionCompany.companyIntro" rows="20" cols="180" style="width:100%;height:200px"><s:property value="#request.auctionCompany.companyIntro" escape="true"/></textarea>
              </td>
            </tr> 
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 联系我们:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="companyConnection" id="auctionCompany.companyConnection" rows="20" cols="180" style="width:100%;height:200px"><s:property value="#request.auctionCompany.companyConnection" escape="true"/></textarea>
              </td>
            </tr> 
            <tr>
            	<td align="center" colspan="2" bgcolor="#FFFFFF">
            		<input class="large_btn"  type="button" value="修 改 "   onclick="doSubmit()" />
				</td>
            </tr>
          	
          	</table>
          	</form>
	   	  
			<!--end right-->
		 </div>
		 </div>
		 </div>
		 
 <script language="javascript" type="text/javascript">
		function doChangePicArea(str){
			if(str == "-1"){
				$(".large_btn").show();
				alert("文件上传失败！");
			}else if(str == "-2"){
				$(".large_btn").show();
				alert("文件上传出现异常！");
			}else{
				$(".large_btn").show();
				$("#customPicVal").val(str.substring(str.indexOf(",")+1));
				$("#img_sp_fir").hide();
				$("#img_sp_sec").hide();
				$("#identityCardPic_Img").attr("src","<%=request.getContextPath()%>"+str.substring(0,str.indexOf(",")));
			}
		}
	</script>
</body>
</html>