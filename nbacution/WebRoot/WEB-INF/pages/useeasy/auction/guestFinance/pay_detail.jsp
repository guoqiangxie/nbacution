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

		
		
			
			<!--right-->
			
	  			<div class="right"> 
	  			<div class="tit">
	  				<div class="l">我的保证金</div> 
	  				<div class="r">
	  				</div>
		  			
	  			</div>
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
	  		
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">序号</td>
              <td width="10%" bgcolor="#FFFFFF">支付日期</td>
			  <td width="10%" bgcolor="#FFFFFF">支付金额</td>
			  <td width="10%" bgcolor="#FFFFFF">支付类型</td>
			  <td width="10%" bgcolor="#FFFFFF">订单号</td>
            </tr>
            <s:iterator value="marginFinance_list" var="mFinance_list" status="status">
         		<tr align="center" id="">
					<td bgcolor="#FFFFFF"><s:property value="#status.index+1"/></td>
	              	<td bgcolor="#FFFFFF"><s:date name="#mFinance_list.createTime" /></td>
				  	<td bgcolor="#FFFFFF"><s:property value="#mFinance_list.marginVal"/></td>
				  	<td bgcolor="#FFFFFF">
					  	<s:if test="#mFinance_list.marginType == 1">
					  	现场支付
					  	</s:if>
					  	<s:elseif test="#mFinance_list.marginType == 2">
					  	网络支付
					  	</s:elseif>
					</td>
					<td bgcolor="#FFFFFF">
					  	<s:if test="#mFinance_list.marginType == 1">
					  	--
					  	</s:if>
					  	<s:elseif test="#mFinance_list.marginType == 2">
					  	<s:property value="#mFinance_list.orderId"/>
					  	</s:elseif>
					</td>
				</tr>
			</s:iterator>
          </table>
         	<div class="tit">
	  				<div class="l">我的货款</div> 
	  				<div class="r">
	  				</div>
		  			
	  			</div>
	  		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
	  		
            <tr align="center">
              <td width="10%" bgcolor="#FFFFFF">序号</td>
              <td width="10%" bgcolor="#FFFFFF">支付日期</td>
			  <td width="10%" bgcolor="#FFFFFF">支付金额</td>
			  <td width="10%" bgcolor="#FFFFFF">支付类型</td>
			  <td width="10%" bgcolor="#FFFFFF">订单号</td>
            </tr>
            <s:iterator value="goodsFinance_list" var="gFinance_list" status="status">
         		<tr align="center" id="">
					<td bgcolor="#FFFFFF"><s:property value="#status.index+1"/></td>
	              	<td bgcolor="#FFFFFF"><s:date name="#gFinance_list.createTime"/></td>
				  	<td bgcolor="#FFFFFF"><s:property value="#gFinance_list.goodsVal"/></td>
				  	<td bgcolor="#FFFFFF">
					  	<s:if test="#gFinance_list.goodsType == 1">
					  	现场支付
					  	</s:if>
					  	<s:elseif test="#gFinance_list.goodsType == 2">
					  	网络支付
					  	</s:elseif>
					</td>
					<td bgcolor="#FFFFFF">
					  	<s:if test="#gFinance_list.goodsType == 1">
					  	--
					  	</s:if>
					  	<s:elseif test="#gFinance_list.goodsType == 2">
					  	<s:property value="#gFinance_list.orderId"/>
					  	</s:elseif>
					</td>
				</tr>
			</s:iterator>
          </table>
	   	 	</div>
			<!--end right-->
		
		<!--end main-->
	
	 	
</body>
</html>
