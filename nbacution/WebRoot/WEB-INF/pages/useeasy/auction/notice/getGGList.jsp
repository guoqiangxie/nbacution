<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%> 

 
     
   
    <s:action name="noticeAction_getGGList" executeResult="true"   >
     <s:param name="cid" value="#request.auctionCompany.id"></s:param> 
   </s:action> 
   <table  width="100%" >
              <tr>
                <td width="15%">公告标题 </td>
                 <td width="15%">拍卖时间</td>
                  <td width="15%">公司电话</td>
                 <td width="15%">拍卖公司</td>
                  <td width="15%"> 拍卖会名称 </td>
                 <td width="15%">公告类型</td>
                
                  
              </tr>
              <s:iterator value="#request.list" var="list">
             <tr>
               <td title="<s:property value="#list.title"/>">
                 <s:if test="#list.title.length()>35"><s:property value="#list.title.substring(0,35)"/>...</s:if>
                  <s:else><s:property value="#list.title"/></s:else>
               
                </td>
                 <td><s:date name="#list.createtime" format="yyyy-MM-dd"/></td>
                 <td><s:property value="#list.phone"/></td>
                 <td><s:property value="#list.company"/></td>
                 <td>
                  <s:if test="#list.pmhName.length()>30"> <a class="thickbox" title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/> &TB_iframe=true&height=550&width=700"><s:property value="#list.pmhName.substring(0,30)"/>...</a></s:if>
                  <s:else>
                    <a class="thickbox" title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/>&TB_iframe=true&height=550&width=700"><s:property value="#list.pmhName"/></a>
                  </s:else>
                 
                 
                 
                 </td>
                 <td> <s:select theme="simple"  disabled="true" list="#{'1':'房地产','2':'艺术品','3':'民品','4':'机动车','5':'物资设备','6':'股权','7':'其他'}" listKey="key" listValue="value" value="#list.notice_type"></s:select></td>
                  
                   
             
             </tr>
             </s:iterator>
          </table>
           
                              <pmh:pageTag gotoURI="companyIndex_bulletin?currentPage=1&companyId=${requestScope.auctionCompany.id}" pageSize="${requestScope.pageSize}"></pmh:pageTag>    
    