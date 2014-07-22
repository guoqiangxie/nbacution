<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'pmhRegister.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="/DataPicker4.0/My97DatePicker/WdatePicker.js" language="javascript"></script>
  </head>
  
  <body>
    <center>
                                                  欢迎使用拍卖软件请填写注册信息
                 <form action="">
                    <table>
                        <tr><td>公司名称</td><td><input type="text"/></td></tr>
                         <tr><td>注册码</td><td><input type="text"/></td></tr>
                            <tr><td>购买时间</td><td><input type="text" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d %H:%m'})"/></td></tr>
                               <tr><td>合同期限</td><td><input type="text" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d %H:%m'})"/></td></tr>
                             <tr><td colspan=2><input type="submit" value="注册" /></td></tr>
                         
                    
                    </table>
                 
                 </form>                                      
    
    </center>
  </body>
</html>
