<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />

  </head>
  
  <body>
   
    
    
    
    
       
    <center>
    <!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../../main/menu.jsp" flush="true"/>	
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
  				<div class="l">增加拍卖厅</div> 
	  			<div class="r">
	  			 <a style="color:blue; font-weight:bold;"  href="pmtingAction_getList" align="center">【返回拍卖厅列表】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			 
	   		
	   		 
          
          
       <form action="pmtingAction_add" method="post">
          <table   width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
         <tr>
            <td bgcolor="#FFFFFF" align="center">拍卖厅名称</td>
            <td bgcolor="#FFFFFF" align="center"><input type="text" name="pmt.pmtName"/></td>
         </tr>
         
          <tr>
            <td bgcolor="#FFFFFF" align="center">备注</td>
            <td bgcolor="#FFFFFF" align="center"><input type="text" name="pmt.notice"/></td>
         </tr>
       
      
       <tr><td colspan=2 bgcolor="#FFFFFF" align="center">时间段
           <s:iterator value="#request.userTime" var="u" status="flag">
           
             <input type="checkbox" name="ut.makeNew[<s:property value="#flag.index"/>].id" value="<s:property value="#u.id"/>"/> <s:property value="#u.useTime"/>
          </s:iterator>
        </td>
       </tr>
       <tr>
       <td colspan=2 bgcolor="#FFFFFF" align="center">
       <input type="submit" value="保存"/>
       </td>
       </tr>
        </table>
    </form>  
          
          
          
          <!-- 分页 -->
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../../main/footer.jsp" flush="true"/>
	</div>
    
    </center> 
  </body>
</html>
