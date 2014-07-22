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
<script type="text/javascript" src="/useeasy/auction/js/item/add.js" language="javascript"></script>
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
  				<div class="l">拍品新建(带<span style="color:red">*</span>的为必填项)</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="itemManage_index?auctionFlag=<s:property value="#request.auctionFlag"/>">【返回】</a> 
	  			</div>
	  			</div> 
	  		
	  		
	  		<form name="" action="" method="post">
	   		<input type="hidden" name="auctionFlag" value="<s:property value="#request.auctionFlag"/>"/>
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		<tr>
              <td align="right" width="150" bgcolor="#FFFFFF"><span style="color:red">*</span>拍品名称:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="itemName" name="itemInfo.itemName" size="50" maxlength="300"/></td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍品序号:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="itemNumber" name="itemInfo.itemNumber" size="20" maxlength="5"/>
              <br/><font color="red">(必须是数字，操作端在准备下一拍品时，通过这个顺序来控制拍卖顺序)</font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>显示编号:</td>
              <td bgcolor="#FFFFFF"><input type="text" id="viewOrder" name="itemInfo.viewOrder" size="20" maxlength="20"/>
              <br/><font color="red">(可以是任意字符，在拍品列表页面显示用，如:加1、+1等等)</font></td>
            </tr>
            
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖方式:</td>
              <td bgcolor="#FFFFFF">
              	<input type="radio" id="valuationMethod_fir" name="itemInfo.valuationMethod" value="1" onclick="doClickValuationMethod(this.value)" checked="checked"/>总价
              	<input type="radio" id="valuationMethod_sec" name="itemInfo.valuationMethod" value="2" onclick="doClickValuationMethod(this.value)"/>单价
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>数量:</td>
              <td bgcolor="#FFFFFF"><input type="text"  id="countNumber" name="itemInfo.countNumber" size="20" maxlength="20"/>
              <br/><font color="red">(输入相应的数量，比如房产的面积等)</font></td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>单位:</td>
              <td bgcolor="#FFFFFF">
             	 	<select id="countUnit" name="itemInfo.countUnit" onchange="doChangeCountUnit(this.value)">
             	 			<option value="0" selected="selected">请选择</option>
							<option value="1">件</option>
							<option value="2">台</option>
							<option value="3">个</option>
							<option value="4">批</option>
							<option value="5">组</option>
							<option value="6">平方米</option>
							<option value="7">吨</option>
							<option value="8">千克</option>
							<option value="9">股</option>
							<option value="10">辆</option>
							<option value="11">其他</option>
					</select>
					<span id="countContent_span" style="display:none">
                <input type="text" id="countContent" name="itemInfo.countContent" size="20" maxlength="20"/>
                </span>
			  </td>
            </tr>
			
			
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金方式:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.itemCommissionType" id="itemCommissionType" onchange="doChangeCommissionType(this.value)">
                		<option value="0" selected="selected">请选择</option>
                		<option value="1">固定比率</option>
						<option value="2">定额佣金</option>
						<option value="3">执行最高院司法规定</option>
						<option value="4">浙江省高级人民法院</option>
						<option value="5">慈溪市人民法院</option>
						<option value="6">镇海区人民法院</option>
				</select>
			  </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金数额:</td>
              <td bgcolor="#FFFFFF">
				<div id="CommissionValue_fir" style="display:none"><input type="text" id="itemCommissionValue" name="itemInfo.itemCommissionValue" size="20" maxlength="20"/>
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
              <td bgcolor="#FFFFFF"><input type="text" id="margin" name="itemInfo.margin" size="20" maxlength="10"/>
              <font id="omarginMsg" color="red"></font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>保证金限制:</td>
              <td bgcolor="#FFFFFF">
              	<select name="itemInfo.marginFlag" id="marginFlag">
              		<option value="0">请选择</option>
              		<option value="1">是</option>
              		<option value="2"  selected="selected">否</option>
            	</select>
            	<br/><font color="red">(是表示竞买人成交后会扣除对应保证金，否则无需扣除对应保证金)</font>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">底价:</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="itemBasePrice" name="itemInfo.itemBasePrice" size="20" maxlength="10"/>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">参考价:</td>
              <td bgcolor="#FFFFFF">
	              <input type="text" id="itemReferencePriceFir" name="itemInfo.itemReferencePriceFir" size="20" maxlength="10"/>&nbsp;--
	              <input type="text" id="itemReferencePriceSec" name="itemInfo.itemReferencePriceSec" size="20" maxlength="10"/>
	              <font id="oreferenceMsg" color="red"></font></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">起拍价:</td>
              <td bgcolor="#FFFFFF">
	              <input type="text" id="itemPrice" name="itemInfo.itemPrice" size="20" maxlength="20"/>
	              <br/><font color="red">(提示：录入起拍价【正数】，不填系统默认为0，核心竞买时起拍价为0的拍品需设置相应起拍价方能开拍)</font>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">拍卖组别:</td>
              <td bgcolor="#FFFFFF">
              	<select name="itemInfo.teamId" id="teamId">
              		<option value="0" selected="selected">请选择</option>
              		<s:iterator value="#request.auctionTeamTypeList" var="iaucTeamType_list" status="status">
              			<option value="<s:property value="#iaucTeamType_list.id"/>"><s:property value="#iaucTeamType_list.teamType"/></option>
              		</s:iterator>
              	</select>
              	<br/><font color="red">(在“拍品特定资质”中设置，为拍品设置组别后，只有拥有对应组别的竞买人方可对该拍品出价)</font>
              </td>
            </tr>
			
			<tr>
              <td align="right"  bgcolor="#FFFFFF">特别推荐拍品:</td>
              <td bgcolor="#FFFFFF">
              	<input type="checkbox" id="recommendFlag" name="recommendFlag" />推荐
              	<br/><font color="red">(每场拍卖会只能推荐1个拍品)</font>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">是否允许设置代理价:</td>
              <td bgcolor="#FFFFFF">
              	<input type="checkbox" id="proxyPriceFlag" name="proxyPriceFlag"/>不允许
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">结果公开:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.publishFlag" id="publishFlag">
               		<option value="0">否</option>
                	<option value="1" selected="selected">是</option>
             	</select>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">委托变更状态:</td>
              <td bgcolor="#FFFFFF">
                <select name="delegatestate" id="delegatestate">
                	<option value="0" selected="selected">请选择</option>
              		<option value="1">撤销拍卖</option>
					<option value="2">暂缓拍卖</option>
				</select>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">拍品描述:</td>
              <td bgcolor="#FFFFFF">
              	<textarea id="itemDescription" name="itemInfo.itemDescription" rows="10" cols="78"></textarea>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍品模板:</td>
              <td bgcolor="#FFFFFF">
                <select name="itemInfo.itemType" id="itemType" onchange="doChangeItemType(this.value)">
                	<option value="0" selected="selected">请选择</option>
              		<option value="1">房地产</option>
					<option value="2">机动车</option>
					<option value="3">物资设备</option>
					<option value="4">股权</option>
					<option value="5">民品</option>
					<option value="6">文物艺术品</option>
					<option value="7">其他</option>
				</select>
			  </td>
            </tr>
                
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车牌号码:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cphm" name="itemDetailInfo.cphm" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车架号(VIN):</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cjhVIN" name="itemDetailInfo.cjhVIN" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">使用性质:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="syxz" name="itemDetailInfo.syxz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">表显里程:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="bxlc" name="itemDetailInfo.bxlc" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">登记启用日期:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="djqyrq" name="itemDetailInfo.djqyrq" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照所在省份:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzszsf" name="itemDetailInfo.pzszsf" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照所在城市:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzszcs" name="itemDetailInfo.pzszcs" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">牌照类型（公/私）:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pzlx" name="itemDetailInfo.pzlx" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">拍卖是否含牌照:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="pmsfhpz" name="itemDetailInfo.pmsfhpz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">年检到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="njdqny" name="itemDetailInfo.njdqny" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">保险到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="bxdqny" name="itemDetailInfo.bxdqny" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">通行费到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="txfdqny" name="itemDetailInfo.txfdqny" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车辆登记证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cldjz" name="itemDetailInfo.cldjz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">原车合格证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ychgz" name="itemDetailInfo.ychgz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">行驶证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="xsz" name="itemDetailInfo.xsz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">底卡:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="dk" name="itemDetailInfo.dk" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">购置税证:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="gzsz" name="itemDetailInfo.gzsz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">车船税:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ccs" name="itemDetailInfo.ccs" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">环保标志:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="hbbz" name="itemDetailInfo.hbbz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  
			 
			  
				  
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb1" name="itemDetailInfo.lb1" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none"> 
					  <td align="right"  bgcolor="#FFFFFF">作者:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="zz" name="itemDetailInfo.zz" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">年代:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="nd" name="itemDetailInfo.nd" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">尺寸:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="cc" name="itemDetailInfo.cc" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="sl1" name="itemDetailInfo.sl1" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="art_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">款识:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="ks" name="itemDetailInfo.ks" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  
			  		
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb2" name="itemDetailInfo.lb2" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">土地使用权来源:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="tdsyqly" name="itemDetailInfo.tdsyqly" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">建筑面积:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="jzmj" name="itemDetailInfo.jzmj" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="house_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">交通状况:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="jtzk" name="itemDetailInfo.jtzk" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="lb3" name="itemDetailInfo.lb3" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">单位:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="dw" name="itemDetailInfo.dw" size="20" maxlength="20"/>
					  </td>
				  </tr>
				  <tr class="stock_span" style="display:none">
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <input type="text" id="sl2" name="itemDetailInfo.sl2" size="20" maxlength="20"/>
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
	function doClickValuationMethod(str){
		/* if(str == 1){
			$("#countNumber").val("1");
			$("#countNumber").attr("readonly","readonly");
		}
		if(str == 2){
			$("#countNumber").val("");
			$("#countNumber").attr("readonly","");
		} */
	}

	
	function doChangeCountUnit(str){
		if(str == 11){
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
			$("#CommissionValue_fir").show();
			$("#CommissionValue_sec").show();
			$("#CommissionValue_thi").hide();
			$("#CommissionValue_fou").hide();
		}else if(str == 2){
			$("#CommissionValue_fir").show();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou").hide();
		}else if(str == 3){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou").show();
		}else if(str == 4){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
			$("#CommissionValue_fou").hide();
			$("#CommissionValue_fou2").hide();
			$("#CommissionValue_fou3").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou1").show();
		}else if(str == 5){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
				$("#CommissionValue_fou").hide();
			$("#CommissionValue_fou1").hide();
			$("#CommissionValue_fou3").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou2").show();
		}else if(str == 6){
			$("#CommissionValue_fir").hide();
			$("#CommissionValue_sec").hide();
				$("#CommissionValue_fou").hide();
			$("#CommissionValue_fou2").hide();
			$("#CommissionValue_fou1").hide();
			$("#CommissionValue_thi").show();
			$("#CommissionValue_fou3").show();
		}
	}
	function doChangeItemType(str){
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
		if(str == 0){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").hide();
		}else if(str == 1){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").show();
			$(".stock_span").hide();
		}else if(str == 2){
			$(".mobile_span").show();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").hide();
		}else if(str == 3){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();
		}else if(str == 4){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();
		}else if(str == 5){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();
		}else if(str == 6){
			$(".mobile_span").hide();
			$(".art_span").show();
			$(".house_span").hide();
			$(".stock_span").hide();
		}else if(str == 7){
			$(".mobile_span").hide();
			$(".art_span").hide();
			$(".house_span").hide();
			$(".stock_span").show();
			
		}
	}

	
</script>
</body>
</html>
