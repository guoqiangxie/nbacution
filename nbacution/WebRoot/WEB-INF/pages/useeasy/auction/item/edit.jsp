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
<script type="text/javascript" src="useeasy/auction/js/item/edit.js" language="javascript"></script>
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
  				<div class="l">拍品修改(带<span style="color:red">*</span>的为必填项)</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="itemManage_index?auctionFlag=<s:property value="itemInfo.auctionId"/>">【返回】</a> 
	  			</div>
	  			</div> 
	  		
	  		
	  		<form name="" action="" method="post">
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		<tr>
              <td align="right" width="150" bgcolor="#FFFFFF"><span style="color:red">*</span>拍品名称:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="itemName" name="itemInfo.itemName" size="50" maxlength="300" value="<s:property value="itemInfo.itemName"/>"/></td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍品序号:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="itemNumber" name="itemInfo.itemNumber" size="20" maxlength="5" value="<s:property value="itemInfo.itemNumber"/>"/>
              <br/><font color="red">(必须是数字，操作端在准备下一拍品时，通过这个顺序来控制拍卖顺序)</font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>显示编号:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="viewOrder" name="itemInfo.viewOrder" size="20" maxlength="20" value="<s:property value="itemInfo.viewOrder"/>"/>
              <br/><font color="red">(可以是任意字符，在拍品列表页面显示用，如:加1、+1等等)</font></td>
            </tr>
            
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖方式:</td>
              <td bgcolor="#FFFFFF">
              	<input type="radio" id="valuationMethod_fir" name="itemInfo.valuationMethod" value="1" onclick="doClickValuationMethod(this.value)"/>总价
              	<input type="radio" id="valuationMethod_sec" name="itemInfo.valuationMethod" value="2" onclick="doClickValuationMethod(this.value)"/>单价
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>数量:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="countNumber" name="itemInfo.countNumber" size="20" maxlength="20" value="<s:property value="itemInfo.countNumber"/>"/>
              <br/><font color="red">(按总价时是1，按单价时输入相应的数量，比如房产的面积等)</font></td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>单位:</td>
              <td bgcolor="#FFFFFF">
             	 	<select id="countUnit" name="itemInfo.countUnit" onchange="doChangeCountUnit(this.value)">
             	 			<option value="0">请选择</option>
             	 			<s:if test="itemInfo.countUnit == 1">
								<option value="1" selected="selected">件</option>
							</s:if>
							<s:else>
								<option value="1">件</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 2">
								<option value="2" selected="selected">台</option>
							</s:if>
							<s:else>
								<option value="2">台</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 3">
								<option value="3" selected="selected">个</option>
							</s:if>
							<s:else>
								<option value="3">个</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 4">
								<option value="4" selected="selected">批</option>
							</s:if>
							<s:else>
								<option value="4">批</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 5">
								<option value="5" selected="selected">组</option>
							</s:if>
							<s:else>
								<option value="5">组</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 6">
								<option value="6" selected="selected">平方米</option>
							</s:if>
							<s:else>
								<option value="6">平方米</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 7">
								<option value="7" selected="selected">吨</option>
							</s:if>
							<s:else>
								<option value="7">吨</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 8">
								<option value="8" selected="selected">千克</option>
							</s:if>
							<s:else>
								<option value="8">千克</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 9">
								<option value="9" selected="selected">股</option>
							</s:if>
							<s:else>
								<option value="9">股</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 10">
								<option value="10" selected="selected">辆</option>
							</s:if>
							<s:else>
								<option value="10">辆</option>
							</s:else>
							<s:if test="itemInfo.countUnit == 11">
								<option value="11" selected="selected">其他</option>
							</s:if>
							<s:else>
								<option value="11">其他</option>
							</s:else>
							
					</select>
					<span id="countContent_span" style="display:none">
               	 		<input type="text" id="countContent" name="itemInfo.countContent" size="20" maxlength="20" value="<s:property value="itemInfo.countContent"/>"/>
               	 		<input type="hidden" id="countContent_hidden" value="<s:property value="itemInfo.countContent"/>"/>
                	</span>
			  </td>
            </tr>
			
			
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金方式:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.itemCommissionType" id="itemCommissionType" onchange="doChangeCommissionType(this.value)">
                		<option value="0">请选择</option>
                		<s:if test="itemInfo.itemCommissionType == 1">
							<option value="1" selected="selected">固定比率</option>
						</s:if>
						<s:else>
							<option value="1">固定比率</option>
						</s:else>
						<s:if test="itemInfo.itemCommissionType == 2">
							<option value="2" selected="selected">定额佣金</option>
						</s:if>
						<s:else>
							<option value="2">定额佣金</option>
						</s:else>
						<s:if test="itemInfo.itemCommissionType == 3">
							<option value="3" selected="selected">执行最高院司法规定</option>
						</s:if>
						<s:else>
						   <option value="3"  >执行最高院司法规定</option>
						</s:else>
							<s:if test="itemInfo.itemCommissionType == 4">
							<option value="4" selected="selected">浙江省高级人民法院</option>
						   </s:if>
						   <s:else>
						     <option value="4"  >浙江省高级人民法院</option>
						   </s:else>
							<s:if test="itemInfo.itemCommissionType == 5">
							   <option value="5" selected="selected">慈溪市人民法院</option>
						   </s:if>
						   <s:else>
						      <option value="5"  >慈溪市人民法院</option>
						   </s:else>
							<s:if test="itemInfo.itemCommissionType == 6">
							   <option value="6" selected="selected">镇海区人民法院</option>
						    </s:if>
						    <s:else>
						       <option value="6"  >镇海区人民法院</option>
						    </s:else>
						
						
                		 
				</select>
			  </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金数额:</td>
              <td bgcolor="#FFFFFF">
				<div id="CommissionValue_fir" style="display:none"><input type="text" id="itemCommissionValue" name="itemInfo.itemCommissionValue" size="20" maxlength="20" value="<s:property value="itemInfo.itemCommissionValue"/>"/>
				<input type="hidden" id="itemCommissionValue_hidden" value="<s:property value="itemInfo.itemCommissionValue"/>"/>
				<span id="CommissionValue_sec" style="display:none">%</span>
				<span id="CommissionValue_thi" style="display:none">(请输入数字)</span><font id="commissionMsg" color="red"></font></div>
				<div id="CommissionValue_fou" style="display:none"> 分段收取，即拍卖成交价200万元以下的部分，收取5%；超过200万元至1000万元的部分，收取3%；
				超过1000万元至5000万元的部分，收取2%；超过5000万元至1亿元的部分，收取1%；超过1亿元的部分，收取0.5%。</div>
	
				
				<div id="CommissionValue_fou1" style="display:none">
				分段收取，即拍卖成交价50万元以下的部分，收取5%； 
				           50万元至200万元 的部分，收取3%；
				           200万元至500万元的部分，收取2%；
				           500万元至1000万元的部分，收取1.5%；
				           1000万元至2000万元的部分收取1%，
				           2000万元至5000万元的部分收取0.8%。
				           5000万元至1亿元的部分收取0.5%，
				                            超过1亿  0.2%，最高不得超过100万元
				
				</div>
				
				<div id="CommissionValue_fou2" style="display:none">
				分段收取，即拍卖成交价200万元以下的部分，收取3%； 
				           200万元至1000万元 的部分，收取1.5%；
				          1000万元至5000万元的部分，收取0.8%；
				           500万元至10000万元的部分，收取0.5%；
				           
				                            超过1亿  0.2%,最高不得超过50万元
				
				</div>
				
				<div id="CommissionValue_fou3" style="display:none">
				分段收取，即拍卖成交价50万元以下的部分，收取5%； 
				             50万元至200万元 的部分，收取3%；
				             200万元至1000万元的部分，收取2%；
				             1000万元至5000万元的部分，收取1%；
				             5000万元至1亿元的部分收取0.5%，
				                            超过1亿  0.3%
				
				</div>
			  </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>保证金:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="margin" name="itemInfo.margin" size="20" maxlength="10" value="<s:property value="itemInfo.margin"/>"/>
              <font id="omarginMsg" color="red"></font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>保证金限制:</td>
              <td bgcolor="#FFFFFF">
              	<select name="itemInfo.marginFlag" id="marginFlag">
              		<option value="0">请选择</option>
              		<s:if test="itemInfo.marginFlag == 1">
						<option value="1" selected="selected">是</option>
					</s:if>
					<s:else>
						<option value="1">是</option>
					</s:else>
              		<s:if test="itemInfo.marginFlag == 2">
						<option value="2" selected="selected">否</option>
					</s:if>
					<s:else>
						<option value="2">否</option>
					</s:else>
            	</select>
            	<br/><font color="red">(是表示竞买人成交后会扣除对应保证金，否则无需扣除对应保证金)</font>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">底价:</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="itemBasePrice" name="itemInfo.itemBasePrice" size="20" maxlength="10" value="<s:property value="itemInfo.itemBasePrice"/>"/>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">参考价:</td>
              <td bgcolor="#FFFFFF">
	              <input type="text" id="itemReferencePriceFir" name="itemInfo.itemReferencePriceFir" size="20" maxlength="10" value="<s:property value="itemInfo.itemReferencePriceFir"/>"/>&nbsp;--
	              <input type="text" id="itemReferencePriceSec" name="itemInfo.itemReferencePriceSec" size="20" maxlength="10" value="<s:property value="itemInfo.itemReferencePriceSec"/>"/>
	              <font id="oreferenceMsg" color="red"></font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">起拍价:</td>
              <td bgcolor="#FFFFFF">
	              <input type="text" id="itemPrice" name="itemInfo.itemPrice" size="20" maxlength="20" value="<s:property value="itemInfo.itemPrice"/>"/>
	              <br/><font color="red">(提示：录入起拍价【正数】，不填系统默认为0，核心竞买时起拍价为0的拍品需设置相应起拍价方能开拍)</font>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">拍卖组别:</td>
              <td bgcolor="#FFFFFF">
              	<select name="itemInfo.teamId" id="teamId">
              		<option value="0" selected="selected">请选择</option>
              		<s:iterator value="#request.auctionTeamTypeList" var="iaucTeamType_list" status="status">
              			<s:if test="itemInfo.teamId == #iaucTeamType_list.id">
              				<option value="<s:property value="#iaucTeamType_list.id"/>" selected="selected"><s:property value="#iaucTeamType_list.teamType"/></option>
              			</s:if>
              			<s:else>
              				<option value="<s:property value="#iaucTeamType_list.id"/>"><s:property value="#iaucTeamType_list.teamType"/></option>
              			</s:else>
           			</s:iterator>
              	</select>
              	<br/><font color="red">(在“拍品特定资质”中设置，为拍品设置组别后，只有拥有对应组别的竞买人方可对该拍品出价)</font>
              </td>
            </tr>
			
			<tr>
              <td align="right"  bgcolor="#FFFFFF">特别推荐拍品:</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.recommendFlag == 1">
              	<input type="checkbox" id="recommendFlag" name="recommendFlag"  checked="checked" />推荐
              	</s:if>
              	<s:else>
              	<input type="checkbox" id="recommendFlag" name="recommendFlag" />推荐
              	</s:else>
              	<br/><font color="red">(每场拍卖会只能推荐1个拍品)</font>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">是否允许设置代理价:</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.proxyPriceFlag == 1">
              	<input type="checkbox" id="proxyPriceFlag" name="proxyPriceFlag"  checked="checked"/>不允许
              	</s:if>
              	<s:else>
              	<input type="checkbox" id="proxyPriceFlag" name="proxyPriceFlag"  />不允许
              	</s:else>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">结果公开:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.publishFlag" id="publishFlag">
                	<s:if test="itemInfo.publishFlag == 0">
	               		<option value="0" selected="selected">否</option>
	               		<option value="1">是</option>
               		</s:if>
               		<s:if test="itemInfo.publishFlag == 1">
	               		<option value="0">否</option>
	               		<option value="1" selected="selected">是</option>
               		</s:if>
             	</select>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">委托变更状态:</td>
              <td bgcolor="#FFFFFF">
                <select name="delegatestate" id="delegatestate">
                	<s:if test="itemInfo.itemStatus == 7">
                		<option value="0">请选择</option>
              			<option value="1" selected="selected">撤销拍卖</option>
						<option value="2">暂缓拍卖</option>
                	</s:if>
                	<s:elseif test="itemInfo.itemStatus == 8">
                		<option value="0">请选择</option>
              			<option value="1">撤销拍卖</option>
						<option value="2" selected="selected">暂缓拍卖</option>
                	</s:elseif>
                	<s:else>
                		<option value="0" selected="selected">请选择</option>
              			<option value="1">撤销拍卖</option>
						<option value="2">暂缓拍卖</option>
                	</s:else>
                	
				</select>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">拍品描述:</td>
              <td bgcolor="#FFFFFF">
              	<textarea id="itemDescription" name="itemInfo.itemDescription" rows="10" cols="78"><s:property value="itemInfo.itemDescription"/></textarea>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍品模板:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.itemType" id="itemType" onchange="doChangeItemType(this.value)">
                	<option value="0">请选择</option>
                	<s:if test="itemInfo.itemType == 1">
                		<option value="1" selected="selected">房地产</option>
                	</s:if>
                	<s:else>
                		<option value="1">房地产</option>
                	</s:else>
                	<s:if test="itemInfo.itemType == 2">
                		<option value="2" selected="selected">机动车</option>
                	</s:if>
                	<s:else>
                		<option value="2">机动车</option>
                	</s:else>
                	<s:if test="itemInfo.itemType == 3">
                		<option value="3" selected="selected">物资设备</option>
                	</s:if>
                	<s:else>
                		<option value="3">物资设备</option>
                	</s:else>
              		<s:if test="itemInfo.itemType == 4">
                		<option value="4" selected="selected">股权</option>
                	</s:if>
                	<s:else>
                		<option value="4">股权</option>
                	</s:else>
					<s:if test="itemInfo.itemType == 5">
                		<option value="5" selected="selected">民品</option>
                	</s:if>
                	<s:else>
                		<option value="5">民品</option>
                	</s:else>
					<s:if test="itemInfo.itemType == 6">
                		<option value="6" selected="selected">文物艺术品</option>
                	</s:if>
                	<s:else>
                		<option value="6">文物艺术品</option>
                	</s:else>
					<s:if test="itemInfo.itemType == 7">
                		<option value="7" selected="selected">其他</option>
                	</s:if>
                	<s:else>
                		<option value="7">其他</option>
                	</s:else>
				</select>
			  </td>
            </tr>
                	
                	
                	
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车牌号码:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cphm" name="itemDetailInfo.cphm" size="20" maxlength="20" value="<s:property value="itemDetailInfo.cphm"/>"/>
					  <input type="hidden" id="cphm_hidden" value="<s:property value="itemDetailInfo.cphm"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车架号(VIN):</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cjhVIN" name="itemDetailInfo.cjhVIN" size="20" maxlength="20" value="<s:property value="itemDetailInfo.cjhVIN"/>"/>
					  <input type="hidden" id="cjhVIN_hidden" value="<s:property value="itemDetailInfo.cjhVIN"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">使用性质:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="syxz" name="itemDetailInfo.syxz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.syxz"/>"/>
					  <input type="hidden" id="syxz_hidden" value="<s:property value="itemDetailInfo.syxz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">表显里程:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="bxlc" name="itemDetailInfo.bxlc" size="20" maxlength="20" value="<s:property value="itemDetailInfo.bxlc"/>"/>
					  <input type="hidden" id="bxlc_hidden" value="<s:property value="itemDetailInfo.bxlc"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">登记启用日期:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="djqyrq" name="itemDetailInfo.djqyrq" size="20" maxlength="20" value="<s:property value="itemDetailInfo.djqyrq"/>"/>
					  <input type="hidden" id="djqyrq_hidden" value="<s:property value="itemDetailInfo.djqyrq"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照所在省份:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzszsf" name="itemDetailInfo.pzszsf" size="20" maxlength="20" value="<s:property value="itemDetailInfo.pzszsf"/>"/>
					  <input type="hidden" id="pzszsf_hidden" value="<s:property value="itemDetailInfo.pzszsf"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照所在城市:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzszcs" name="itemDetailInfo.pzszcs" size="20" maxlength="20" value="<s:property value="itemDetailInfo.pzszcs"/>"/>
					  <input type="hidden" id="pzszcs_hidden" value="<s:property value="itemDetailInfo.pzszcs"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照类型（公/私）:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzlx" name="itemDetailInfo.pzlx" size="20" maxlength="20" value="<s:property value="itemDetailInfo.pzlx"/>"/>
					  <input type="hidden" id="pzlx_hidden" value="<s:property value="itemDetailInfo.pzlx"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">拍卖是否含牌照:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pmsfhpz" name="itemDetailInfo.pmsfhpz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.pmsfhpz"/>"/>
					  <input type="hidden" id="pmsfhpz_hidden" value="<s:property value="itemDetailInfo.pmsfhpz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">年检到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="njdqny" name="itemDetailInfo.njdqny" size="20" maxlength="20" value="<s:property value="itemDetailInfo.njdqny"/>"/>
					  <input type="hidden" id="njdqny_hidden" value="<s:property value="itemDetailInfo.njdqny"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">保险到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="bxdqny" name="itemDetailInfo.bxdqny" size="20" maxlength="20" value="<s:property value="itemDetailInfo.bxdqny"/>"/>
					  <input type="hidden" id="bxdqny_hidden" value="<s:property value="itemDetailInfo.bxdqny"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">通行费到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="txfdqny" name="itemDetailInfo.txfdqny" size="20" maxlength="20" value="<s:property value="itemDetailInfo.txfdqny"/>"/>
					  <input type="hidden" id="txfdqny_hidden" value="<s:property value="itemDetailInfo.txfdqny"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车辆登记证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cldjz" name="itemDetailInfo.cldjz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.cldjz"/>"/>
					  <input type="hidden" id="cldjz_hidden" value="<s:property value="itemDetailInfo.cldjz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">原车合格证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ychgz" name="itemDetailInfo.ychgz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.ychgz"/>"/>
					  <input type="hidden" id="ychgz_hidden" value="<s:property value="itemDetailInfo.ychgz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">行驶证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="xsz" name="itemDetailInfo.xsz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.xsz"/>"/>
					  <input type="hidden" id="xsz_hidden" value="<s:property value="itemDetailInfo.xsz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">底卡:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="dk" name="itemDetailInfo.dk" size="20" maxlength="20" value="<s:property value="itemDetailInfo.dk"/>"/>
					  <input type="hidden" id="dk_hidden" value="<s:property value="itemDetailInfo.dk"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">购置税证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="gzsz" name="itemDetailInfo.gzsz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.gzsz"/>"/>
					  <input type="hidden" id="gzsz_hidden" value="<s:property value="itemDetailInfo.gzsz"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车船税:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ccs" name="itemDetailInfo.ccs" size="20" maxlength="20" value="<s:property value="itemDetailInfo.ccs"/>"/>
					  <input type="hidden" id="ccs_hidden" value="<s:property value="itemDetailInfo.ccs"/>"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">环保标志:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="hbbz" name="itemDetailInfo.hbbz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.hbbz"/>"/>
					  <input type="hidden" id="hbbz_hidden" value="<s:property value="itemDetailInfo.hbbz"/>"/>
					  </td>
				  </tr>
				  
			 
			  
				  
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb1" name="itemDetailInfo.lb1" size="20" maxlength="20" value="<s:property value="itemDetailInfo.lb1"/>"/>
					  <input type="hidden" id="lb1_hidden" value="<s:property value="itemDetailInfo.lb1"/>"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none"> 
					  <td align="right"  bgcolor="#FFFFFF">作者:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="zz" name="itemDetailInfo.zz" size="20" maxlength="20" value="<s:property value="itemDetailInfo.zz"/>"/>
					  <input type="hidden" id="zz_hidden" value="<s:property value="itemDetailInfo.zz"/>"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">年代:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="nd" name="itemDetailInfo.nd" size="20" maxlength="20" value="<s:property value="itemDetailInfo.nd"/>"/>
					  <input type="hidden" id="nd_hidden" value="<s:property value="itemDetailInfo.nd"/>"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">尺寸:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cc" name="itemDetailInfo.cc" size="20" maxlength="20" value="<s:property value="itemDetailInfo.cc"/>"/>
					  <input type="hidden" id="cc_hidden" value="<s:property value="itemDetailInfo.cc"/>"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="sl1" name="itemDetailInfo.sl1" size="20" maxlength="20" value="<s:property value="itemDetailInfo.sl1"/>"/>
					  <input type="hidden" id="sl1_hidden" value="<s:property value="itemDetailInfo.sl1"/>"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">款识:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ks" name="itemDetailInfo.ks" size="20" maxlength="20" value="<s:property value="itemDetailInfo.ks"/>"/>
					  <input type="hidden" id="ks_hidden" value="<s:property value="itemDetailInfo.ks"/>"/>
					  </td>
				  </tr>
				  
			  		
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb2" name="itemDetailInfo.lb2" size="20" maxlength="20" value="<s:property value="itemDetailInfo.lb2"/>"/>
					  <input type="hidden" id="lb2_hidden" value="<s:property value="itemDetailInfo.lb2"/>"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">土地使用权来源:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="tdsyqly" name="itemDetailInfo.tdsyqly" size="20" maxlength="20" value="<s:property value="itemDetailInfo.tdsyqly"/>"/>
					  <input type="hidden" id="tdsyqly_hidden" value="<s:property value="itemDetailInfo.tdsyqly"/>"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">建筑面积:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="jzmj" name="itemDetailInfo.jzmj" size="20" maxlength="20" value="<s:property value="itemDetailInfo.jzmj"/>"/>
					  <input type="hidden" id="jzmj_hidden" value="<s:property value="itemDetailInfo.jzmj"/>"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">交通状况:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="jtzk" name="itemDetailInfo.jtzk" size="20" maxlength="20" value="<s:property value="itemDetailInfo.jtzk"/>"/>
					  <input type="hidden" id="jtzk_hidden" value="<s:property value="itemDetailInfo.jtzk"/>"/>
					  </td>
				  </tr>
				  
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb3" name="itemDetailInfo.lb3" size="20" maxlength="20" value="<s:property value="itemDetailInfo.lb3"/>"/>
					  <input type="hidden" id="lb3_hidden" value="<s:property value="itemDetailInfo.lb3"/>"/>
					  </td>
				  </tr>
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">单位:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="dw" name="itemDetailInfo.dw" size="20" maxlength="20" value="<s:property value="itemDetailInfo.dw"/>"/>
					  <input type="hidden" id="dw_hidden" value="<s:property value="itemDetailInfo.dw"/>"/>
					  </td>
				  </tr>
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="sl2" name="itemDetailInfo.sl2" size="20" maxlength="20" value="<s:property value="itemDetailInfo.sl2"/>"/>
					  <input type="hidden" id="sl2_hidden" value="<s:property value="itemDetailInfo.sl2"/>"/>
					  </td>
				  </tr>
				 
                  
			  <tr>
	              <td align="center" bgcolor="#FFFFFF" colspan="2">
	              	<input class="large_btn"  type="button" value="提交 " onclick="doSubmit();" />
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
	var valuationMethod_val = '<s:property value="itemInfo.valuationMethod"/>';
	var countNumber_val = '<s:property value="itemInfo.countNumber"/>';
	var countUnit_val = '<s:property value="itemInfo.countUnit"/>';
	var itemCommissionType_val = '<s:property value="itemInfo.itemCommissionType"/>';
	var itemType_val = '<s:property value="itemInfo.itemType"/>';
	
	 if(valuationMethod_val == 1){
		$("#valuationMethod_fir")[0].checked = true;
		//$("#countNumber").attr("readonly","readonly");
	}
	if(valuationMethod_val == 2){
		$("#valuationMethod_sec")[0].checked = true;
		//$("#countNumber").attr("readonly","");
	} 
	
	if(countUnit_val == 11){
		$("#countContent_span").show();
	}else {
		$("#countContent_span").hide();
	}

	if(itemCommissionType_val == 1){
		$("#CommissionValue_fir").show();
		$("#CommissionValue_sec").show();
		$("#CommissionValue_thi").hide();
		$("#CommissionValue_fou").hide();
	}
	if(itemCommissionType_val == 2){
		$("#CommissionValue_fir").show();
		$("#CommissionValue_sec").hide();
		$("#CommissionValue_thi").show();
		$("#CommissionValue_fou").hide();
	}
	if(itemCommissionType_val == 3){
		$("#CommissionValue_fir").hide();
		$("#CommissionValue_sec").hide();
		$("#CommissionValue_thi").show();
		$("#CommissionValue_fou").show();
	}
	if(itemCommissionType_val == 4){
		$("#CommissionValue_fir").hide();
		$("#CommissionValue_sec").hide();
		$("#CommissionValue_thi").show();
		$("#CommissionValue_fou").hide();
		$("#CommissionValue_fou1").show();
	    $("#CommissionValue_fou2").hide();
	    $("#CommissionValue_fou3").hide();
	}
	if(itemCommissionType_val == 5){
		$("#CommissionValue_fir").hide();
		$("#CommissionValue_sec").hide();
		$("#CommissionValue_thi").show();
		$("#CommissionValue_fou").hide();
		$("#CommissionValue_fou1").hide();
	    $("#CommissionValue_fou2").show();
	    $("#CommissionValue_fou3").hide();
	}
	if(itemCommissionType_val == 6){
		$("#CommissionValue_fir").hide();
		$("#CommissionValue_sec").hide();
		$("#CommissionValue_thi").show();
		$("#CommissionValue_fou").hide();
		$("#CommissionValue_fou1").hide();
	    $("#CommissionValue_fou2").hide();
	    $("#CommissionValue_fou3").show();
	}
	
	if(itemType_val == 1){
		$(".mobile_span").hide();
		$(".art_span").hide();
		$(".house_span").show();
		$(".stock_span").hide();
	}
	if(itemType_val == 2){
		$(".mobile_span").show();
		$(".art_span").hide();
		$(".house_span").hide();
		$(".stock_span").hide();
	}
	if(itemType_val == 3){
		$(".mobile_span").hide();
		$(".art_span").hide();
		$(".house_span").hide();
		$(".stock_span").show();
	}
	if(itemType_val == 4){
		$(".mobile_span").hide();
		$(".art_span").hide();
		$(".house_span").hide();
		$(".stock_span").show();
	}
	if(itemType_val == 5){
		$(".mobile_span").hide();
		$(".art_span").hide();
		$(".house_span").hide();
		$(".stock_span").show();
	}
	if(itemType_val == 6){
		$(".mobile_span").hide();
		$(".art_span").show();
		$(".house_span").hide();
		$(".stock_span").hide();
	}
	if(itemType_val == 7){
		$(".mobile_span").hide();
		$(".art_span").hide();
		$(".house_span").hide();
		$(".stock_span").show();
	}


	function doClickValuationMethod(str){
		/* if(str == 1){
			$("#countNumber").val("1");
			$("#countNumber").attr("readonly","readonly");
		}
		if(str == 2){
			$("#countNumber").val(countNumber_val);
			$("#countNumber").attr("readonly","");
		} */
	}

	function doChangeCountUnit(str){
		if(str == 11){
			if(countUnit_val == 11){
				$("#countContent").val($("#countContent_hidden").val());
			}
			$("#countContent_span").show();
		}else{
			$("#countContent_span").hide();
		}
	}

	function doChangeCommissionType(str){
		if(str == 0){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").hide();
			$("#CommissionValue_fou").hide();
		}else if(str == 1){
			if(itemCommissionType_val == 1){
				$("#itemCommissionValue").val($("#itemCommissionValue_hidden").val());
			}else {
				$("#itemCommissionValue").val("");
			}
			$("#CommissionValue_fir").show();
			$("#CommissionValue_sec").show();
			$("#CommissionValue_thi").hide();
			$("#CommissionValue_fou").hide();
		}else if(str == 2){
			if(itemCommissionType_val == 2){
				$("#itemCommissionValue").val($("#itemCommissionValue_hidden").val());
			}else {
				$("#itemCommissionValue").val("");
			}
			$("#CommissionValue_fir").show();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou").hide();
		}else if(str == 3){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou").show();
			 $("#CommissionValue_fou1").hide();
			 $("#CommissionValue_fou2").hide();
			 $("#CommissionValue_fou3").hide();
		}
		else if(str == 4){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou1").show();
			 $("#CommissionValue_fou").hide();
			 $("#CommissionValue_fou2").hide();
			 $("#CommissionValue_fou3").hide();
		}
		else if(str == 5){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou2").show();
			 $("#CommissionValue_fou1").hide();
			 $("#CommissionValue_fou").hide();
			 $("#CommissionValue_fou3").hide();
		}
		else if(str == 6){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou3").show();
			 $("#CommissionValue_fou1").hide();
			 $("#CommissionValue_fou2").hide();
			 $("#CommissionValue_fou").hide();
		}
	}


	
	function doChangeItemType(str){
		if(str == 0){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").hide();
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 1){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").show();
			$(".stock_span").hide();

			if(itemType_val == 1){
				$("#lb2").val($("#lb2_hidden").val());
				$("#tdsyqly").val($("#tdsyqly_hidden").val());
				$("#jzmj").val($("#jzmj_hidden").val());
				$("#jtzk").val($("#jtzk_hidden").val());
			}
			
			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 2){
			$(".mobile_span").show();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").hide();
			if(itemType_val == 2){
				$("#cphm").val($("#cphm_hidden").val());
				$("#cjhVIN").val($("#cjhVIN_hidden").val());
				$("#syxz").val($("#syxz_hidden").val());
				$("#bxlc").val($("#bxlc_hidden").val());
				$("#djqyrq").val($("#djqyrq_hidden").val());
				$("#pzszsf").val($("#pzszsf_hidden").val());
				$("#pzszcs").val($("#pzszcs_hidden").val());
				$("#pzlx").val($("#pzlx_hidden").val());
				$("#pmsfhpz").val($("#pmsfhpz_hidden").val());
				$("#njdqny").val($("#njdqny_hidden").val());
				$("#bxdqny").val($("#bxdqny_hidden").val());
				$("#txfdqny").val($("#txfdqny_hidden").val());
				$("#cldjz").val($("#cldjz_hidden").val());
				$("#ychgz").val($("#ychgz_hidden").val());
				$("#xsz").val($("#xsz_hidden").val());
				$("#dk").val($("#dk_hidden").val());
				$("#gzsz").val($("#gzsz_hidden").val());
				$("#ccs").val($("#ccs_hidden").val());
				$("#hbbz").val($("#hbbz_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 3){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");
			
			if(itemType_val == 3){
				$("#lb3").val($("#lb3_hidden").val());
				$("#dw").val($("#dw_hidden").val());
				$("#sl2").val($("#sl2_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 4){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();
			
			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");
			
			if(itemType_val == 4){
				$("#lb3").val($("#lb3_hidden").val());
				$("#dw").val($("#dw_hidden").val());
				$("#sl2").val($("#sl2_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 5){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");
			
			if(itemType_val == 5){
				$("#lb3").val($("#lb3_hidden").val());
				$("#dw").val($("#dw_hidden").val());
				$("#sl2").val($("#sl2_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}else if(str == 6){
			$(".mobile_span").hide();
			$(".art_span").show();
			$(".house_span").hide();
			$(".stock_span").hide();

			if(itemType_val == 6){
				$("#lb1").val($("#lb1_hidden").val());
				$("#zz").val($("#zz_hidden").val());
				$("#nd").val($("#nd_hidden").val());
				$("#cc").val($("#cc_hidden").val());
				$("#sl1").val($("#sl1_hidden").val());
				$("#ks").val($("#ks_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");
		}else if(str == 7){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();

			$("#lb3").val("");
			$("#dw").val("");
			$("#sl2").val("");
			
			if(itemType_val == 7){
				$("#lb3").val($("#lb3_hidden").val());
				$("#dw").val($("#dw_hidden").val());
				$("#sl2").val($("#sl2_hidden").val());
			}
			
			$("#lb2").val("");
			$("#tdsyqly").val("");
			$("#jzmj").val("");
			$("#jtzk").val("");

			$("#cphm").val("");
			$("#cjhVIN").val("");
			$("#syxz").val("");
			$("#bxlc").val("");
			$("#djqyrq").val("");
			$("#pzszsf").val("");
			$("#pzszcs").val("");
			$("#pzlx").val("");
			$("#pmsfhpz").val("");
			$("#njdqny").val("");
			$("#bxdqny").val("");
			$("#txfdqny").val("");
			$("#cldjz").val("");
			$("#ychgz").val("");
			$("#xsz").val("");
			$("#dk").val("");
			$("#gzsz").val("");
			$("#ccs").val("");
			$("#hbbz").val("");

			$("#lb1").val("");
			$("#zz").val("");
			$("#nd").val("");
			$("#cc").val("");
			$("#sl1").val("");
			$("#ks").val("");
		}
	}

	
</script>
</body>
</html>
