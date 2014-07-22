<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%
	String perMaxSize = "1536";//单个文件允许的max大小
	String sizeUnit = "K";//perMaxSize数据对应的单位
	String ext = "*.jpg;*.jpeg";//允许上传的文件类型
	StringBuffer uploadUrl = new StringBuffer("http://");
	uploadUrl.append(request.getHeader("Host"));
	uploadUrl.append(request.getContextPath());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="smartUpload/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="smartUpload/js/swfupload.js"></script>
<script type="text/javascript" src="smartUpload/js/swfupload.swfobject.js"></script>
<script type="text/javascript" src="smartUpload/js/swfupload.queue.js"></script>
<script type="text/javascript" src="smartUpload/js/fileprogress.js"></script>
<script type="text/javascript" src="smartUpload/js/handlers.js"></script>

<title>宁波市在线同步拍卖交易平台<%=uploadUrl%></title>

<script type="text/javascript">

//var auctionFlag_var = '<s:property value="#request.auctionFlag"/>';
var itemFlag_var = '<s:property value="#request.itemFlag"/>';

var swfu;

SWFUpload.onload = function () {
	var settings = {
		flash_url : "smartUpload/js/swfupload.swf",
		upload_url: "<%=uploadUrl%>/uploadBatchImage.do?itemFlag=" + itemFlag_var,
		post_params: {},
		file_size_limit : <%=perMaxSize%>,
		file_types : "<%=ext%>",
		file_types_description : "<%=ext%>",
		file_upload_limit : 5,
		file_queue_limit : 0,
		custom_settings : {
			progressTarget : "fsUploadProgress",
			cancelButtonId : "btnCancel",
			uploadButtonId : "btnUpload",
			myFileListTarget : "idFileList"
		},
		debug: false,
		auto_upload:false,

		// Button Settings
		button_image_url : "smartUpload/images/XPButtonUploadText_61x22.png",	// Relative to the SWF file
		button_placeholder_id : "spanButtonPlaceholder",
		button_width: 61,
		button_height: 22,

		// The event handler functions are defined in handlers.js
		swfupload_loaded_handler : swfUploadLoaded,
		file_queued_handler : fileQueued,
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
		upload_start_handler : uploadStart,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_success_handler : uploadSuccess,
		upload_complete_handler : uploadComplete,
		queue_complete_handler : queueComplete,	// Queue plugin event
		
		// SWFObject settings
		minimum_flash_version : "9.0.28",
		swfupload_pre_load_handler : swfUploadPreLoad,
		swfupload_load_failed_handler : swfUploadLoadFailed
	};

	swfu = new SWFUpload(settings);
}
function doClosed(){   
	window.returnValue = "refresh";   
	window.close();   
} 

</script>

</head>
<body bgcolor="#FCFCFC" topmargin="0px" leftmargin="10px" rightmargin="10px" scroll="yes" onunload="doClosed();">
		<table width="100%" cellspacing="4" cellpadding="4" border="0"
			bgcolor="#FCFCFC">
			<tr>
				<td class="DH1">
					<table width="100%" cellspacing="4" cellpadding="4" border="0"
						bgcolor="#FCFCFC">
						<tr>
							<td class="DH2">
								<STRONG>批量上传相片 （支持的相片类型：<%=ext%>；单个相片最大不能超过：<%=perMaxSize%>
									<%=sizeUnit%>）</STRONG>
							</td>
							<td class="DH2" align="right"></td>
						</tr>
					</table>
					<div id="content">
						<form id="form1"
							action="publish/articleManage/UploadFileExampleSubmit.jsp"
							method="post" enctype="multipart/form-data">
							<table width="90%" cellspacing="0" cellpadding="0" border="0">
								<tr>
									<td>
										<span id="spanButtonPlaceholder"></span>
										<input id="btnUpload" type="button" value="上传相片" class="btn" />
										<input id="btnCancel" type="button" value="取消全部上传" disabled="disabled" class="btn" />
										<input id="btnClose" type="button" onclick="javascript:window.close(); " value="取消" class="btn" />
									</td>
								</tr>
							</table>
							<table id="idFileList" class="uploadFileList">
								<tr class="uploadTitle">
									<td>
										<B>文件名</B>
									</td>
									<td>
										<B>文件大小</B>
									</td>
									<td width=100px>
										<B>状态</B>
									</td>
									<td width=35px>
										&nbsp;
									</td>
								</tr>
							</table>
							等待上传
							<span id="idFileListCount">0</span> 个 ，成功上传
							<span id="idFileListSuccessUploadCount">0</span> 个
							<div id="divSWFUploadUI" style="visibility: hidden;"></div>
							<noscript
								style="display: block; margin: 10px 25px; padding: 10px 15px;">
								很抱歉，相片上传界面无法载入，请将浏览器设置成支持JavaScript。
							</noscript>
							<div id="divLoadingContent" class="content"
								style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
								相片上传界面正在载入，请稍后...
							</div>
							<div id="divLongLoading" class="content"
								style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
								相片上传界面载入失败，请确保浏览器已经开启对JavaScript的支持，并且已经安装可以工作的Flash插件版本。
							</div>
							<div id="divAlternateContent" class="content"
								style="background-color: #FFFF66; border-top: solid 4px #FF9966; border-bottom: solid 4px #FF9966; margin: 10px 25px; padding: 10px 15px; display: none;">
								很抱歉，相片上传界面无法载入，请安装或者升级您的Flash插件。 请访问：
								<a
									href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
									target="_blank">Adobe网站</a> 获取最新的Flash插件。
							</div>
						</form>
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>
