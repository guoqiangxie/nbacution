<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 
  <script type="text/javascript" src="/notice/js/jquery.js"></script> 
 
  </head>
  
  <body> 
  <center>
  
    <s:action name="noticeAction_getindextop" executeResult="true"   >
       </s:action> 
       <table width="100%" class="infoList" > 
       <tr>
       <td>拍卖时间</td>
       <td>拍卖公司</td>
       <td>拍卖会</td>
       <td>拍卖电话</td>
       </tr>
       <s:iterator value="#request.list" var="list">
       <tr>
          <td><s:date name="#list.createtime" format="yyyy-MM-dd"/> </td>
          <td title="<s:property value='#list.company'/>">
           <s:if test="#list.company.length()>30"> <s:property value='#list.company.substring(0,30)'/>...</s:if>
           <s:else> <s:property value='#list.company'/></s:else>
         
          </td>
          <td>
          <s:if test="#list.pmhName.length()>20"> <a    title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/>&TB_iframe=true&height=550&width=700""> <s:property value='#list.pmhName.substring(0,20)'/> </a>...</s:if>
          <s:else>
            <a   title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/>&TB_iframe=true&height=550&width=700""> <s:property value='#list.pmhName'/> </a>
          </s:else>
         
         </td>
          <td title=" <s:property value='#list.phone'/>">
             <s:if test="#list.phone.length()>20"> <s:property value='#list.phone.substring(0,20)'/></s:if>
             <s:else> <s:property value='#list.phone'/></s:else>
            
           
           </td>
      </tr>
    
       </s:iterator>
    </table>
   
    </center>
  </body>
</html>
