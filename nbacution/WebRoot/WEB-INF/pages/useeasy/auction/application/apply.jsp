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
		<div class="main">
			<!--left-->
			<div class="left">
			 <%@include file="/WEB-INF/pages/useeasy/auction/main/left.jsp" %>
			</div>
			<!--end left-->
			
			<!--right-->
			<div class="right"> 
	  			<div class="tit">
  				<div class="l">申请竞拍</div>
	  			<div class="r"></div>
	  			</div> 
	  			
	  			
	  								  

  			<form name="" action="" method="post">
			<input  type="hidden"  name="auctionFlag" value="<s:property value="#request.auctionFlag"/>"/>
	   		<input  type="hidden"  name="accountFlag" value="<s:property value="#request.accountFlag"/>"/>
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
          	<tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">用户名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:property value="#request.userName"/>
              </td>
            </tr>
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">拍卖会名称:</span></td>
              <td bgcolor="#FFFFFF">
              	<s:property value="#request.auctionName"/>
              </td>
            </tr>
            
            <tr>
              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">备注</span></td>
              <td bgcolor="#FFFFFF">
              	<textarea name="applyContent" id="applyContent" cols="50" rows="6"></textarea>
              	
              </td>
            </tr>
            
            <s:if test="#request.webPayCheck == 1">
            	<tr>
             	 <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left">保证金支付</span></td>
             	 <td bgcolor="#FFFFFF">
              	<span>网络支付：<s:property value="#request.webMargin"/>元</span><br/>
              	<input type="hidden" id="auctionWebMargin_val" value="<s:property value="#request.webMargin"/>"/>
              	</td>
            	</tr>
            	<tr id="margin_div">
	              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>保证金支付方式</span></td>
	              <td bgcolor="#FFFFFF">
	              	<input type="radio" name="margin_radio" id="web_pay" value="1" onclick="doClickMarginRadio(this.value)"/>网上支付
	              	<input type="radio" name="margin_radio" id="alive_pay" value="2" onclick="doClickMarginRadio(this.value)"/>现场支付
	              </td>
	            </tr>
	            <tr id="ebank_web_div" style="display:none">
	              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>保证金支付接口</span></td>
	              <td bgcolor="#FFFFFF">
	              	<input type="radio" name="ebank_radio" id="ebank_radio_fir" value="1" checked="checked"/>交通银行
	              	<!--<input type="radio" name="ebank_radio" id="alive_pay" value="2" onclick="doClickMarginRadio(this.value)"/>支付宝-->
	              </td>
	            </tr>
	            <tr id="margin_web_div" style="display:none">
	              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>保证金支付选项</span></td>
	              <td bgcolor="#FFFFFF">
	              	<input type="radio" name="margin_web_radio" id="web_pay_auto" value="1" onclick="doClickWebPayRadio(this.value)"/>固定支付
	              	<input type="radio" name="margin_web_radio" id="web_pay_manu" value="2" onclick="doClickWebPayRadio(this.value)"/>手动支付
	              	<span style="color:red">(<s:property value="#request.auctionMarginLevelFir"/>元---<s:property value="#request.auctionMarginMax"/>元)</span>
	              
	              </td>
	            </tr>
	            <tr id="web_auto_div" style="display:none">
	              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>保证金金额</span></td>
	              <td bgcolor="#FFFFFF">
	              	<s:if test="#request.auctionMarginLevelFir != null && #request.auctionMarginLevelFir != ''">
	              		<input type="radio" name="web_auto_radio" id="pay_auto_fir" value="<s:property value="#request.auctionMarginLevelFir"/>"/><s:property value="#request.auctionMarginLevelFir"/>
	              	</s:if>
	              	<s:if test="#request.auctionMarginLevelSec != null && #request.auctionMarginLevelSec != ''">
	              		<input type="radio" name="web_auto_radio" id="pay_auto_sec" value="<s:property value="#request.auctionMarginLevelSec"/>"/><s:property value="#request.auctionMarginLevelSec"/>
	              	</s:if>
	              	<s:if test="#request.auctionMarginLevelThi != null && #request.auctionMarginLevelThi != ''">
	              		<input type="radio" name="web_auto_radio" id="pay_auto_thi" value="<s:property value="#request.auctionMarginLevelThi"/>"/><s:property value="#request.auctionMarginLevelThi"/>
	              	</s:if>
	              </td>
	            </tr>
	            <tr id="web_manu_div" style="display:none">
	              <td width="180" align="center" bgcolor="#FFFFFF"><span class="td_left"><font color="red">*</font>保证金金额</span></td>
	              <td bgcolor="#FFFFFF">
	              	<input type="text" id="web_manu_margin" name="web_manu_margin" size="20" maxlength="10"/>
	              </td>
	            </tr>
	            	<input type="hidden" id="auctionMarginLevelFir_val" value="<s:property value="#request.auctionMarginLevelFir"/>"/>
         		 	<input type="hidden" id="auctionMarginMax_val" value="<s:property value="#request.auctionMarginMax"/>"/>
          
            </s:if>
            
            <tr>
            	<td align="center" colspan="2">
            		<input class="large_btn"  type="button" value="我要申请"  onclick="doSubmit();" />
				</td>
            </tr>
          	
          	</table>
          	</form>
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function doSubmit(str){
		var margin_flag = "-1";
		var auctionWebMargin = $("#auctionWebMargin_val").val();
		var auctionMarginMax = $("#auctionMarginMax_val").val();
		var auctionWebMargin = $("#auctionWebMargin_val").val();
		
		if($("#margin_div").val() != undefined){
			if(!$("#web_pay")[0].checked && !$("#alive_pay")[0].checked){
				$("#web_pay").focus();
				alert("请选择保证金支付方式！");
				return;
			}
			if($("#web_pay")[0].checked ){
				if(!$("#web_pay_auto")[0].checked && !$("#web_pay_manu")[0].checked){
					alert("请选择保证金支付选项！");
					$("#web_pay_auto").focus();
					return;
				}
				if($("#web_pay_auto")[0].checked){
					
					if($("#pay_auto_fir")[0].checked){
						margin_flag = $("#pay_auto_fir").val();
					}
					if($("#pay_auto_sec").val() != undefined && $("#pay_auto_sec")[0].checked){
						margin_flag = $("#pay_auto_sec").val();
					}
					if($("#pay_auto_thi").val() != undefined && $("#pay_auto_thi")[0].checked){
						margin_flag = $("#pay_auto_thi").val();
					}
					if(margin_flag == "-1"){
						alert("请选择保证金金额！");
						$("#pay_auto_fir").focus();
						return;
					}
					if((Number(margin_flag)+Number(auctionWebMargin)) > Number(auctionMarginMax)){
						alert("保证金不能大于最大保证金！");
						return;
					}
					if((Number(margin_flag)+Number(auctionWebMargin)) < Number(auctionMarginLevelFir)){
						alert("保证金不能小于最小保证金！");
						return;
					}
					
				}
				if($("#web_pay_manu")[0].checked){
					var web_manu_margin = $("#web_manu_margin").val();
					var web_manu_margin_pattern = new RegExp("^[1-9]{1,1}[0-9]{0,9}$");
					if(!web_manu_margin_pattern.test(web_manu_margin)){
						$("#web_manu_margin").focus();
						alert("保证金金额为整数！");
						return;
					}
					var auctionMarginLevelFir = $("#auctionMarginLevelFir_val").val();
					var auctionMarginMax = $("#auctionMarginMax_val").val();
					
					if((Number(web_manu_margin)+Number(auctionWebMargin)) > Number(auctionMarginMax)){
						$("#web_manu_margin").focus();
						alert("保证金不能大于最大保证金！");
						return;
					}
					if((Number(web_manu_margin)+Number(auctionWebMargin)) < Number(auctionMarginLevelFir)){
						$("#web_manu_margin").focus();
						alert("保证金不能小于最小保证金！");
						return;
					}
					margin_flag = web_manu_margin;
				}
			}
		}
		
		if(confirm("是否提该参拍申请！")){
			document.forms[0].target = "_self";
		 	document.forms[0].action="guestApplication_doApply?margin_val="+margin_flag;
			document.forms[0].submit();
		}
	}
	function doClickMarginRadio(str){
		if(str == 1){
			$("#margin_web_div").show();
			$("#ebank_web_div").show();
			$("#web_auto_div").hide();
			$("#web_manu_div").hide();
		}
		if(str == 2){
			$("#margin_web_div").hide();
			$("#ebank_web_div").hide();
			$("#web_auto_div").hide();
			$("#web_manu_div").hide();
			$("#web_pay_auto")[0].checked = false;
			$("#web_pay_manu")[0].checked = false;
			$("#web_manu_margin").val("");
			$("#pay_auto_fir")[0].checked = false;
			if($("#pay_auto_sec").val() != undefined){
				$("#pay_auto_sec")[0].checked = false;
			}
			if($("#pay_auto_thi").val() != undefined){
				$("#pay_auto_thi")[0].checked = false;
			}
		}
		
	}
	function doClickWebPayRadio(str){
		if(str == 1){
			$("#web_auto_div").show();
			$("#web_manu_div").hide();
			
		}
		if(str == 2){
			$("#web_auto_div").hide();
			$("#web_manu_div").show();
			$("#pay_auto_fir")[0].checked = false;
			if($("#pay_auto_sec").val() != undefined){
				$("#pay_auto_sec")[0].checked = false;
			}
			if($("#pay_auto_thi").val() != undefined){
				$("#pay_auto_thi")[0].checked = false;
			}
		}
		
	}
</script>
</body>
</html>
