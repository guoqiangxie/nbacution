<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<%@ page import = "com.bocom.netpay.b2cAPI.*"%>
<%@ page import = "com.useeasy.auction.util.ebank.*"%>
<script language="javaScript">
function url(){
	document.forms[0].submit();
}
</script>
<body bgcolor = "#FFFFFF" text = "#000000" onload = " javascript:url();">
        
        <form name = "form1" method = "post" action = "<s:property value="#request.formUrl"/>">
            <input type = "hidden" name = "interfaceVersion" value = "<s:property value="#request.payBean.interfaceVersion"/>">
            <input type = "hidden" name = "merID" value = "<s:property value="#request.payBean.merID"/>">
            <input type = "hidden" name = "orderid" value = "<s:property value="#request.payBean.orderid"/>">
            <input type = "hidden" name = "orderDate" value = "<s:property value="#request.payBean.orderDate"/>">
            <input type = "hidden" name = "orderTime" value = "<s:property value="#request.payBean.orderTime"/>">
            <input type = "hidden" name = "tranType" value = "<s:property value="#request.payBean.tranType"/>">
            <input type = "hidden" name = "amount" value = "<s:property value="#request.payBean.amount"/>">
            <input type = "hidden" name = "curType" value = "<s:property value="#request.payBean.curType"/>">
            <input type = "hidden" name = "orderContent" value = "<s:property value="#request.payBean.orderContent"/>">
            <input type = "hidden" name = "orderMono" value = "<s:property value="#request.payBean.orderMono"/>">
            <input type = "hidden" name = "phdFlag" value = "<s:property value="#request.payBean.phdFlag"/>">
            <input type = "hidden" name = "notifyType" value = "<s:property value="#request.payBean.notifyType"/>">
            <input type = "hidden" name = "merURL" value = "<s:property value="#request.payBean.merURL"/>">
            <input type = "hidden" name = "goodsURL" value = "<s:property value="#request.payBean.goodsURL"/>">
            <input type = "hidden" name = "jumpSeconds" value = "<s:property value="#request.payBean.jumpSeconds"/>">
            <input type = "hidden" name = "payBatchNo" value = "<s:property value="#request.payBean.payBatchNo"/>">
            <input type = "hidden" name = "proxyMerName" value = "<s:property value="#request.payBean.proxyMerName"/>">
            <input type = "hidden" name = "proxyMerType" value = "<s:property value="#request.payBean.proxyMerType"/>">
            <input type = "hidden" name = "proxyMerCredentials" value = "<s:property value="#request.payBean.proxyMerCredentials"/>">
            <input type = "hidden" name = "netType" value = "<s:property value="#request.payBean.netType"/>">
            <input type = "hidden" name = "merSignMsg" value = "<s:property value="#request.payBean.signMsg"/>">
        </form>
    </body>