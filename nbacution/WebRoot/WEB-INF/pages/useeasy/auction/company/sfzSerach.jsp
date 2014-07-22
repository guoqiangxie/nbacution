<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%>
<html>
<head>
<title>员工显示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
<title>网络拍卖信息系统</title>
 <script type="text/javascript">
 
    
   function caccountlistsearch(type){
      var search = $("#accountNameSearch").attr("value");
       if(search==""){
         alert("搜索内容不为空");
         return;
       }
       location.href="adminManage_getAccoutnSearch?type="+type+"&accountName="+search;
     }
     
     
     
     function lockaccount(eid){
        $("#stu"+eid).html("正在处理");
        $.post("adminManage_lockaccount?eid="+eid,null,function(date){
          alert(date);
       });
     }
     
     function reloadAccount(eid){
        $("#stu"+eid).html("正在处理");
        $.post("adminManage_reloadAccount?eid="+eid,null,function(date){
          alert(date);
       });
     } 
     
     function updateAccount(eid){
         
        $.post("adminManage_updateAccount?eid="+eid,null,function(date){
           alert(date);
       });
     
     }
     
    
</script>
</head>
<body>
 
 
 <center>
 
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
 				       竟买人账户检索列表  <a style="color:blue; font-weight:bold;" href="adminManage_accountList">【拍卖公司账户列表】</a> 
 				   <a style="color:blue; font-weight:bold;" href="adminManage_jaccountList">【网络帐号列表】</a> 
 				 
			 <a style="color:blue; font-weight:bold;" href="adminManage_findListUI">【网络帐号查询】</a>  
  			<div class="r">
  			 <!--<a    href="auctionManage_add" align="center">【拍卖提起】</a>--> 
   <form action="adminManage_findList" method="post">
   <table>
     <tr>
        <td>输入身份证号<input type="text"  name="sfzhm" size="70" id="accountNameSearch"/></td>
         <td><input type="submit" value="查询"  /></td>
     </tr>
    </table>
   </form>
   
  
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c"  >
      <tr>
         <td bgcolor="#f5f6e5" align="center">帐号</td>
         <td bgcolor="#f5f6e5" align="center">姓名</td>
         <td bgcolor="#f5f6e5" align="center">身份证</td>
                                   
         <td bgcolor="#f5f6e5" align="center">操作</td>  
         
      </tr>
      <tr>
        <s:if test="#request.account.size()>0">
        <td bgcolor="#f5f6e5" align="center"><s:property value="#request.account.get(0)[1]"/>  </td>
        <td bgcolor="#f5f6e5" align="center"><s:property value="#request.account.get(0)[2]"/>  </td>
        <td bgcolor="#f5f6e5" align="center"><s:property value="#request.account.get(0)[3]"/>  </td>
        <td bgcolor="#f5f6e5" align="center">
               <a href="javascript:lockaccount(<s:property value="#request.account.get(0)[0]"/>)">禁用帐号</a><br/>
               <a href="javascript:reloadAccount(<s:property value="#request.account.get(0)[0]"/>)">激活账号</a><br/>
               <a href="javascript:updateAccount(<s:property value="#request.account.get(0)[0]"/>)">默认密码</a>
        </td>
        </s:if>
        <s:else>
           <td bgcolor="#f5f6e5" colspan=4>不存在</td>
        </s:else>
      </tr>
  </table>
     </div>
	 </div>
	 </div>
</center>	
</body>
</html>
 