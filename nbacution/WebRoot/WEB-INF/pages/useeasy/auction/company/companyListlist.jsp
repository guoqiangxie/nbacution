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
 
<title>网络拍卖信息系统</title>
</head>
<body>
 <s:if test="#request.flag ==1 ">
    <script>
       alert("操作成功!");
    </script>
  </s:if>
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
  				<div class="l">公司列表</div> 
	  			<div class="r"> 
	  			 <a style="color:blue; font-weight:bold;"  href="adminManage_addCompanyUI" align="center">【公司注册】</a> 
	  			</div>
	  			</div> 
	  			
     <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
           <tr><td bgcolor="#FFFFFF">序列</td>
               <td bgcolor="#FFFFFF">公司名名称</td>
               <td bgcolor="#FFFFFF">操作</td>
           </tr>
           <s:iterator value="#request.companyList" var="cp" status="flag">
              <tr> 
                 <td bgcolor="#FFFFFF"><s:property value="#flag.index+1"/> </td>
                 <td bgcolor="#FFFFFF"><s:property value="#cp.companyName"/>  </td>
                 <td bgcolor="#FFFFFF"><a href="adminManage_updateCompanyUI?cid=<s:property value="#cp.id"/>&width=500&height=500"   >编辑</a></td>
               </tr>
           </s:iterator>
      </table>
     </div>
     </div>
     </div>
</body>
</html>