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
<script type="text/javascript" src="useeasy/auction/js/company/edit.js" language="javascript"></script>
<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
<title>宁波市在线同步拍卖交易平台</title>
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
  				<div class="l">拍卖公司注册信息</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post" enctype="multipart/form-data">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>公司名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyName" id="companyName" maxlength="50" size="50" value="<s:property value="auctionCompany.companyName"/>"/>
              	<span><font color="red">(请输入中文)</font></span>
              </td>
            </tr>
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>公司地址:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyAddress" id="companyAddress" maxlength="50" size="50" value="<s:property value="auctionCompany.companyAddress"/>"/>
              	<span><font color="red">(请输入中文，数字，字母)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>联系人:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyLinker" id="companyLinker" maxlength="20" size="50" value="<s:property value="auctionCompany.companyLinker"/>"/>
              	<span><font color="red">(请输入中文，字母)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>联系电话:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyPhone" id="companyPhone" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPhone"/>"/>
              	<br/><span><font color="red">(如:0513-11111111或0513-1111111)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">联系手机:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyTel" id="companyTel" maxlength="50" size="50" value="<s:property value="auctionCompany.companyTel"/>"/>
              	<span><font color="red">(如:13711111111)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">邮编:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyPost" id="companyPost" maxlength="50" size="50" value="<s:property value="auctionCompany.companyPost"/>"/>
              	<span><font color="red">(如:200001)</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">email:</span></td>
              <td bgcolor="#FFFFFF">
              	<input type="text" name="auctionCompany.companyEmail" id="companyEmail" maxlength="50" size="50" value="<s:property value="auctionCompany.companyEmail"/>"/>
              	<span><font color="red">(如:xxx@xxx.com)</font></span>
              </td>
            </tr>
            
            <tr>
              <td bgcolor="#FFFFFF" style="text-align:center"> 公司LOGO:</td>
              <td bgcolor="#FFFFFF">
              	<input type="file" id="u_file" name="u_file"/>
              	<input type=button value="上传 "  onclick="doUpload();"/>
              	<br/><span><font color="red">(不大于2M, jpg | png | jpeg文件,上传的图片需提交保存！)</font></span>
              	<br/>
              	
              	<span id="img_sp_fir" style="display:none"><font color="red">文件名不能为空</font></span>
              	<span id="img_sp_sec" style="display:none"><font color="red">文件类型为jpg,jpeg,png</font></span>
              	
              	<span>
              	<s:if test="#request.imgUrl == null || #request.imgUrl == ''">
           			<img id="identityCardPic_Img" src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="120" width="160"/>
              	</s:if>
             	<s:else>
					<img id="identityCardPic_Img" src="<%=request.getContextPath()%><s:property value="#request.imgUrl"/>" height="160" width="200"/>
				</s:else>
              	<input type="hidden" id="customPicVal" name="customPicVal"/>
				<iframe id="uploadTarget" name="uploadTarget" style="display:none"></iframe>
								
              	</span>
              	
              </td>
            </tr>
            
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 公司简介:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="auctionCompany.companyIntro" rows="20" cols="180" style="width:100%;height:200px"><s:property value="auctionCompany.companyIntro"/></textarea>
              </td>
            </tr> 
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"> 联系我们:</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="auctionCompany.companyConnection" rows="20" cols="180" style="width:100%;height:200px"><s:property value="auctionCompany.companyConnection"/></textarea>
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
