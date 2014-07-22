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
<script type="text/javascript" src="DataPicker4.0/My97DatePicker/WdatePicker.js" language="javascript"></script>
<style>
#table2{margin-top:2px}
  #table2 td
{
 border:1px solid #999999;
 
}

</style>
<title>宁波市在线同步拍卖交易平台</title>
 <script >
 /* $(document).ready(function(){
  // 在这里写你的代码...
  $(".show").each(function(){ //取得所有class为editbox的对像
   
    $(this).bind("mouseover",function(e){ //给其绑定事件
    
      
       
     var toolTip ;  
     $.get("pmtsqAction_ajaxshowrili",null,function(date){
      
        toolTip =  "<div id='tooltip' width='200px' height='200px' style='position:absolute;border:solid #aaa 1px;background-color:#F9F9F9'>" + 
         
          $("a").attr("title")
        
          
         + "</div>"; 
        $("body").append(toolTip); 
         $("#tooltip").css({ 
         "top" :e.pageY + "px", 
         "left" :e.pageX + "px" 
        });
      });
       
        
     });
      $(this).bind("mouseout",function(){ //给其绑定事件
         
         $("#tooltip").remove(); 
         
      });
     $(this).bind("mousemove",function(){ //给其绑定事件
         
           $("#tooltip").css({ 
           "top" :(e.pageY+5) + "px", 
          "left" :(e.pageX+2) + "px" 
           }); 
          
         
     });
  
   });
  });
   */
   
 
     function rili(obj){
      if(obj == 0){
       $("#rili").hide();
      }else if(obj == 1){
        $("#rili").show();
      } 
       
    }
 
 </script>
</head>
<body>
<s:if test="#request.flag == 0">
<script>
  alert("申请失败，厅已被占用");
</script>
</s:if>

<s:if test="#request.flag == 1">
<script>
    if(!confirm("申请成功，如继续申请点确认，补全资料点取消")){
       location.href="pmtsqAction_get?id=<s:property value='#request.list1.id'/>";
    }else{
       location.href="pmtsqAction_getList?date=<s:property value='#request.day'/>"; 
    }
  
</script>
</s:if>

 

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
  				<div class="l">拍卖厅申请列表 </div> 
	  			<div class="r">
	  			 
	  			
	  			    &nbsp;&nbsp;
	  			   <input type="radio" name="rili"   onclick="rili(0)"  />隐藏日历
	  			   <input type="radio" name="rili"  checked="checked"  onclick="rili(1)"  />展开日历
	  			</div>
	  			</div> 
	  			<calendar:calendarTag/>
	    <table width="100%" border="1" cellpadding="0" cellspacing="0"  style="border-collapse:collapse;" id='table2'>
              <tr >
              
                 <td  >拍卖厅</td>
                 <td align="center" colspan=10>日期 <s:date name="#request.day" format="yyyy-MM-dd"/>  </td>
                 
              </tr>
               <s:iterator value="#request.pmtList" var="pmt" status="flag">
              <tr>
               <td  >&nbsp;&nbsp; <s:property value="#pmt.pmtName"/></td>
             
                  
                      
                          <s:iterator value="#pmt.ut"  var="u">
                            <td  >
                           [ <s:property value="#u.useTime"/>
                             <s:set name="biaoji" var="biaoji" value="0"></s:set>
                             <s:iterator value="#request.useList" var="ulist"> 
                            
                                <s:if test="#ulist.pmt == #pmt.id && #ulist.ut == #u.id">
                                   <s:set value="1" name="biaoji"></s:set>
                                  <s:property value="#ulist.pmCompany"/>
                                </s:if>
                                </s:iterator>]
                             <s:if test="#biaoji==0">  <a href="pmtsqAction_add?pmtid=<s:property value="#pmt.id"/>&utid=<s:property value="#u.id"/>&day=<s:date name="#request.day" format="yyyy-MM-dd"/>">申请</a> </s:if>
                            </td>
                         </s:iterator>
             
                
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
