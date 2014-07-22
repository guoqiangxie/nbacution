<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 <div class="inside">
<%-- 滚动图片 --%>

	<div class=""  id="marquee_demo" style="overflow:hidden;width:100%;  ">
		
  
	 <script type="text/javascript">
   function hitCount(obj){
  
     $.post("businessAction_hitCount?id="+obj,null,null);
    // location.reload();
    location.href="businessAction_getIndex?id="+obj;
   }
  

</script>
<style type="text/css">
img {border:0px}


</style>
  
  <s:action name="businessAction_getIndexListsix" executeResult="true" var="list" ></s:action>
 
   <table    >
    <tr>
   <s:iterator value="#request.list" var="list" status="flag" begin="0">
   <s:if test="#flag.index<8">
    <td> 
      <ul>
       <li>
         
           <img onclick="hitCount(<s:property value='#list.id'/>)" src="<s:property value="#list.imgPath"/>" width="80" height="65" />
         
      </li>
      <li title="<s:property value="#list.title"/>" onclick="hitCount(<s:property value='#list.id'/>)"> 
          <s:if test="#list.title.length()>10">
            
              <s:property value="#list.title.substring(0,10)"  />
              
           </s:if>
           <s:else>
            
               <s:property value="#list.title"/>
               
           </s:else>          
           
       </li>
     </ul>
     </td>
     </s:if>
   </s:iterator>
   </tr>
  </table>
  
  
  
    <table   >
    <tr>
   <s:iterator value="#request.list" var="list" status="flag">
   <s:if test="#flag.index>8">
    <td> 
      <ul>
       <li>
           
               <img onclick="hitCount(<s:property value='#list.id'/>)"  src="<s:property value="#list.imgPath"/>" width="80" height="65"  />
            
        </li>
        <li onclick="hitCount(<s:property value='#list.id'/>)"> 
           
              <s:property value="#list.title" />
            
        </li>
     </ul>
     </td>
     </s:if>
   </s:iterator>
   </tr>
  </table>
  </div>
  </div>