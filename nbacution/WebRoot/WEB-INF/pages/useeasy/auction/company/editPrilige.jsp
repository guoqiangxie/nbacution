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
     
     function selectall1() { 
		var a = document.getElementsByTagName("input"); 
		if(a[0].checked==true){ 
		for (var i=0; i<a.length; i++) 
		if (a[i].type == "checkbox") a[i].checked = false; 
		} 
		else 
		{ 
		for (var i=0; i<a.length; i++) 
		if (a[i].type == "checkbox") a[i].checked = true; 
		} 
      } 
   function sall(obj){
       
      if(obj.checked){
         selectall1();
      }
   }
    function snall(obj){
      
      if(obj.checked){
         selectall1();
      }
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
  				  权限列表    
	  			 <a style="color:blue; font-weight:bold;" href="adminManage_accountList">【拍卖公司账户列表】</a> &nbsp;
	  			  
	  			 <a style="color:blue; font-weight:bold;" href="adminManage_jaccountList">【网络帐号列表】</a>  
				 <a style="color:blue; font-weight:bold;" href="adminManage_findListUI">【网络帐号查询】</a>  
	  			<div class="r">
	  			 	</div>
	  			</div> 
	  			   <p>当前帐号:<s:property value="#request.account.accountName"/></p>
	  			    <p>权限:
	  			        <input type="radio" name="all" id="all" onclick="sall(this)"/>取消全选  
	  			        <input type="radio" name="all" id="nall" onclick="snall(this)"/>全选 
	  			       </p>
	  			 <form action="adminManage_addprilige" method="post">  
	  			      <input type="hidden" name="uid" value="<s:property value="#request.account.id"/>"/>
	                  <s:iterator value="#request.priligelist" var="list" status="flag">
	                       <s:property value="#flag.index+1"/>
	                       <input  type="checkbox" name="privilage" value="<s:property value="#list.id"/>"
	                             <s:iterator value="#request.account.privilege" var="ulist">
	                                  <s:if test="#ulist.id == #list.id"> checked="checked" </s:if>
	                             </s:iterator>
	                          id="<s:property value="#list.id"/>"/>
	                       <label for="<s:property value="#list.id"/>"><s:property value="#list.privilageCName"/> </label><br/>
	                  </s:iterator>
	                  <input type="submit" value="保存"/>
                  </form> 
              	 </div>
				 </div>
				 </div>
				 
</center>	
</body>
</html>
 