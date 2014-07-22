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
     function changeTing(id){
      $("#sqtidnum").attr('value','');
        $("#changeTing").show();
        $("#sqtidnum").attr('value',id);
        
        
       document.getElementById('mask').style.visibility='visible';document.getElementById('massage_box').style.visibility='visible'; 
        
        
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
  				<div class="l">拍卖厅申请结果列表 
  				 
  				
  				</div> 
	  			<div class="r">
	  			
	  			&nbsp;&nbsp;&nbsp;
	  			<a href="pmtsqAction_getList"> 进入申请列表</a>
	  			</div>
	  			</div> 
	  			 
	  			 
	  		  <div id="massage_box"><div class="massage">
					 <div class="header1" onmousedown="MDown(document.getElementById('massage_box'))"><div style="display:inline; width:150px; position:absolute">本站提示信息</div>
					  <span onclick="document.getElementById('massage_box').style.visibility='hidden'; mask.style.visibility='hidden'" style="float:right; display:inline; cursor:hand">×</span></div>
					 <input type="hidden" id="sqtidnum"/>
					  <jsp:include page="changeTingselect.jsp"></jsp:include>
					</div></div>
					<div id="mask"></div>	 
	  			  
	  			 
	  			 
	  			 
	  			 
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
              <tr>
                 <td bgcolor="#FFFFFF">序号</td>
                 <td bgcolor="#FFFFFF">使用时间</td>
                 <td bgcolor="#FFFFFF">拍卖会名称    </td>
                  <td bgcolor="#FFFFFF">拍卖类型    </td>
                 <td bgcolor="#FFFFFF">拍卖厅</td>
                 <td bgcolor="#FFFFFF">时间段   </td>
                <td bgcolor="#FFFFFF">状态   </td>
                <td bgcolor="#FFFFFF">备注   </td>
                  <td bgcolor="#FFFFFF">操作</td>
              </tr>
              <s:iterator value="#request.list" var="listsq" status="flag">
               <tr>
                 <td bgcolor="#FFFFFF"> 
                   <s:property value="#flag.index+1"/>
                </td>
                <td bgcolor="#FFFFFF">
                   <s:date name="#listsq.useDay" format="yyyy-MM-dd"/>
                </td>
               <td bgcolor="#FFFFFF">
                   <s:property value="#listsq.pmhName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                 
                 <s:if test="#listsq.pmType == 1">房地产</s:if>
                 <s:elseif test="#listsq.pmType == 2">机动车</s:elseif>
                 <s:elseif test="#listsq.pmType == 3">物质设备</s:elseif>  
                 <s:elseif test="#listsq.pmType == 4">股权</s:elseif>  
                 <s:elseif test="#listsq.pmType == 5">民品</s:elseif>  
                 <s:elseif test="#listsq.pmType == 6">文艺术品</s:elseif>  
                 <s:elseif test="#listsq.pmType == 7">其他</s:elseif>    
                </td>
                <td bgcolor="#FFFFFF">
                   <s:property value="#listsq.utName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                   <s:property value="#listsq.pmtName"/>
                </td>
                 <td bgcolor="#FFFFFF">
                   <s:property value="#listsq.stu"/>
                </td>
                 <td bgcolor="#FFFFFF"> 
                   <s:property value="#listsq.note"/>
                 
                 </td>
                 <td bgcolor="#FFFFFF">
                 <input type="button" value="换厅" onclick="changeTing(<s:property value='#listsq.id'/>)"/>
                 
                  <a href="pmtsqAction_delete?id=<s:property value="#listsq.id"/>">删除</a>
                    
                        
                </td>
                  </tr>
              </s:iterator>
             
              
            
          </table>
	    </div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
 
</body>
</html>
