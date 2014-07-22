<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title> </title>
    	  <link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>

	<script type="text/javascript" src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/ajaxfileupload.js"></script>
   <script type="text/javascript">
   
 
window.onload = function(){	
	var oFCKeditor1 = new FCKeditor( 'business.content' ) ;
	oFCKeditor1.BasePath	="<%=request.getContextPath()%>/fckeditor/";
	oFCKeditor1.ToolbarSet = "Custom";
	oFCKeditor1.Height = 400;
	oFCKeditor1.ReplaceTextarea() ;

 
};
 
   
   
	function ajaxFileUpload()
	{
		
		$("#loading")
		.ajaxStart(function(){
			$(this).show();
		})//开始上传文件时显示一个图片
		.ajaxComplete(function(){
			$(this).hide();
		});//文件上传完成将图片隐藏起来
		
		$.ajaxFileUpload
		(
			{
				url:'businessAction_upload',//用于文件上传的服务器端请求地址
				secureuri:false,//一般设置为false
				fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
				dataType: 'json',//返回值类型 一般设置为json
				success: function (data, status)  //服务器成功响应处理函数
				{ 
				         $("#url1").attr("value",data.name);
						   $("#gpwimg1").show();
						    document.getElementById("gpwimg1").src=data.name;
					//alert(data.message);//从服务器返回的json中取出message中的数据,其中message为在struts2中定义的成员变量
					
					if(typeof(data.error) != 'undefined')
					{
						if(data.error != '')
						{
							alert(data.msg);
						}else
						{
						  
							 alert(data.msg);
						}
					}
				},
				error: function (data, status, e)//服务器响应失败处理函数
				{
					alert(e);
				}
			}
		)
		
		return false;

	}
	
     
     
     </script>
  </head>
  
  <body>
     <center>
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
  				<div class="l">增加招商</div> 
	  			<div class="r">
	  			 
	  			</div>
	  			</div> 
	  			
	  
              
       <form action="businessAction_add" method="post">
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
          <tr>
             <td bgcolor="#FFFFFF">标题</td>
              <td bgcolor="#FFFFFF"><input size="70" type="text" name="business.title"/></td>
          </tr>
          
          
           <tr>
             <td bgcolor="#FFFFFF">标题图片 </td>
              <td bgcolor="#FFFFFF">
                     <table>
                        <tr>
                           <td> <input type="text" id="url1"  name="business.imgPath"  ></td>
                           <td>	<img src="/business_images/loading.gif" id="loading" style="display: none;"><input type="file" id="file" name="file"  size="10" /></td>
                            <td><input type="button" value="上传" onclick="return ajaxFileUpload();"></td>
                           <td>  <img src="" id="gpwimg1" width="150px" height="150px" style="display:none"/>  </td>
            
                         </tr>
                         <!-- comtate中设URIEncoding="UTF-8" -->
                      </table>  
              </td>
          </tr>
         <tr>
            <td bgcolor="#FFFFFF">正文</td>
             <td bgcolor="#FFFFFF"> 
             	<textarea  name="business.content"></textarea>
            </td>
         </tr>
          
      </table>
       <center><input type="submit" value="新增"/></center> 
     </form> 
      
 </div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
 </center>
  </body>
</html>
