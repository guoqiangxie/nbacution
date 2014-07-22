<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  
<script type="text/javascript">
    function updateViewSta(pmhid,accountName,id){
        
         $.get("inteneterAction_updateViewSta?account="+accountName+"&pmhId="+pmhid,null,function(date){
               if(date == "yes"){
                  $("#"+id).html("已审");
               }
          
          
          }); 
            
    
    }



</script>



  </head>
  
  <body>
 
       <center>
           <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="" id="table1">
              <tr>
                   <td  align="center" >序号</td><td align="center" >用户名</td>
                   <td    align="center">授权</td><td   align="center" >状态</td>
                 
              </tr>
             <s:iterator value="#request.list" var="list" status="flag">
               <tr>
                   <td  align="center"> <s:property value="#flag.index+1"/>  </td>
                    <td align="center" >  <s:property value="#list.accountName"/>  </td>
                    
                             <td align="center" > 
                                <s:if test="#list.viewSta == 1">
                                <input disabled="disabled" type="button" value="授权" onclick="updateViewSta(<s:property value='#list.pmh_id'/>,<s:property value='#list.id'/>)"/>  
                                <td  align="center" >已审</td>
                                </s:if>
                                <s:elseif test="#list.viewSta == 0">
                                
                                 <input   type="button" value="授权" onclick="updateViewSta(<s:property value='#list.pmh_id'/>,'<s:property value='#list.accountName'/>',<s:property value='#list.id'/>)"/>  
                                 <td align="center"  id="<s:property value="#list.id"/>"></td>
                                </s:elseif>  
                             
                             
                             </td>
                      
               </tr>
            
            </s:iterator>
           </table>
       
       
       </center>
  </body>
</html>
