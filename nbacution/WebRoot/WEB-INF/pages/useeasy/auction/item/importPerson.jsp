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
			<ul>
				<li><a href="auctionManage_index?currentPage=1" class="current">拍卖会管理</a></li>
				<li><a href="companyPayment_index?currentPage=1">收支明细</a></li>
				<li><a href="companyManage_edit">拍卖公司注册信息</a></li>
				<!--<li><a onclick="companyMessageAction();" href="#">留言管理</a></li>-->
				<li><a href="companyBulletin_index?currentPage=1">拍卖公告管理</a></li>
				<li><a href="auctionManage_fileResource">相关资料</a></li>
				<li><a href="companyManage_passEdit" >密码修改</a></li>
				<li><a href="auctionLogin_frameLogout">退出登录</a></li>
			</ul>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right">
    	<form name="" action="" method="post" enctype="multipart/form-data" >
	      <div class="tit">
		  	<div class="l">导入人员</div>
		  	<div class="r">	
		  		<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
  			</div>
		  </div>
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
		    <tr align="left">
              <td bgcolor="#FFFFFF"><input type="file" name="u_file" id="u_file" size="35" /><br/>(请选择需要导入的EXECL模板)</td>
            </tr>
			<tr>
				<td align="left" colspan="9"  bgcolor="#FFFFFF">
					<span id="button_span">
					<input class=large_btn style="MARGIN-LEFT: 50px;center" type=button value="导入 "  onclick="doUpload();"/>
					</span>
					<span id="mess_span" style="display:none">
					<font color="red">文件处理中，请稍候。。。</font>
					</span>
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
<input type="hidden" id="error_mess" value="<s:property value="#request.error_mess"/>"/>
<s:if test="#request.excelFlag == 1">
<script language="javascript" type="text/javascript">
	alert("文件导入失败，请确认文件及内容！");
	//location.href = 'itemManage_importItems?auctionFlag=<s:property value="#request.auctionFlag"/>';
</script>
</s:if>
<s:elseif test="#request.excelFlag == 2">
	<script language="javascript" type="text/javascript">
	alert($("#error_mess").val());
	//location.href = 'itemManage_importItems?auctionFlag=<s:property value="#request.auctionFlag"/>';	
	</script>
</s:elseif>
<s:elseif test="#request.excelFlag == 3">
	<script language="javascript" type="text/javascript">
	alert($("#error_mess").val());
	//location.href = 'itemManage_index?auctionFlag=<s:property value="#request.auctionFlag"/>';	
	</script>
</s:elseif>

<script language="javascript" type="text/javascript">
	
function doUpload(){
	if($("#u_file").val() == ""){
		$("#u_file").focus();
		alert("请上传excel文件！");
		return;
	}
	var file_name = $("#u_file").val();
	if(file_name.substr(file_name.lastIndexOf(".")+1) == "xls"){
		$("#button_span").hide();
		$("#mess_span").show();
		document.forms[0].action='uploadExcel.do?auctionFlag=<s:property value="#request.auctionFlag"/>&PersonFlag=1';
		document.forms[0].submit();
	}else{
		$("#u_file").focus();
		alert("文件类型为excel！");
		return;
	}
	
}
</script>
</body>
</html>
