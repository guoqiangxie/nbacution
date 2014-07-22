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
    function addAccountUI(){
        $("#content").html("信息正在加载中...");
       $.post("adminManage_addAccountUI",null,function(date){
          $("#content").html(date);
       });
    
    
    }
   function caccountlistsearch(type){
      var search = $("#accountNameSearch").attr("value");
       if(search==""){
         alert("搜索内容不为空");
         return;
       }
       $("#content").html("信息正在加载中...");
       $.post("adminManage_getAccoutnSearch?type="+type+"&accountName="+search,null,function(date){
          $("#content").html(date);
       });
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
     
     function jaccountList(){
         $("#content").html("信息正在加载中...");
       $.post("adminManage_jaccountList",null,function(date){
         
          $("#content").html(date);
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
  				  <a style="color:blue; font-weight:bold;" href="javascript:addAccountUI()">【拍卖公司账户注册】</a> &nbsp;
	  			 <a style="color:blue; font-weight:bold;" href="adminManage_accountList">【拍卖公司账户列表】</a> &nbsp;
	  			  
	  			 <a style="color:blue; font-weight:bold;" href="adminManage_jaccountList">【网络帐号列表】</a>  
				 <a style="color:blue; font-weight:bold;" href="adminManage_findListUI">【网络帐号查询】</a>  
	  			<div class="r">
	  			
	  			<!--<a    href="auctionManage_add" align="center">【拍卖提起】</a>--> 
	  			</div>
	  			</div> 
                  <div id="content"></div>
            	 </div>
				 </div>
				 </div>
				 
</center>	
</body>
</html>