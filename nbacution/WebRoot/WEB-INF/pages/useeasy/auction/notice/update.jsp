<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%>
 <title>宁波市在线同步拍卖交易平台</title>
  <head> 
   
  <link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
 
    <script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
  <script type="text/javascript" src="/DataPicker4.0/My97DatePicker/WdatePicker.js" language="javascript"></script> 
<script type="text/javascript"> 
window.onload = function(){	
	var oFCKeditor1 = new FCKeditor( 'notice.notice_content' ) ;
	oFCKeditor1.BasePath	="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor1.ToolbarSet = "Custom";
	oFCKeditor1.Height = 200;
	oFCKeditor1.Width = 600;
	oFCKeditor1.ReplaceTextarea() ;

	 
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
  				<div class="l">增加公告</div> 
	  			<div class="r">
	  			 
	  			</div>
	  			</div> 
	  			
	  
              
      <form action="noticeAction_update" method="post">
      <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
          <tr>
             <td bgcolor="#FFFFFF"  width="20%">公告标题</td>
             <td bgcolor="#FFFFFF" width="60%">
             <input type="hidden" name="notice.id" value="<s:property value='#request.update.id'/>"/>
              <input type="hidden" name="notice.uid" value="<s:property value='#request.update.uid'/>"/>
               <input type="hidden" name="notice.company" value="<s:property value='#request.update.company'/>"/>
             <input maxlength="50" size="50" type="text" id="title" name="notice.title" value="<s:property value='#request.update.title'/>"/></td>
              <td  style="color:red" bgcolor="#FFFFFF" width="20%">  <s:fielderror fieldName="notice.title"></s:fielderror></td>
          </tr>   
          <tr> 
             <td bgcolor="#FFFFFF">电话</td>
              <td bgcolor="#FFFFFF"><input  size="50" maxlength="20" type="text" id="phone" name="notice.phone" value="<s:property value='#request.update.phone'/>"/></td>
               <td style="color:red" bgcolor="#FFFFFF">  <s:fielderror fieldName="notice.phone"></s:fielderror></td>
           </tr>   
         <tr> 
             <td bgcolor="#FFFFFF">拍卖时间</td>
              <td bgcolor="#FFFFFF"><input  size="50" maxlength="30" value="<s:property value='#request.update.createtime'/>"   type="text" id="title" name="notice.createtime" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d %H:%m'})"/></td>
               <td style="color:red" bgcolor="#FFFFFF">  <s:fielderror fieldName="notice.createtime"></s:fielderror></td>
           </tr>  
           
          <tr>    
             <td bgcolor="#FFFFFF">拍卖会名称</td>
              <td bgcolor="#FFFFFF"><input  size="50" maxlength="100" value="<s:property value='#request.update.pmhName'/>" type="text" id="cpy" name="notice.pmhName"/></td>
                 <td style="color:red" bgcolor="#FFFFFF">  <s:fielderror fieldName="notice.pmhName"></s:fielderror></td>
           </tr>   
           <tr>    
             <td bgcolor="#FFFFFF" >公告类型</td>
               <td bgcolor="#FFFFFF">
                   <s:select theme="simple"    list="#{'1':'房地产','2':'艺术品','3':'民品','4':'机动车','5':'物资设备','6':'股权','7':'其他'}" listKey="key" listValue="value" value="#request.update.notice_type"></s:select>

               </td>
               <td style="color:red" bgcolor="#FFFFFF">  <s:fielderror fieldName="notice.notice_type"></s:fielderror></td>
           </tr>   
          <tr>    
             <td bgcolor="#FFFFFF">公告内容</td>
              <td bgcolor="#FFFFFF"><textarea name="notice.notice_content" cols="100" rows="100">
                 <s:property value='#request.update.notice_content'/>
              
              </textarea></td>
                  <td bgcolor="#FFFFFF"> <s:fielderror fieldName="notice.notice_content"></s:fielderror> </td>
          </tr>
    </table>
        <center><input type="submit"  value="修改"/></center>
    </form>
     	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
 
</body>
</html>


