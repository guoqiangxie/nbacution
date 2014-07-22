<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%>
<%@taglib uri="calendar" prefix="calendar" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
 
 <style type="text/css">
#massage_box{ position:absolute; left:expression((body.clientWidth-350)/2); top:expression((body.clientHeight-200)/2); width:350px; height:200px; z-index:2; visibility:hidden}
#mask{ position:absolute; top:0; left:0; width:expression(body.scrollWidth); height:expression(body.scrollHeight); background:#666;   z-index:1; visibility:hidden}
.massage{border:#ebf4ff solid; border-width:1131; width:95%; height:95%; background:#fff;     line-height:150%}
.header1{background:#ebf4ff; height:10%; padding:3505; color:#000}
</style>
<!--实现层移动-->
<script language="javascript">
var Obj=''
document.onmouseup=MUp
document.onmousemove=MMove

function MDown(Object){
Obj=Object.id
document.all(Obj).setCapture()
pX=event.x-document.all(Obj).style.pixelLeft;
pY=event.y-document.all(Obj).style.pixelTop;
}

function MMove(){
if(Obj!=''){
  document.all(Obj).style.left=event.x-pX;
  document.all(Obj).style.top=event.y-pY;
  }
}

function MUp(){
if(Obj!=''){
  document.all(Obj).releaseCapture();
  Obj='';
  }
}
</script>
 
 
<title>宁波市在线同步拍卖交易平台</title>
 <script >
    //pmtsqAction_updateUI?id=
   function info(id,pmhid){
    if(pmhid !=""){
      $.post("pmtsqAction_pmh?id="+pmhid,null,function(date){
     
           if(date =="0"){
            
             location.href="pmtsqAction_updateUI?id="+id;
           } if(date =="1"){
             location.href="pmtsqAction_getOnlyReady?id="+id; 
             
           } if(date =="2"){
             location.href="pmtsqAction_getOnlyReady?id="+id; 
           } if(date == "fail"){
              if(confirm("该拍卖会已被删除,是否确认修改信息")){
               location.href="pmtsqAction_updateUI?id="+id;
              }
           }
     
     
     });
     }else{
        location.href="pmtsqAction_updateUI?id="+id;
     } 
     
   }
   
   //特殊处理 stu note
   function helpcenter(id,pmhid,stu){
     
    
    if(pmhid !=""){
      $.post("pmtsqAction_pmh?id="+pmhid,null,function(date){
     
           if(date =="0"){
             
             $.post("pmtsqAction_helpcenter?id="+id+"&stu="+stu+"&note="+$("#note").attr('value'),null,function(date){
                if(date  = "success"){
                  alert("操作成功");
                  location.href="pmtsqAction_companysqGetList";
                }
               
             
             });
             
             
           } if(date =="1"){
             
             alert("正在进行中");
             
           } if(date =="2"){
              alert("已结束");
           } 
     
     
     });
      
     
   }else{
      
   }  
   }
   
 </script>
</head>
<body>
 

 

<!--container-->
	<div class="container"  >
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
  				<div class="l">拍卖厅申请结果列表 </div> 
	  			<div class="r">
	  			  <s:if test="#session._listener.auctionAccount.accountType ==1 ">
	  			      <a href="pmtsqAction_teshusq">拍卖公司申请厅特殊处理</a> 
	  			
	  			</s:if>
	  			&nbsp;&nbsp;&nbsp;
	  			<a href="pmtsqAction_getList"> 进入申请列表</a>
	  			</div>
	  			</div> 
	  			 
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
              <tr>
                 <td bgcolor="#FFFFFF">序号</td>
                 <td bgcolor="#FFFFFF">使用时间</td>
                 <td bgcolor="#FFFFFF">拍卖会名称    </td>
                  <td bgcolor="#FFFFFF">拍卖类型    </td>
                 <td bgcolor="#FFFFFF">拍卖厅</td>
                 <td bgcolor="#FFFFFF">时间段   </td>
                 <td bgcolor="#FFFFFF">状态 </td>
                  <td bgcolor="#FFFFFF">操作</td>
              </tr>
              <s:iterator value="#request.list" var="list" status="flag">
               <tr>
                <td bgcolor="#FFFFFF">
                   <s:property value="#flag.index+1"/>
                </td>
                <td bgcolor="#FFFFFF">
                   <s:date name="#list.useDay" format="yyyy-MM-dd"/>
                </td>
               <td bgcolor="#FFFFFF">
                   <s:property value="#list.pmhName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                 
                 <s:if test="#list.pmType == 1">房地产</s:if>
                 <s:elseif test="#list.pmType == 2">机动车</s:elseif>
                 <s:elseif test="#list.pmType == 3">物质设备</s:elseif>  
                 <s:elseif test="#list.pmType == 4">股权</s:elseif>  
                 <s:elseif test="#list.pmType == 5">民品</s:elseif>  
                 <s:elseif test="#list.pmType == 6">文艺术品</s:elseif>  
                 <s:elseif test="#list.pmType == 7">其他</s:elseif>    
                </td>
                <td bgcolor="#FFFFFF">
                   <s:property value="#list.pmtName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                   <s:property value="#list.utName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                   <s:if test="#list.stu ==0">内容不全</s:if>
                   <s:if test="#list.stu ==1">内容全</s:if>
                   <s:if test="#list.stu ==2">申请删除</s:if>
                   <s:if test="#list.stu ==3">申请换厅</s:if>
                </td>
                 <td bgcolor="#FFFFFF">
                   <s:if test="#list.stu ==0 "><a href="pmtsqAction_get?id=<s:property value="#list.id"/>"><img src="/useeasy/auction/images/bqzl.gif" style="border:none"/></a></s:if>
                   <s:else>
                     <a href="javascript:info('<s:property value="#list.id"/>','<s:property value="#list.pmhId"/>');">详情</a>
                      
                       <div id="massage_box"><div class="massage">
					 <div class="header1" onmousedown="MDown(document.getElementById('massage_box'))"><div style="display:inline; width:150px; position:absolute">本站提示信息</div>
					  <span onclick="document.getElementById('massage_box').style.visibility='hidden'; mask.style.visibility='hidden'" style="float:right; display:inline; cursor:hand">×</span></div>
					    <center>
							    <ul style="margin-right:25"><li>
							      <input type="radio" name="helpcenterr"  onclick="javascript:$('#stu1').show();$('#stu2').hide();" />删除   
							      <input type="radio" name="helpcenterr"   onclick="javascript:$('#stu1').hide();$('#stu2').show();"     /> 修改
							      </li>  
							        <li>附注信息
							  <textarea rows="5" cols="25" id="note"></textarea>
							
							</li>
							</ul>
					    <span id="stu1" style="display:none">
					      <input type="button" value="提交" onclick="helpcenter('<s:property value="#list.id"/>','<s:property value="#list.pmhId"/>','2')"/>
					    </span>
					    
					    <span id="stu2" style="display:none">
					      <input type="button" value="提交" onclick="helpcenter('<s:property value="#list.id"/>','<s:property value="#list.pmhId"/>','3')"/>
					      
					    </span>
					    			
					
					</center>
					</div></div>
					<div id="mask"></div>
				
					  <s:if test="#session._listener.auctionAccount.accountType ==2 ">
					    <s:if test="#list.stu ==0|#list.stu ==1">
	  			        	<span onclick="document.getElementById('mask').style.visibility='visible';document.getElementById('massage_box').style.visibility='visible';" style="cursor:hand">申请修改及删除</span>
	  			        </s:if>
	  			     </s:if>
					                       
					</s:else>
                </td>
                  </tr>
              </s:iterator>
              
            
          </table>
         <pmh:pageTag pageSize="${requestScope.pageSize}" gotoURI="pmtsqAction_companysqGetList"></pmh:pageTag>
	    </div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
 
</body>
</html>
