<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags"%>
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
<script type="text/javascript" src="useeasy/auction/js/company/passEdit.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台</title>
<script type="text/javascript"  language="javascript" src="fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
		<script type="text/javascript">
		
		window.onload = function(){	
	var oFCKeditor1 = new FCKeditor( 'AuctionVocationNews.vnewscontent' ) ;
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
				url:'auctionIndexVocationnews_upload',//用于文件上传的服务器端请求地址
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
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<div class="header">
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			<span class="topbtn">
			<a href="auctionSpecial_index">
			<img src="useeasy/auction/images/main/top_btn01.gif" border=0/></a>
			<a href="auctionInteration_index">
			<img src="useeasy/auction/images/main/top_btn02.gif" border=0/></a>
			</span> 
			</div>
			<!--end mainnav-->
		
			<div class="msg">
        	<%-- 滚动栏 --%>
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=4  />
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
  				<div class="l">添加行业动态信息</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  			
	  								  
  	<s:form action="auctionIndexVocationnews_add" method="post" name="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
     <tr><td  bgcolor="#FFFFFF">
         
       行业动态标题</td><td bgcolor="#FFFFFF"> <input type="text" name="auctionVocationNews.vnewstitle" maxlength="20"/><font color="red">*二十个字内 </font>
     
     </td></tr>
    
     <tr><td  bgcolor="#FFFFFF"><sx:head/>发布时间</td><td bgcolor="#FFFFFF"><sx:datetimepicker   name="auctionVocationNews.vnewsdate"  /></td></tr>
     <tr>
     <td bgcolor="#FFFFFF">图片路径</td>
     <td bgcolor="#FFFFFF">
           <table>
              <tr>
                    <td> <input type="text"  id="url1"  name="auctionVocationNews.vnewsimagepath"     /></td>
                    <td><input type="file" id="file" name="file"  size="10" /></td>
                    <td><input type="button" value="上传" onclick="return ajaxFileUpload();"/></td>
                    <td><img src="" id="gpwimg1" width="150px" height="150px" style="display:none"/></td>
              
              </tr>
           
           </table>
     
     </td>
   
     </tr>
      
     <tr><td bgcolor="#FFFFFF">发布人</td><td bgcolor="#FFFFFF"><input type="text" name="auctionVocationNews.vnewsperson" maxlength="10" /><font color="red">*十个字内 </font></td></tr>
      <tr><td bgcolor="#FFFFFF">动态内容 </td>
      <td bgcolor="#FFFFFF"><textarea  name="auctionVocationNews.vnewscontent"></textarea></td></tr>
     <tr><td bgcolor="#FFFFFF" colspan=2 align="center"> <input type="submit" value="新增" /></td></tr>
      </table>
   </s:form>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
</body>
</html>
