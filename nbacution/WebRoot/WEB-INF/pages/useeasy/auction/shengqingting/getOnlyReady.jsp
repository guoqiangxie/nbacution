<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@taglib uri="pmh_tag"  prefix="pmh"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="DataPicker4.0/My97DatePicker/WdatePicker.js" language="javascript"></script>

<title>宁波市在线同步拍卖交易平台</title>
  
</head>
<body>
 

<!--container-->
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
  				<div class="l">拍卖厅申请资料填写 </div> 
	  			<div class="r">
	  			  &nbsp;&nbsp;
	  			</div>
	  			</div> 
	 
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
              <tr>
                 <td bgcolor="#FFFFFF">拍卖类别</td>
                 <td bgcolor="#FFFFFF">
                 <input type="hidden" value="<s:property value="#request.pmtsqObject.id"/>" name="id"/>
                 <s:select disabled="true" theme="simple" name="pmType"  list="#{1:'房地产',2:'机动车',3:'物质设备',4:'股权',5:'民品',6:'文艺术品',7:'其他'}" listKey="key" listValue="value" emptyOption="true" value="#request.pmtsqObject.pmType"></s:select></td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">拍卖会名称</td>
                 <td bgcolor="#FFFFFF">
                    <input type="text" name="pmhName" maxlength="200" id="pmhName" disabled="disabled" value="<s:property value="#request.pmtsqObject.pmhName"/> "/> 
                 </td>
               </tr>
               
               
               
               
               
                <tr>
                 <td bgcolor="#FFFFFF">拍卖时间</td>
                 <td bgcolor="#FFFFFF">
                      <input type="text"  name="pmTime"   disabled="disabled"  value="<s:date  name="#request.pmtsqObject.pmTime" format='yyyy-MM-dd HH:MM'/>" />
           
                </td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">拍卖地址</td>
                 <td bgcolor="#FFFFFF">
                      <input type="text" name="pmAddress"  disabled="disabled"  maxlength="100" disabled="disabled" value="<s:property value="#request.pmtsqObject.pmAddress"/>"/>
                 </td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">使用人</td>
                 <td bgcolor="#FFFFFF"><input maxlength="10"  disabled="disabled" type="text" name="person" value="<s:property value="#request.pmtsqObject.person"/>"/> </td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">电话</td>
                 <td bgcolor="#FFFFFF"><input maxlength="15"  disabled="disabled"  type="text" name="tel" value="<s:property value="#request.pmtsqObject.tel"/>"/></td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">手机</td>
                 <td bgcolor="#FFFFFF"><input maxlength="11"  disabled="disabled" type="text" name="phone" value="<s:property value="#request.pmtsqObject.phone"/>"/></td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">刊登报纸</td>   
						 
							 
                 <td bgcolor="#FFFFFF">
                    <input type="text" name="newsPaper" disabled="disabled" value="<s:property value="#request.pmtsqObject.newsPaper"/>"/>   </td>
                        
                      
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">见报日期</td>
                 <td bgcolor="#FFFFFF"><input type="text" name="paperTime" disabled="disabled"  value="<s:date  name="#request.pmtsqObject.paperTime" format='yyyy-MM-dd HH:MM'/>"/></td>
               </tr>
                <tr>
                 <td bgcolor="#FFFFFF">公司网址</td>
                 <td bgcolor="#FFFFFF"><input  size="50" disabled="disabled"  maxlength="50" type="text" name="internetMain" value="<s:property value="#request.pmtsqObject.internetMain"/>"/></td>
               </tr>
                  
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
