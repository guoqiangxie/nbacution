<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/window/showall.css" rel="stylesheet" type="text/css" />

<title>宁波市在线同步拍卖交易平台</title>

</head>
<body onload="gototop();" >
<div class="font">
 <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">			  
              <td width="10%" bgcolor="#FFFFFF">序号</td>
              <td width="25%" bgcolor="#FFFFFF">时间</td>     
              <td width="15%" bgcolor="#FFFFFF">显示编号</td>     
              <td width="50%" bgcolor="#FFFFFF">操作描述</td>   
            </tr>
            <s:iterator value="#request.aliveStatusList" var="aliveStatus_list" status="status">
            	<tr>
					<td bgcolor="#FFFFFF"><s:property value="#status.index+1"/></td>
					<td bgcolor="#FFFFFF"><s:date name="#aliveStatus_list[1]" format="yyyy-MM-dd HH:mm"/></td>	
					<td bgcolor="#FFFFFF"><s:property value="#aliveStatus_list[5]"/></td>			
					<td bgcolor="#FFFFFF"><s:property value="#aliveStatus_list[2]"/></td>
				</tr>
            
            </s:iterator>
            
		   
			</table>



</div>
<div  class="close"><a href="#" onclick="closeW();"></a></div>
<script language="javascript" type="text/javascript">
//返回页面顶端
function gototop(){
	scroll(0,0);
}
function closeW(){
	window.close();
}
</script>
</body>
</html>