<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@taglib uri="/struts-tags" prefix="s" %>
  
    <s:action name="auctionIndexManager_getList" executeResult="true"></s:action>
       <table width="50%"  class="infoListpmxx_index"   style="float:left"  > 
            <s:iterator  value="#request.list"  var="list" status="flag">
          <tr>
          <s:if test="#flag.index%2 == 0">
          <td  style="width:50%; float:left"  >
           <s:if test="#list.auctionType==null || #list.auctionType=='' " >
           [无拍卖类别]
           </s:if>
           <s:else>
           <a href="auctionIndexManager_querytype?no=<s:property value="#list.itemType"/>">
          [ <s:if test="#list.itemType==1">
                                                   房地产
           </s:if>
           <s:elseif test="#list.itemType==2">
                                                      机动车
           </s:elseif>
           <s:elseif test="#list.itemType==3">
                                                          物资设备
           </s:elseif>
           <s:elseif test="#list.itemType==4">
                                           股权
           </s:elseif>
           <s:elseif test="#list.itemType==5">
                                             民品
           </s:elseif>
           <s:elseif test="#list.itemType==6">
                                            文物艺术品
           </s:elseif>
           <s:elseif test="#list.itemType==7">
                                          其他
           </s:elseif>
           ]</a>
           </s:else>
           <a   href="auctionIndexManager_queryid_show?id=<s:property value="#list.id"/>" title="<s:property value="#list.itemName"/>"> 
             <s:if test="#list.itemName.length()>6">
               <s:property value="#list.itemName.substring(0,6)"/>...
             </s:if>
             <s:else>
                <s:property value="#list.itemName"/>
             </s:else>
            
            </a>
           </td>
           </s:if>
          
           </tr>
            </s:iterator>
          
    </table>
   
   
   
    <table width="49%"    style="float:right"  class="infoListpmxx_index" > 
            <s:iterator  value="#request.list"  var="list" status="flag">
          <tr>
          <s:if test="#flag.index%2 != 0">
          <td  style="width:50%; float:left"  >
           <s:if test="#list.auctionType==null || #list.auctionType=='' " >
           [无拍卖类别]
           </s:if>
           <s:else>
           <a href="auctionIndexManager_querytype?no=<s:property value="#list.itemType"/>">
          [ <s:if test="#list.itemType==1">
                                                   房地产
           </s:if>
           <s:elseif test="#list.itemType==2">
                                                      机动车
           </s:elseif>
           <s:elseif test="#list.itemType==3">
                                                          物资设备
           </s:elseif>
           <s:elseif test="#list.itemType==4">
                                           股权
           </s:elseif>
           <s:elseif test="#list.itemType==5">
                                             民品
           </s:elseif>
           <s:elseif test="#list.itemType==6">
                                            文物艺术品
           </s:elseif>
           <s:elseif test="#list.itemType==7">
                                          其他
           </s:elseif>
           ]</a>
           </s:else>
              <a   href="auctionIndexManager_queryid_show?id=<s:property value="#list.id"/>" title="<s:property value="#list.itemName"/>"> 
             <s:if test="#list.itemName.length()>6">
               <s:property value="#list.itemName.substring(0,6)"/>...
             </s:if>
             <s:else>
                <s:property value="#list.itemName"/>
             </s:else>
            
            </a>
           </td>
           </s:if>
          
           </tr>
            </s:iterator>
          
    </table>
   