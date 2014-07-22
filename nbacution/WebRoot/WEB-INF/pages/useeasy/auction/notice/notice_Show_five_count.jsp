<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 
    <link rel="stylesheet" type="text/css" href="/notice/js/thickbox.css">
  <script type="text/javascript" src="/notice/js/jquery.droppable.js"></script> 
  <script type="text/javascript" src="/notice/js/jquery.js"></script> 
  <script type="text/javascript" src="/notice/js/thickbox.js"></script>
    <s:action name="noticeAction_getNoticeFive" executeResult="true"   >
     <s:param name="cid" value="#request.auctionCompany.id"> </s:param>
    
   </s:action> 
   
              <s:iterator value="#request.list" var="list">
               <li>
                 <s:if test="#list.title.length()>30">
                     <a class="thickbox" title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/>&TB_iframe=true&height=550&width=700"><s:property value="#list.title.substring(0,30)"/>...</a>
                 </s:if>
                  <s:else>
                    <a class="thickbox" title="拍卖公告" href="noticeAction_get?id=<s:property value='#list.id'/>&TB_iframe=true&height=550&width=700">
                     <s:property value="#list.title"/>
                   </a></li>
                  </s:else>
                    </s:iterator>
          
                            
 
