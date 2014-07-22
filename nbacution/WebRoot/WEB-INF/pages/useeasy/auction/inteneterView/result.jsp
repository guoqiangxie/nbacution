<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@taglib uri="/struts-tags"  prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 
    
    <title>My JSP 'result.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <s:if test="#request.flag = 1">
     <script type="text/javascript">
       alert("请等待审核");
       location.href="auctionIndex_index?searchKind=1&searchType=1&currentPage=1";
     
 
    </script>
</s:if>  
  <s:elseif test="#request.flag = 0">
     <script type="text/javascript">
      alert("不得重复申请");
       location.href="auctionIndex_index?searchKind=1&searchType=1&currentPage=1";
      </script>
</s:elseif>  
  </body>
</html>
