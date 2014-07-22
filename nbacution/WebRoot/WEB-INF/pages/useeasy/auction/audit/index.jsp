<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/structure.css"	rel="stylesheet" type="text/css" />
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
		  	<div class="l">未审核的用户</div>
		  	<div class="r">	
		  		<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
  			</div>
		  </div>
		  
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">序号</td>
			  <td width="15%" bgcolor="#FFFFFF">用户名</td>
			  <td width="15%" bgcolor="#FFFFFF">姓名</td>
			  <td width="20%" bgcolor="#FFFFFF">证件号码</td>
			  <td width="25%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="15%" bgcolor="#FFFFFF">操作</td>
            </tr>
            <s:iterator value="applyInfo_list" var="appInfo_list_fir" status="status_fir">
            		<s:if test="#appInfo_list_fir.applyStatus == 0">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#status_fir.index+1"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_fir.accountName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_fir.userName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_fir.indentityCard"/></td>
					  	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_fir.auctionName"/></td>
		              	<td bgcolor="#FFFFFF" class="state">
					  		尚未审核<br/>
					  		<s:if test="#appInfo_list_fir.auctionStatus != 2">
					  		<a href="companyAudit_check?applyFlag=<s:property value="#appInfo_list_fir.id"/>"><font color="red">审核</font></a>
           					</s:if>
           					<s:else>
           					--</s:else>
           				</td>
		            </tr>
		            </s:if>
	        </s:iterator>
		            
	            
          </table>
		  <br/> 
			   <div class="tit">
			  	<div class="l">未授权的用户</div>
			  	<div class="r">	 
			  	</div>
			  </div>
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">序号</td>
			  <td width="15%" bgcolor="#FFFFFF">用户名</td>
			  <td width="15%" bgcolor="#FFFFFF">姓名</td>
			  <td width="20%" bgcolor="#FFFFFF">证件号码</td>
			  <td width="25%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="15%" bgcolor="#FFFFFF">操作</td>
            </tr>
            <s:iterator value="applyInfo_list" var="appInfo_list_sec" status="status_sec">
            		<s:if test="#appInfo_list_sec.applyStatus == 1">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#status_sec.index+1"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_sec.accountName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_sec.userName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_sec.indentityCard"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_sec.auctionName"/></td>
		              	<td bgcolor="#FFFFFF" class="state">
					  		尚未授权<br/>
					  		<s:if test="#request.auctionStatus != 2">
           					<a href="companyAudit_authority?applyFlag=<s:property value="#appInfo_list_sec.id"/>"><font color="red">授权</font></a>
           					</s:if>
           					<s:else>
           					<a href="companyAudit_detail?applyFlag=<s:property value="#appInfo_list_sec.id"/>"><font color="red">查看</font></a>
           					</s:else>
           				</td>
		            </tr>
		            </s:if>
	        </s:iterator>
	            
            
          </table>
          
			<br/> 
			   <div class="tit">
			  	<div class="l">已授权的用户</div>
			  	<div class="r">	 
			  	</div>
			  </div>
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">序号</td>
			  <td width="15%" bgcolor="#FFFFFF">用户名</td>
			  <td width="15%" bgcolor="#FFFFFF">姓名</td>
			  <td width="20%" bgcolor="#FFFFFF">证件号码</td>
			  <td width="25%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="15%" bgcolor="#FFFFFF">操作</td>
            </tr>
            <s:iterator value="applyInfo_list" var="appInfo_list_thi" status="status_thi">
            		<s:if test="#appInfo_list_thi.applyStatus == 2">
		            <tr align="center">
						<td bgcolor="#FFFFFF"><s:property value="#status_thi.index+1"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_thi.accountName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_thi.userName"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_thi.indentityCard"/></td>
		              	<td bgcolor="#FFFFFF"><s:property value="#appInfo_list_thi.auctionName"/></td>
		              	<td bgcolor="#FFFFFF" class="state">
					  		已授权<br/>
					  		<s:if test="#request.auctionStatus != 2">
					  		<a href="companyAudit_reAuthority?applyFlag=<s:property value="#appInfo_list_thi.id"/>"><font color="red">重新授权</font></a><br/>
					  		<a href="companyAudit_margin?applyFlag=<s:property value="#appInfo_list_thi.id"/>"><font color="red">支付保证金</font></a>
           					</s:if>
           					<s:else>
           					<a href="companyAudit_detail?applyFlag=<s:property value="#appInfo_list_thi.id"/>"><font color="red">查看</font></a>
           					</s:else>
           				</td>
		            </tr>
		            </s:if>
	        </s:iterator>
	            
            
          </table>
          
		</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	
	
</script>
</body>
</html>
