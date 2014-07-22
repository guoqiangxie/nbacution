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
<script type="text/javascript" src="useeasy/auction/js/auction/edit.js" language="javascript"></script>
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
  				<div class="l">修改拍卖(带<span style="color:red">*</span>的为必填项)</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			<form name="" action="" method="post" enctype="multipart/form-data" >
	   		
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
	   		<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会名称</td>
              <td bgcolor="#ffffff" id="pcnameerr">
              <input type="text" id="auctionName" name="auctionInfo.auctionName" size="50" maxlength="50" value="<s:property value="auctionInfo.auctionName"/>"/>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF">拍卖会序号</td>
              <td bgcolor="#FFFFFF">
              <input type="text" readonly="readonly" name="auctionInfo.auctionNum" value="<s:property value="auctionInfo.auctionNum"/>"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会开始时间</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="auctionStartTime" name="auctionInfo.auctionStartTimeVal" readonly="readonly"
          		class="Wdate" size="20" maxlength="20" value="<s:date name='auctionInfo.auctionStartTime'  format='yyyy-MM-dd HH:mm'/>" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm',minDate:'%y-%M-%d %H:%m'})"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会地点</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="auctionAddress" name="auctionInfo.auctionAddress" size="70" maxlength="70" value="<s:property value="auctionInfo.auctionAddress"/>"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>联系电话</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="auctionLinkTel" name="auctionInfo.auctionLinkTel" size="30" maxlength="30" value="<s:property value="auctionInfo.auctionLinkTel"/>"/>
              <span><font color="red">（形式如:021-11111111或0511-1111111）</font></span>
              </td>
            </tr>
            <tr>
              <td width="180" align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖标的</td>
              <td bgcolor="#ffffff">
              	<select id="auctionType" name="auctionInfo.auctionType"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionType == 1">
								<option value="1" selected="selected">房地产</option>
							</s:if>
							<s:else>
								<option value="1">房地产</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 2">
								<option value="2" selected="selected">机动车</option>
							</s:if>
							<s:else>
								<option value="2">机动车</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 3">
								<option value="3" selected="selected">物资设备</option>
							</s:if>
							<s:else>
								<option value="3">物资设备</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 4">
								<option value="4" selected="selected">股权</option>
							</s:if>
							<s:else>
								<option value="4">股权</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 5">
								<option value="5" selected="selected">民品</option>
							</s:if>
							<s:else>
								<option value="5">民品</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 6">
								<option value="6" selected="selected">文物艺术品</option>
							</s:if>
							<s:else>
								<option value="6">文物艺术品</option>
							</s:else>
							<s:if test="auctionInfo.auctionType == 7">
								<option value="7" selected="selected">其他</option>
							</s:if>
							<s:else>
								<option value="7">其他</option>
							</s:else>
				</select>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>按拍卖会属性分类</td>
              <td bgcolor="#FFFFFF">
              	<select id="auctionNature" name="auctionInfo.auctionNature"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionNature == 1">
								<option value="1" selected="selected">专场拍卖会</option>
							</s:if>
							<s:else>
								<option value="1">专场拍卖会</option>
							</s:else>
							<s:if test="auctionInfo.auctionNature == 2">
								<option value="2" selected="selected">综合拍卖会</option>
							</s:if>
							<s:else>
								<option value="2">综合拍卖会</option>
							</s:else>
				</select>
			  </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖委托分类</td>
              <td bgcolor="#FFFFFF">
              	<select id="auctionDelegation" name="auctionInfo.auctionDelegation"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionDelegation == 1">
								<option value="1" selected="selected">司法委托拍卖</option>
							</s:if>
							<s:else>
								<option value="1">司法委托拍卖</option>
							</s:else>
							<s:if test="auctionInfo.auctionDelegation == 2">
								<option value="2" selected="selected">社会委托拍卖</option>
							</s:if>
							<s:else>
								<option value="2">社会委托拍卖</option>
							</s:else>
				</select>
			  </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会形式</td>
              <td bgcolor="#FFFFFF">
              	<select id="auctionForm" name="auctionInfo.auctionForm"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionForm == 1">
								<option value="1" selected="selected">网络同步拍卖</option>
							</s:if>
							<s:else>
								<option value="1">网络同步拍卖</option>
							</s:else>
							<s:if test="auctionInfo.auctionForm == 2">
								<option value="2" selected="selected">现场拍卖</option>
							</s:if>
							<s:else>
								<option value="2">现场拍卖</option>
							</s:else>
				</select>
			  </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>最大在线观摩人数</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="auctionOnlineMaxUser" name="auctionInfo.auctionOnlineMaxUser" size="10" maxlength="10" value="<s:property value="auctionInfo.auctionOnlineMaxUser"/>"/>
			  	<span><font color="red">（最大人数为50人）</font></span>
			  </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否开通网上支付</td>
              <td bgcolor="#FFFFFF">
              	<s:if test="#session._listener.auctionCompany.ebankFlag != 1">
              		否<font color="red">（无有效银行支付接口）</font>
              	</s:if>
              	<s:else>
              	<select id="auctionWebPay" name="auctionInfo.auctionWebPay" onchange="doChangeWebPay(this.value)"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionWebPay == 1">
								<option value="1" selected="selected">是</option>
							</s:if>
							<s:else>
								<option value="1">是</option>
							</s:else>
							<s:if test="auctionInfo.auctionWebPay == 2">
								<option value="2" selected="selected">否</option>
							</s:if>
							<s:else>
								<option value="2">否</option>
							</s:else>
				</select>
				</s:else>
			  </td>
            </tr>
            <tr id="webPayTrFir" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否审核网络交付保证金</td>
              <td bgcolor="#FFFFFF">
              	<select id="auctionWebPayCheck" name="auctionInfo.auctionWebPayCheck" onclick="doSelectAutoPay(this.value)">
              				<option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionWebPayCheck == 1">
								<option value="1" selected="selected">是</option>
							</s:if>
							<s:else>
								<option value="1">是</option>
							</s:else>
							<s:if test="auctionInfo.auctionWebPayCheck == 2">
								<option value="2" selected="selected">否</option>
							</s:if>
							<s:else>
								<option value="2">否</option>
							</s:else>
				</select>
			  </td>
            </tr>
            <tr id="autoBidNum_div" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>自动牌号</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="autoBidNum" name="auctionInfo.autoBidNum" size="20" maxlength="10" value="<s:property value="auctionInfo.autoBidNum"/>"/>
			  </td>
            </tr>
            <tr id="webPayTrSec" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>最大保证金</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="auctionMarginMax" name="auctionInfo.auctionMarginMax" size="20" maxlength="10" value="<s:property value="auctionInfo.auctionMarginMax"/>"/>
			  </td>
            </tr>
            <tr id="webPayTrThi" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>第一档保证金(最小保证金)</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="auctionMarginLevelFir" name="auctionInfo.auctionMarginLevelFir" size="20" maxlength="10" value="<s:property value="auctionInfo.auctionMarginLevelFir"/>"/>
			  </td>
            </tr>
            <tr id="webPayTrFou" style="display:none">
              <td align="right" bgcolor="#FFFFFF">第二档保证金</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="auctionMarginLevelSec" name="auctionInfo.auctionMarginLevelSec" size="20" maxlength="10" value="<s:property value="auctionInfo.auctionMarginLevelSec"/>"/>
			  </td>
            </tr>
            <tr id="webPayTrFif" style="display:none">
              <td align="right" bgcolor="#FFFFFF">第三档保证金</td>
              <td bgcolor="#FFFFFF">
              	<input type="text" id="auctionMarginLevelThi" name="auctionInfo.auctionMarginLevelThi" size="20" maxlength="10" value="<s:property value="auctionInfo.auctionMarginLevelThi"/>"/>
			  </td>
            </tr>
			<tr id="webPayTrSix" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否保证金抵扣货款</td>
              <td bgcolor="#FFFFFF">
              	<select id="auctionWebPayGoods" name="auctionInfo.auctionWebPayGoods"><option value="0" selected="selected">请选择</option>
							<s:if test="auctionInfo.auctionWebPayGoods == 1">
								<option value="1" selected="selected">是</option>
							</s:if>
							<s:else>
								<option value="1">是</option>
							</s:else>
							<s:if test="auctionInfo.auctionWebPayGoods == 2">
								<option value="2" selected="selected">否</option>
							</s:if>
							<s:else>
								<option value="2">否</option>
							</s:else>
				</select>
			  </td>
            </tr>
            
            
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会图标</td>
              <td bgcolor="#FFFFFF">
				<table>
					<tr>
						<td bgcolor="#FFFFFF">
							<input type="radio" id="auctionPicType_fir" name="auctionInfo.auctionPicType" value="1" onclick="doClickPicType(1)"/>拍卖公司图标<br/>
							<input type="radio" id="auctionPicType_sec" name="auctionInfo.auctionPicType" value="2" onclick="doClickPicType(2)"/>专场拍卖会图标
							<span id="auctionPicValSpan"><select id="auctionPicVal" name="auctionPicVal" onchange="doChangePicType(this.value)"><option value="0" selected="selected">请选择</option>
								<s:if test="auctionInfo.auctionPicVal == 1">
									<option value="1" selected="selected">机动车</option>
								</s:if>
								<s:else>
									<option value="1">机动车</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 2">
									<option value="2" selected="selected">文物艺术品</option>
								</s:if>
								<s:else>
									<option value="2">文物艺术品</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 3">
									<option value="3" selected="selected">房地产</option>
								</s:if>
								<s:else>
									<option value="3">房地产</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 4">
									<option value="4" selected="selected">股权</option>
								</s:if>
								<s:else>
									<option value="4">股权</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 5">
									<option value="5" selected="selected">物资设备</option>
								</s:if>
								<s:else>
									<option value="5">物资设备</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 6">
									<option value="6" selected="selected">民品</option>
								</s:if>
								<s:else>
									<option value="6">民品</option>
								</s:else>
								<s:if test="auctionInfo.auctionPicVal == 7">
									<option value="7" selected="selected">其他</option>
								</s:if>
								<s:else>
									<option value="7">其他</option>
								</s:else>
							</select>
							</span>
							<br/>
							<input type="radio" id="auctionPicType_thi" name="auctionInfo.auctionPicType" value="3" onclick="doClickPicType(3)"/>自定义图标
							<span id="auctionPicValFileSpan">
							<br/>
							<input type="file" id="u_file" name="u_file" size="15"/>
              				<input  type=button value="上传 "  onclick="doUpload();"/>
							</span>
							<br/><span style="color:red">( 图片格式为.jpeg|.jpg|.gif，不大于2M )</span>
						</td>
						<td bgcolor="#FFFFFF" id="picErrorMsg">
							<span id="auctionUpLoadImgSpanFir"><img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" id="auctionUpLoadImgFir" height="150"></img></span>
							<span id="auctionUpLoadImgSpanSec"><img src="<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>" id="auctionUpLoadImgSec" height="150"></img></span>
							<span id="auctionUpLoadImgSpanThi"><img src="<%=request.getContextPath()%><s:property value=''/>" id="auctionUpLoadImgThi" height="150"></img></span>
							<span id="auctionUpLoadImgSpanFou"><img src="<%=request.getContextPath()%><s:property value=''/>" id="auctionUpLoadImgFou" height="150"></img></span>
							<input type="hidden" id="customPicVal" name="customPicVal"/>
							<iframe id="uploadTarget" name="uploadTarget" style="display:none"></iframe>
						</td>
						
					</tr>
				</table>
				</td>
            </tr>
			
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖会简称</td>
              <td bgcolor="#FFFFFF">
              <input type="text" id="auctionShortName" name="auctionInfo.auctionShortName" size="20" maxlength="15" value="<s:property value="auctionInfo.auctionShortName"/>"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖公告</td>
              <td bgcolor="#FFFFFF">
              <textarea id="auctionBulletin" name="auctionInfo.auctionBulletin" rows="10" cols="60"><s:property value="auctionInfo.auctionBulletin"/></textarea>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖规则</td>
              <td bgcolor="#FFFFFF">
              <textarea id="auctionNotice" name="auctionInfo.auctionNotice" rows="10" cols="60"><s:property value="auctionInfo.auctionNotice"/></textarea>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF">特别规定</td>
              <td bgcolor="#FFFFFF">
              <textarea id="auctionGuide" name="auctionInfo.auctionGuide" rows="10" cols="60"><s:property value="auctionInfo.auctionGuide"/></textarea>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">备注说明</td>
              <td bgcolor="#FFFFFF">
              <textarea id="auctionDescription" name="auctionInfo.auctionDescription" rows="10" cols="60"><s:property value="auctionInfo.auctionDescription"/></textarea>
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
<s:if test='auctionInfo.auctionWebPay == 1'>
	<script language="javascript" type="text/javascript">
	$("#webPayTrFir").show();
	$("#webPayTrSec").show();
	$("#webPayTrThi").show();
	$("#webPayTrFou").show();
	$("#webPayTrFif").show();
	$("#webPayTrSix").show();
	$("#autoBidNum_div").show();
	
	</script>
</s:if>
<s:if test='auctionInfo.auctionWebPay == 2'>
	<script language="javascript" type="text/javascript">
	$("#webPayTrFir").hide();
	$("#webPayTrSec").hide();
	$("#webPayTrThi").hide();
	$("#webPayTrFou").hide();
	$("#webPayTrFif").hide();
	$("#webPayTrSix").hide();
	$("#autoBidNum_div").hide();
	</script>
</s:if>
<s:if test='auctionInfo.auctionWebPayCheck == 1'>
	<script language="javascript" type="text/javascript">
	$("#autoBidNum_div").hide();
	</script>
</s:if>
<s:if test='auctionInfo.auctionWebPayCheck == 2'>
	<script language="javascript" type="text/javascript">
	$("#autoBidNum_div").show();
	</script>
</s:if>

<s:if test='auctionInfo.auctionPicType == 1'>
	<script language="javascript" type="text/javascript">
	$("#auctionPicType_fir")[0].checked = true;
	$("#auctionPicValSpan").hide();
	$("#auctionPicValFileSpan").hide();
	$("#auctionUpLoadImgSpanFir").show();
	$("#auctionUpLoadImgSpanSec").hide();
	$("#auctionUpLoadImgSpanThi").hide();
	$("#auctionUpLoadImgSpanFou").hide();
	$("#auctionUpLoadImgFir").attr("src","<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>");
	$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	$("#auctionUpLoadImgThi").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	</script>
</s:if>
<s:if test='auctionInfo.auctionPicType == 2'>
	<script language="javascript" type="text/javascript">
		$("#auctionPicType_sec")[0].checked = true;
		$("#auctionPicValSpan").show();
		$("#auctionPicValFileSpan").hide();
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").show();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").hide();
		$("#auctionUpLoadImgFir").attr("src","<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>");
		$("#auctionUpLoadImgThi").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	</script>
	<s:if test='auctionInfo.auctionPicVal == 1'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 2'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 3'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 4'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 5'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 6'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg");
		</script>
	</s:if>
	<s:if test='auctionInfo.auctionPicVal == 7'>
		<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg");
		</script>
	</s:if>
</s:if>
<s:if test='auctionInfo.auctionPicType == 3'>
	<script language="javascript" type="text/javascript">
	$("#auctionPicType_thi")[0].checked = true;
	$("#auctionPicValSpan").hide();
	$("#auctionPicValFileSpan").show();
	$("#auctionUpLoadImgSpanFir").hide();
	$("#auctionUpLoadImgSpanSec").hide();
	$("#auctionUpLoadImgSpanThi").show();
	$("#auctionUpLoadImgSpanFou").hide();
	$("#auctionUpLoadImgFir").attr("src","<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>");
	$("#auctionUpLoadImgSec").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	$("#auctionUpLoadImgThi").attr("src","<%=request.getContextPath()%><s:property value='auctionInfo.auctionPicUrl'/>");
	
	</script>
</s:if>

<script language="javascript" type="text/javascript">
function doChangeWebPay(str){
	if(str == 0){
		$("#webPayTrFir").hide();
		$("#webPayTrSec").hide();
		$("#webPayTrThi").hide();
		$("#webPayTrFou").hide();
		$("#webPayTrFif").hide();
		$("#webPayTrSix").hide();
		
		$("#autoBidNum_div").hide();
	}
	if(str == 1){
		$("#webPayTrFir").show();
		$("#webPayTrSec").show();
		$("#webPayTrThi").show();
		$("#webPayTrFou").show();
		$("#webPayTrFif").show();
		$("#webPayTrSix").show();
		
		if($("#auctionWebPayCheck").val() == 2){
			$("#autoBidNum_div").show();
		}
	}
	if(str == 2){
		$("#webPayTrFir").hide();
		$("#webPayTrSec").hide();
		$("#webPayTrThi").hide();
		$("#webPayTrFou").hide();
		$("#webPayTrFif").hide();
		$("#webPayTrSix").hide();
		
		$("#autoBidNum_div").hide();
	}
}
function doClickPicType(str){
	if(str == 1){
		$("#auctionPicValSpan").hide();
		$("#auctionPicValFileSpan").hide();
		$("#auctionUpLoadImgSpanFir").show();
		$("#auctionUpLoadImgSpanSec").hide();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").hide();
	}
	if(str == 2){
		var type_val = '<s:property value='auctionInfo.auctionPicType'/>';
		if(type_val == 2){
			var type_pic = '<s:property value='auctionInfo.auctionPicVal'/>';
			$("#auctionPicVal").val(type_pic);
		}else{
			$("#auctionPicVal").val(0);
		}
		$("#auctionPicValSpan").show();
		$("#auctionPicValFileSpan").hide();
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").show();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").hide();
	}				
	if(str == 3){
		$("#auctionPicValSpan").hide();
		$("#auctionPicValFileSpan").show();
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").hide();
		$("#auctionUpLoadImgSpanThi").show();
		$("#auctionUpLoadImgSpanFou").hide();
	}	
}
function doChangePicType(str){
	$("#auctionUpLoadImgSpanSec").hide();
	$("#auctionUpLoadImgSpanFou").show();
	if(str == 0){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg");
	}
	if(str == 1){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg");
	}
	if(str == 2){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg");
	}				
	if(str == 3){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg");
	}
	if(str == 4){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg");
	}
	if(str == 5){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg");
	}
	if(str == 6){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg");
	}
	if(str == 7){
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg");
	}	
}

function doChangePicArea(str){
	if(str == "-1"){
		$(".large_btn").show();
		alert("文件上传失败！");
	}else if(str == "-2"){
		$(".large_btn").show();
		alert("文件上传出现异常！");
	}else{
		$(".large_btn").show();
		$("#auctionPicValSpan").hide();
		$("#auctionPicValFileSpan").show();
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").hide();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").show();
		$("#customPicVal").val(str.substring(str.indexOf(",")+1));
		$("#auctionUpLoadImgFou").attr("src","<%=request.getContextPath()%>"+str.substring(0,str.indexOf(",")));
	}
}
function doSelectAutoPay(str){
	if(str == 0){
		$("#autoBidNum_div").hide();
	}
	if(str == 1){
		$("#autoBidNum_div").hide();
	}
	if(str == 2){
		$("#autoBidNum_div").show();
	}
}
</script>
</body>
</html>
