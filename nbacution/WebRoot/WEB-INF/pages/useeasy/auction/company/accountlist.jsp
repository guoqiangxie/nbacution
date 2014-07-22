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
    function caccountlist(){
       $("#content").html("信息正在加载中...");
       $.post("adminManage_accountList",null,function(date){
          $("#content").html(date);
       });
     }
    
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
          $("#stu"+eid).html(date);
       });
     }
     
     function reloadAccount(eid){
        $("#stu"+eid).html("正在处理");
        $.post("adminManage_reloadAccount?eid="+eid,null,function(date){
          $("#stu"+eid).html(date);
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
<s:if test="#request.addaflag == 1">
    <script>
        alert("帐号添加成功");
        
        caccountlist();
    </script>

</s:if>
 
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
  				  拍卖公司账户注册   <a style="color:blue; font-weight:bold;" href="adminManage_jaccountList">【网络帐号列表】</a> 
  				 
				 <a style="color:blue; font-weight:bold;" href="adminManage_findListUI">【网络帐号查询】</a>  
	  			<div class="r">
	  			
	  			 
	  			<!--<a    href="auctionManage_add" align="center">【拍卖提起】</a>--> 
	  			</div>
	  			</div> 
   <table>
     <tr>
        <td>帐号检索<input type="text"   size="100" id="accountNameSearch"/></td>
         <td><input type="button" value="查询" onclick="caccountlistsearch(2)"/> </td>
     </tr>
   
   </table>

 
 
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
    <tr><td bgcolor="#f5f6e5" align="center">序列</td>
        <td bgcolor="#f5f6e5" align="center">帐号</td>
        <td bgcolor="#f5f6e5" align="center">创建时间</td>
        <td bgcolor="#f5f6e5" align="center">帐号类型</td>
        <td bgcolor="#f5f6e5" align="center">状态</td>
        <td bgcolor="#f5f6e5" align="center">公司名称</td>
       
        <td bgcolor="#f5f6e5"  align="center">操作</td>
    </tr>
    <s:iterator value="#request.accountlist" var="list" status="flag">
      <tr>
         <td bgcolor="#FFFFFF" align="center"><s:property value="#flag.index+1"/> </td>
         <td bgcolor="#FFFFFF" align="center"><s:property value="#list.accountName"/></td>
         <td bgcolor="#FFFFFF" align="center"><s:date name="#list.createTime" format="yyyy-MM-dd"/>  </td>
          <td bgcolor="#FFFFFF" align="center">
                              会员公司 
         </td>
         <td bgcolor="#FFFFFF" align="center" id="stu<s:property value="#list.id"/>"> 
           <s:if test="#list.deleteFlag==0">正常</s:if> 
           <s:if test="#list.deleteFlag==1">已锁定</s:if> 
         </td>
         <td bgcolor="#FFFFFF" align="center">
            
          <s:select disabled="true"  theme="simple"   list="#request.clist" listKey="id" listValue="companyName.substring(0,5)" value="#list.accountRelationId"/>
         </td>
          <td bgcolor="#FFFFFF" align="center">
             <a href="javascript:lockaccount(<s:property value="#list.id"/>)">禁用帐号</a><br/>
             <a href="javascript:reloadAccount(<s:property value="#list.id"/>)">激活账号</a><br/>
             <a href="javascript:updateAccount(<s:property value="#list.id"/>)">默认密码</a><br/>
             <a href="adminManage_editPrilige?uid=<s:property value="#list.id"/>">权限分配</a><br/>
           
          </td>
      </tr>
    
       
    </s:iterator>
 </table>
  <pmh:pageTag pageSize="${requestScope.pageSize}" gotoURI="adminManage_accountList" ></pmh:pageTag> 
              	 </div>
				 </div>
				 </div>
				 
</center>	
</body>
</html>
 