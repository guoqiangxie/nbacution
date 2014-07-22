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
              <s:property value="auctionInfo.auctionName"/>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF">拍卖会序号</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionNum"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会开始时间</td>
              <td bgcolor="#FFFFFF">
              	<s:date name="auctionInfo.auctionStartTime" format="yyyy-MM-dd HH:mm"/>
              	
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会地点</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionAddress"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>联系电话</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionLinkTel"/>
              </td>
            </tr>
            <tr>
              <td width="180" align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖标的</td>
              <td bgcolor="#ffffff">
              				<s:if test="auctionInfo.auctionType == 1">
								房地产
							</s:if>
							<s:if test="auctionInfo.auctionType == 2">
								机动车
							</s:if>
							<s:if test="auctionInfo.auctionType == 3">
								物资设备
							</s:if>
							<s:if test="auctionInfo.auctionType == 4">
								股权
							</s:if>
							<s:if test="auctionInfo.auctionType == 5">
								民品
							</s:if>
							<s:if test="auctionInfo.auctionType == 6">
								文物艺术品
							</s:if>
							<s:if test="auctionInfo.auctionType == 7">
								其他
							</s:if>
				</td>
            </tr>
            <tr>
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>按拍卖会属性分类</td>
              	<td bgcolor="#FFFFFF">
            	<s:if test="auctionInfo.auctionNature == 1">
					专场拍卖会
				</s:if>
				<s:if test="auctionInfo.auctionNature == 2">
					综合拍卖会
				</s:if>
				</td>
            </tr>
			<tr>
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖委托分类</td>
           	 	<td bgcolor="#FFFFFF">
              	<s:if test="auctionInfo.auctionDelegation == 1">
					司法委托拍卖
				</s:if>
				<s:if test="auctionInfo.auctionDelegation == 2">
					社会委托拍卖
				</s:if>
				</td>
            </tr>
			<tr>
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会形式</td>
              	<td bgcolor="#FFFFFF">
              	<s:if test="auctionInfo.auctionForm == 1">
					网络同步拍卖
				</s:if>
				<s:if test="auctionInfo.auctionForm == 2">
					现场拍卖
				</s:if>
				</td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>最大在线观摩人数</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.auctionOnlineMaxUser"/>
			  </td>
            </tr>
            <tr>
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否开通网上支付</td>
              	<td bgcolor="#FFFFFF">
              	<s:if test="auctionInfo.auctionWebPay == 1">
					是
				</s:if>
				<s:if test="auctionInfo.auctionWebPay == 2">
					否
				</s:if>
				</td>
            </tr>
            <tr id="webPayTrFir" style="display:none">
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否审核网络交付保证金</td>
           	 	<td bgcolor="#FFFFFF">
           		<s:if test="auctionInfo.auctionWebPayCheck == 1">
					是
				</s:if>
				<s:if test="auctionInfo.auctionWebPayCheck == 2">
					否
				</s:if>
				</td>
            </tr>
            <tr id="autoBidNum_div" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>自动牌号</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.autoBidNum"/>
			  </td>
            </tr>
            <tr id="webPayTrSec" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>最大保证金</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.auctionMarginMax"/>
			  </td>
            </tr>
            <tr id="webPayTrThi" style="display:none">
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>第一档保证金(最小保证金)</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.auctionMarginLevelFir"/>
			  </td>
            </tr>
            <tr id="webPayTrFou" style="display:none">
              <td align="right" bgcolor="#FFFFFF">第二档保证金</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.auctionMarginLevelSec"/>
			  </td>
            </tr>
            <tr id="webPayTrFif" style="display:none">
              <td align="right" bgcolor="#FFFFFF">第三档保证金</td>
              <td bgcolor="#FFFFFF">
              	<s:property value="auctionInfo.auctionMarginLevelThi"/>
			  </td>
            </tr>
			<tr id="webPayTrSix" style="display:none">
              	<td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>是否保证金抵扣货款</td>
              	<td bgcolor="#FFFFFF">
              	<s:if test="auctionInfo.auctionWebPayGoods == 1">
					是
				</s:if>
				<s:if test="auctionInfo.auctionWebPayGoods == 2">
					否
				</s:if>
				</td>
            </tr>
            
            
			<tr>
              <td align="right" bgcolor="#FFFFFF"><span style="color:red">*</span>拍卖会图标</td>
              <td bgcolor="#FFFFFF">
				<table>
					<tr>
						<td bgcolor="#FFFFFF">
							
						</td>
						<td bgcolor="#FFFFFF" id="picErrorMsg">
							<span id="auctionUpLoadImgSpanFir"><img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" id="auctionUpLoadImgFir" height="150"></img></span>
							<span id="auctionUpLoadImgSpanSec"><img src="<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>" id="auctionUpLoadImgSec" height="150"></img></span>
							<span id="auctionUpLoadImgSpanThi"><img src="<%=request.getContextPath()%><s:property value=''/>" id="auctionUpLoadImgThi" height="150"></img></span>
							<span id="auctionUpLoadImgSpanFou"><img src="<%=request.getContextPath()%><s:property value=''/>" id="auctionUpLoadImgFou" height="150"></img></span>
							
						</td>
						
					</tr>
				</table>
				</td>
            </tr>
			<tr>
              <td align="right"  bgcolor="#FFFFFF">拍卖组别:</td>
              <td bgcolor="#FFFFFF">
              	<s:iterator value="#request.auctionTeamTypeList" var="auctionTeamTypeList" status="status">
              		<s:property value="#auctionTeamTypeList.teamType"/><br/>
              	</s:iterator>
              	
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖会简称</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionShortName"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖公告</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionBulletin" escape="true"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">拍卖规则</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionNotice" escape="true"/>
              </td>
            </tr>
            <tr>
              <td align="right" bgcolor="#FFFFFF">特别规定</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionGuide" escape="false"/>
              </td>
            </tr>
			<tr>
              <td align="right" bgcolor="#FFFFFF">备注说明</td>
              <td bgcolor="#FFFFFF">
              <s:property value="auctionInfo.auctionDescription" escape="false"/>
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
		$("#auctionUpLoadImgSpanFir").show();
		$("#auctionUpLoadImgSpanSec").hide();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").hide();
		$("#auctionUpLoadImgFir").attr("src","<%=request.getContextPath()%><s:property value='#request.companyPicUrl'/>");
	</script>
</s:if>
<s:if test='auctionInfo.auctionPicType == 2'>
	<script language="javascript" type="text/javascript">
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").show();
		$("#auctionUpLoadImgSpanThi").hide();
		$("#auctionUpLoadImgSpanFou").hide();
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
		$("#auctionUpLoadImgSpanFir").hide();
		$("#auctionUpLoadImgSpanSec").hide();
		$("#auctionUpLoadImgSpanThi").show();
		$("#auctionUpLoadImgSpanFou").hide();
		$("#auctionUpLoadImgThi").attr("src","<%=request.getContextPath()%><s:property value='auctionInfo.auctionPicUrl'/>");
	</script>
</s:if>
</body>
</html>
