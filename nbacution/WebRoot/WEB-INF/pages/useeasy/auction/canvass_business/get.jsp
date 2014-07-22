<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="/struts-dojo-tags" prefix="sx" %>
<head>
 <script type="text/javascript" src="/notice/js/jquery.droppable.js"></script> 
  <script type="text/javascript" src="/notice/js/jquery.js"></script> 
  <script type="text/javascript" src="/notice/js/thickbox.js"></script>
  <link href="useeasy/auction/css/main/main.css"	rel="stylesheet" type="text/css" />
  
 </head> 
 <body>
 <center>
 <sx:datetimepicker></sx:datetimepicker>
	<table class="infoList" class="droppable">
		<tr>
			<td align="center">
				<font color="red"><s:property value="#request.notice.title" /></font>
			</td>
		</tr>
		<tr>
			<td align="center">
				<s:property value="#request.notice.companyName" />
			</td>
		</tr>
		<tr>
			<td>
				<s:property value="#request.notice.content" escape="false" />
			</td>
		</tr>
	</table>
</center>
</body>