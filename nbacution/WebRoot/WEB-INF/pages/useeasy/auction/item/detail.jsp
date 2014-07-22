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
              <td bgcolor="#FFFFFF"><s:property value="itemInfo.itemName"/></td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍品序号:</td>
              <td bgcolor="#FFFFFF"><s:property value="itemInfo.itemNumber"/></td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>显示编号:</td>
              <td bgcolor="#FFFFFF"><s:property value="itemInfo.viewOrder"/></td>
            </tr>
            
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖方式:</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.valuationMethod == 1">总价</s:if>
              	<s:else>单价</s:else>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>数量:</td>
              <td bgcolor="#FFFFFF">
              <s:if test="itemInfo.valuationMethod == 1">1
              </s:if>
              <s:else>
              	<s:property value="itemInfo.countNumber"/>
              </s:else>
              </td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>单位:</td>
              <td bgcolor="#FFFFFF">
             	 	<s:if test="itemInfo.countUnit == 1">
						件
					</s:if>
					<s:if test="itemInfo.countUnit == 2">
						台
					</s:if>
					<s:if test="itemInfo.countUnit == 3">
						个
					</s:if>
					<s:if test="itemInfo.countUnit == 4">
						批
					</s:if>
					<s:if test="itemInfo.countUnit == 5">
						组
					</s:if>
					<s:if test="itemInfo.countUnit == 6">
						平方米
					</s:if>
					<s:if test="itemInfo.countUnit == 7">
						吨
					</s:if>
					<s:if test="itemInfo.countUnit == 8">
						千克
					</s:if>
					<s:if test="itemInfo.countUnit == 9">
						股
					</s:if>
					<s:if test="itemInfo.countUnit == 10">
						辆
					</s:if>
					<s:if test="itemInfo.countUnit == 11">
						其他
					</s:if>
					<span id="countContent_span" >
               	 		<s:property value="itemInfo.countContent"/>
                	</span>
			  </td>
            </tr>
			
			
			<tr>
              	<td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金方式:dsdsd</td>
              	<td bgcolor="#FFFFFF">
                <s:if test="itemInfo.itemCommissionType == 1">
					固定比率
				</s:if>
				<s:if test="itemInfo.itemCommissionType == 2">
					定额佣金
				</s:if>
				<s:if test="itemInfo.itemCommissionType == 3">
					执行最高院司法规定
				</s:if>
			    <s:if test="itemInfo.itemCommissionType == 4">
							<option value="4" selected="selected">浙江省高级人民法院</option>
				 </s:if>
				 <s:elseif test="itemInfo.itemCommissionType == 5">
				 <option value="5" selected="selected">慈溪市人民法院</option>
				 </s:elseif>
				 <s:elseif test="itemInfo.itemCommissionType == 6">
				 <option value="6" selected="selected">镇海区人民法院</option>
				 </s:elseif>
				</td>
            </tr>
			<tr>
              	<td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>佣金数额:</td>
              	<td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.itemCommissionType == 1">
              		<s:property value="itemInfo.itemCommissionValue"/>%
              	</s:if>
              	<s:if test="itemInfo.itemCommissionType == 2">
              		<s:property value="itemInfo.itemCommissionValue"/>元
              	</s:if>
              	<s:if test="itemInfo.itemCommissionType == 3">
              		分段收取，即拍卖成交价50万元以下的部分，收取5%； 
				           50万元至200万元 的部分，收取3%；
				           200万元至500万元的部分，收取2%；
				           500万元至1000万元的部分，收取1.5%；
				           1000万元至2000万元的部分收取1%，
				           2000万元至5000万元的部分收取0.8%。
				           5000万元至1亿元的部分收取0.5%，
				                            超过1亿  0.2%，最高不得超过100万元
              	</s:if>
				</td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>保证金:</td>
              <td bgcolor="#FFFFFF"><s:property value="itemInfo.margin"/></td>
            </tr>
            <tr>
              	<td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>保证金限制:</td>
              	<td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.marginFlag == 1">
					是
				</s:if>
				<s:if test="itemInfo.marginFlag == 2">
					否
				</s:if>
				</td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">底价:</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="itemInfo.itemBasePrice"/>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">参考价:</td>
              <td bgcolor="#FFFFFF">
	              <s:property value="itemInfo.itemReferencePriceFir"/>&nbsp;--
	              <s:property value="itemInfo.itemReferencePriceSec"/>
	          </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">起拍价:</td>
              <td bgcolor="#FFFFFF">
	              <s:property value="itemInfo.itemPrice"/>
              </td>
            </tr>
            <tr>
              	<td align="right"  bgcolor="#FFFFFF">拍卖组别:</td>
              	<td bgcolor="#FFFFFF">
              	<s:iterator value="#request.auctionTeamTypeList" var="iaucTeamType_list" status="status">
              		<s:if test="itemInfo.teamId == #iaucTeamType_list.id">
              				<s:property value="#iaucTeamType_list.teamType"/>
              		</s:if>
              	</s:iterator>
              	</td>
            </tr>
			
			<tr>
              <td align="right"  bgcolor="#FFFFFF">特别推荐拍品:</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.recommendFlag == 1">
              	推荐
              	</s:if>
              	<s:else>
              	--
              	</s:else>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">是否允许设置代理价:</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="itemInfo.proxyPriceFlag == 1">
              	不允许
              	</s:if>
              	<s:else>
              	允许
              	</s:else>
              </td>
            </tr>
            <tr>
              	<td align="right"  bgcolor="#FFFFFF">结果公开:</td>
              	<td bgcolor="#FFFFFF">
                <s:if test="itemInfo.publishFlag == 0">
               		不公开
               	</s:if>
               	<s:if test="itemInfo.publishFlag == 1">
            		公开
	            </s:if>
             	</td>
            </tr>
			<tr>
              	<td align="right"  bgcolor="#FFFFFF">委托变更状态:</td>
              	<td bgcolor="#FFFFFF">
                <s:if test="itemInfo.itemStatus == 7">
                	撤销拍卖
				</s:if>
                <s:elseif test="itemInfo.itemStatus == 8">
                	暂缓拍卖
                </s:elseif>
                <s:else>
                	--	
                </s:else>
               	</td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF">图片:</td>
              <td bgcolor="#FFFFFF">
              	<s:iterator value="#request.itemPicInfoList" var="iPicInfo_list" status="status">
              		<s:if test="#status.index+1 < 5">
              		<img src="<%=request.getContextPath()%><s:property value="#iPicInfo_list.uploadUrl"/>" height="90" width="120"/>
              		</s:if>
           		</s:iterator>
              </td>
            </tr>
            <tr>
              <td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍品描述:</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="itemInfo.itemDescription"/>
              </td>
            </tr>
            
            
            <tr>
              	<td align="right"  bgcolor="#FFFFFF"><span style="color:red">*</span>拍品模板:</td>
              	<td bgcolor="#FFFFFF">
               	<s:if test="itemInfo.itemType == 1">
                	房地产
                </s:if>
                <s:if test="itemInfo.itemType == 2">
                	机动车
                </s:if>
                <s:if test="itemInfo.itemType == 3">
                	物资设备
                </s:if>
                <s:if test="itemInfo.itemType == 4">
                	股权
                </s:if>
                <s:if test="itemInfo.itemType == 5">
                	民品
                </s:if>
                <s:if test="itemInfo.itemType == 6">
                	文物艺术品
                </s:if>
                <s:if test="itemInfo.itemType == 7">
                	其他
                </s:if>
               	</td>
            </tr>
            
             	<s:if test="itemInfo.itemType == 2">
               	<tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">车牌号码:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.cphm"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">车架号(VIN):</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.cjhVIN"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">使用性质:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.syxz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">表显里程:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.bxlc"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">登记启用日期:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.djqyrq"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">牌照所在省份:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.pzszsf"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">牌照所在城市:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.pzszcs"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">牌照类型（公/私）:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.pzlx"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">拍卖是否含牌照:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.pmsfhpz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">年检到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.njdqny"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">保险到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.bxdqny"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">通行费到期年月:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.txfdqny"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">车辆登记证:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.cldjz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">原车合格证:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.ychgz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">行驶证:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.xsz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">底卡:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.dk"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">购置税证:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.gzsz"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">车船税:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.ccs"/>
					  </td>
				  </tr>
				  <tr class="mobile_span" >
					  <td align="right"  bgcolor="#FFFFFF">环保标志:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.hbbz"/>
					  </td>
				  </tr>
				  </s:if>
			 
			  
				  <s:elseif test="itemInfo.itemType == 6">
				  <tr class="art_span" >
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.lb1"/>
					  </td>
				  </tr>
				  <tr class="art_span" > 
					  <td align="right"  bgcolor="#FFFFFF">作者:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.zz"/>
					  </td>
				  </tr>
				  <tr class="art_span" >
					  <td align="right"  bgcolor="#FFFFFF">年代:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.nd"/>
					  </td>
				  </tr>
				  <tr class="art_span" >
					  <td align="right"  bgcolor="#FFFFFF">尺寸:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.cc"/>
					  </td>
				  </tr>
				  <tr class="art_span" >
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.sl1"/>
					  </td>
				  </tr>
				  <tr class="art_span" >
					  <td align="right"  bgcolor="#FFFFFF">款识:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.ks"/>
					  </td>
				  </tr>
				  </s:elseif>
			  		
			  		<s:elseif test="itemInfo.itemType == 1">
				  <tr class="house_span" >
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.lb2"/>
					  </td>
				  </tr>
				  <tr class="house_span" >
					  <td align="right"  bgcolor="#FFFFFF">土地使用权来源:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.tdsyqly"/>
					  </td>
				  </tr>
				  <tr class="house_span" >
					  <td align="right"  bgcolor="#FFFFFF">建筑面积:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.jzmj"/>
					  </td>
				  </tr>
				  <tr class="house_span" >
					  <td align="right"  bgcolor="#FFFFFF">交通状况:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.jtzk"/>
					  </td>
				  </tr>
				  </s:elseif>
				  
				  <s:else>
				  <tr class="stock_span" >
					  <td align="right"  bgcolor="#FFFFFF">类别:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.lb3"/>
					  </td>
				  </tr>
				  <tr class="stock_span" >
					  <td align="right"  bgcolor="#FFFFFF">单位:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.dw"/>
					  </td>
				  </tr>
				  <tr class="stock_span" >
					  <td align="right"  bgcolor="#FFFFFF">数量:</td>
					  <td bgcolor="#FFFFFF">
					  <s:property value="itemDetailInfo.sl2"/>
					  </td>
				  </tr>
				 </s:else>
                  
			  
          </table>
          
          </form>
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>

</body>
</html>
