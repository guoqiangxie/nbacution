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
  				<div class="l">申请审核</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="companyAudit_index?auctionFlag=<s:property value="#request.auctionFlag"/>">【返回】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post" enctype="multipart/form-data">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		
            <tr>
              <td width="20%" align="right" bgcolor="#FFFFFF">账号名称</td>
              <td width="80%" bgcolor="#FFFFFF" colspan="3">
              <s:property value="#request.accountName"/>
              </td>
            </tr>
            <tr>
              <td  align="right" bgcolor="#FFFFFF">用户名称</td>
              <td bgcolor="#FFFFFF" colspan="3">
              <s:property value="auctionGuest.guestName"/>
              </td>
            </tr>
            <tr>
              <td  align="right" bgcolor="#FFFFFF">用户身份证</td>
              <td bgcolor="#FFFFFF" colspan="3">
              <s:property value="auctionGuest.guestIdentityCard"/>
              </td>
            </tr>
            <tr>
              <td  align="right" bgcolor="#FFFFFF">email</td>
              <td bgcolor="#FFFFFF" colspan="3">
              <s:property value="auctionGuest.guestEmail"/>
              </td>
            </tr>
            <tr>
              <td  align="right" bgcolor="#FFFFFF">电话</td>
              <td bgcolor="#FFFFFF" colspan="3">
              <s:property value="auctionGuest.guestTel"/>
              </td>
            </tr>
			<tr>
              <td  align="right" bgcolor="#FFFFFF">手机</td>
              <td bgcolor="#FFFFFF" colspan="3">
              <s:property value="auctionGuest.guestPhone"/>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">身份证影像:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:if test="#request.imgUrl == null || #request.imgUrl == ''">
              		<input type="hidden" id="img_key" value="0"/>
           			<img id="identityCardPic_Img" src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="300" width="400"/>
              	</s:if>
             	<s:else>
             		<input type="hidden" id="img_key" value="1"/>
					<img id="identityCardPic_Img" src="<%=request.getContextPath()%><s:property value="#request.imgUrl"/>" height="300" width="400"/>
				</s:else>
				<input type="file" id="u_file" name="identityCardPic" />
				<input type=button value="上传 "  onclick="doUpload();"/>
				
				<input type="hidden" id="customPicVal" name="customPicVal"/>
				<iframe id="uploadTarget" name="uploadTarget" style="display:none"></iframe>
              </td>
              
            </tr>
            
            
            <tr>
              <td align="center" bgcolor="#FFFFFF" colspan="4">
				<input class="large_btn"  type="button" value="提交 " onclick="doSubmit('<s:property value="#request.applyFlag"/>');" />
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
	function doSubmit(str){
		if($("#img_key").val() != 1){
			$("#u_file").focus();
			alert("请上传自定义图标！");
			return;
		}
		if(confirm("是否通过该申请！")){
			document.forms[0].encoding = "application/x-www-form-urlencoded";
			document.forms[0].target = "_self";
			document.forms[0].action = "companyAudit_doCheck?applyFlag="+str;
			document.forms[0].submit();
		}
	}
	function doUpload(){
		
		if($("#u_file").val() == ""){
			$("#u_file").focus();
			alert("请上传自定义图标！");
			return;
		}
		var file_name = $("#u_file").val();
		if(file_name.substr(file_name.indexOf(".")+1) == "jpg" || file_name.substr(file_name.indexOf(".")+1) == "png"
			|| file_name.substr(file_name.indexOf(".")+1) == "jpeg"|| file_name.substr(file_name.indexOf(".")+1) == "JPG"
			|| file_name.substr(file_name.indexOf(".")+1) == "JPEG"|| file_name.substr(file_name.indexOf(".")+1) == "PNG"){
			$(".large_btn").hide();
			document.forms[0].target = "uploadTarget";
			document.forms[0].action="uploadImage.do?uploadType=3";
			document.forms[0].submit();
		}else{
			$("#u_file").focus();
			alert("文件类型为jpg,jpeg,png,JPG,JPEG,PNG！");
			return;
		}
		
	}
	
	function doChangePicArea(str){
		if(str == "-1"){
			$(".large_btn").show();
			alert("文件上传失败！");
		}else if(str == "-2"){
			$(".large_btn").show();
			alert("文件上传出现异常！");
		}else{
			$(".large_btn").show();
			$("#img_key").val("1");
			$("#customPicVal").val(str.substring(str.indexOf(",")+1));
			$("#identityCardPic_Img").attr("src","<%=request.getContextPath()%>"+str.substring(0,str.indexOf(",")));
		}
	}

</script>


</body>
</html>
