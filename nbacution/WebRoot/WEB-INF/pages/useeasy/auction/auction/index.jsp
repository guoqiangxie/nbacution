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
  <link rel="stylesheet" type="text/css" href="/notice/js/thickbox.css"/>
  <script type="text/javascript" src="/notice/js/jquery.js"></script> 
  <script type="text/javascript" src="/notice/js/thickbox.js"></script>
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
  				<div class="l">拍卖会管理</div> 
	  			<div class="r">
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_add" align="center">【拍卖提起】</a> 
	  			</div>
	  			</div> 
	  			
	  			
	  								  
  			
	   		<form name="" action="" method="post" >
	   		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c" id="table1">
            <tr align="center">
              
              <!--<td width="60" bgcolor="#FFFFFF">编号</td>-->
			  <td width="20%" bgcolor="#FFFFFF">LOGO</td>
			  <td width="20%" bgcolor="#FFFFFF">拍卖会</td>
			  <td width="15%" bgcolor="#FFFFFF">开始时间</td>
			  <td width="30%"  bgcolor="#FFFFFF"><span class="td_left" >管理</span></td>
			  <td width="15%" bgcolor="#FFFFFF">状态</td>
            </tr>
            <s:iterator value="#request.auctionInfoList" var="auctionInfoList">
		            <tr align="center">
							
		              	<td bgcolor="#FFFFFF">
		              	<s:if test="#auctionInfoList.auctionPicType == 1">
		              		<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="90" width="120"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120"/>
       						</s:else>
       						
       					</s:if>
       					<s:elseif test="#auctionInfoList.auctionPicType == 2">
       						<s:if test="#auctionInfoList.auctionPicVal == 1">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fir.jpg" height="90" width="120"/>
       						</s:if>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 2">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sec.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 3">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_thi.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 4">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fou.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 5">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_fif.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 6">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_six.jpg" height="90" width="120"/>
       						</s:elseif>
       						<s:elseif test="#auctionInfoList.auctionPicVal == 7">
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/auc_type_sev.jpg" height="90" width="120"/>
       						</s:elseif>
       					</s:elseif>
       					<s:elseif test="#auctionInfoList.auctionPicType == 3">
       						<s:if test="#auctionInfoList.auctionPicUrl != null && #auctionInfoList.auctionPicUrl != ''">
       							<img src="<%=request.getContextPath()%><s:property value="#auctionInfoList.auctionPicUrl"/>" height="90" width="120"/>
       						</s:if>
       						<s:else>
       							<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="90" width="120"/>
       						</s:else>
       						</s:elseif>
      					</td>
					  <td bgcolor="#FFFFFF"><s:property value="#auctionInfoList.auctionName"/></td>
					  <td bgcolor="#FFFFFF"><s:date name="#auctionInfoList.auctionStartTime" format="yyyy-MM-dd HH:mm"/></td>
					 
					 <td bgcolor="#FFFFFF">
							<s:if test="#auctionInfoList.auctionStatus == 0">
								<s:if test="#auctionInfoList.publishFlag == 0">
									<font color="red">拍卖会未发布</font><br/>
									<a title="拍卖会相关信息查看！"  href="auctionManage_detail?auctionFlag=<s:property value="#auctionInfoList.id"/>">查看</a>
	           						<a title="拍卖会相关信息修改，图片设置！"  href="auctionManage_edit?auctionFlag=<s:property value="#auctionInfoList.id"/>">修改</a>
	           						<a title="删除本场拍卖会及相关信息！"  href="javascript:void(0);" onclick="doAuctionDelete('<s:property value="#auctionInfoList.id"/>');return false;">删除</a>
	           						<br/>
	           						<a title="对本场拍卖会的拍品分类进行管理！" href="auctionManage_teamTypeIndex?auctionFlag=<s:property value="#auctionInfoList.id"/>">拍品特定资质</a>
	           						<a title="对本场拍卖会相关的拍品信息管理！" href="itemManage_index?auctionFlag=<s:property value="#auctionInfoList.id"/>" >拍品管理</a>
		              				<br/>
		              				<s:if test="#auctionInfoList.xmlFlag == 1">
		              					<a title="对本场拍卖会进行发布！" href="javascript:void(0);" onclick="doAuctionPublish('<s:property value="#auctionInfoList.id"/>');return false;">拍卖会发布</a>
		              				</s:if>
		              				<s:else>
		              					<a title="对本场拍卖会进行发布！" href="javascript:void(0);" onclick="alert('xml文件未生成！');return false;">拍卖会发布</a>
		              				</s:else>
		              				<br/>
		              				<a title="确认本场拍卖会的申请人员信息！" href="javascript:void(0);" onclick="alert('拍卖会未发布');return false;"><font color="grey">竞买人资格管理</font></a>
		             	 			<br/>
									<a title="查看本场拍卖会账务中心！"  href="javascript:void(0);" onclick="alert('拍卖会尚未开始');return false;"><font color="grey">拍卖会账务中心</font></a>
					  				<a title="查看本场拍卖会状态！"  href="javascript:void(0);" onclick="alert('拍卖会尚未开始');return false;"><font color="grey">拍卖会状态</font></a>
					  			    <a href="inteneterAction_getList?pmhId=<s:property value="#auctionInfoList.id"/>&TB_iframe=true&height=400&width=600"  class="thickbox">观摩人管理</a> 
					  			</s:if>
					  			<s:if test="#auctionInfoList.publishFlag == 1">
									<font color="blue">拍卖会已发布</font><br/>
									<a title="拍卖会相关信息查看！"  href="auctionManage_detail?auctionFlag=<s:property value="#auctionInfoList.id"/>">查看</a>
									<a title="拍卖会相关信息修改，图片设置！"  href="auctionManage_edit?auctionFlag=<s:property value="#auctionInfoList.id"/>">修改</a>
	           						<a title="删除本场拍卖会及相关信息！"  href="javascript:void(0);" onclick="doAuctionDelete('<s:property value="#auctionInfoList.id"/>');return false;">删除</a>
	           						<br/>
	           						<a title="对本场拍卖会的拍品分类进行管理！" href="auctionManage_teamTypeIndex?auctionFlag=<s:property value="#auctionInfoList.id"/>">拍品特定资质</a>
	           						<a title="对本场拍卖会相关的拍品信息管理！" href="itemManage_index?auctionFlag=<s:property value="#auctionInfoList.id"/>" >拍品管理</a>
		              				<br/>
		              				<a title="对本场拍卖会进行发布！" href="javascript:void(0);" onclick="alert('拍卖会已经发布！');return false;"><font color="grey">拍卖会发布</font></a>
	           						<br/>
	           						<a title="管理本场拍卖会的申请人员信息！" href="companyAudit_index?auctionFlag=<s:property value="#auctionInfoList.id"/>">竞买人资格管理</a>
		             	 			<br/>
									<a title="查看本场拍卖会账务中心！"  href="javascript:void(0);" onclick="alert('拍卖会尚未开始');return false;"><font color="grey">拍卖会账务中心</font></a>
					  				<a title="查看本场拍卖会状态！"  href="javascript:void(0);" onclick="alert('拍卖会尚未开始');return false;"><font color="grey">拍卖会状态</font></a>
					  			     <a href="inteneterAction_getList?pmhId=<s:property value="#auctionInfoList.id"/>&TB_iframe=true&height=400&width=600"  class="thickbox">观摩人管理</a> 
					  			</s:if>
					  			    <br/>
					  			    	<!--  <a title="工商前备案"  href="itemManage_beforPmbb?auctionFlag=<s:property value="#auctionInfoList.id"/>" >  工商前备案 </a>
					  			    	<br/>
					  			    	<a title="拍卖人员导入"  href="itemManage_importPerson?auctionFlag=<s:property value="#auctionInfoList.id"/>" > 竞买人身份信息导入 </a>-->
					  			    	 
							</s:if>
            				<s:elseif test="#auctionInfoList.auctionStatus == 1">
            					<s:if test="#auctionInfoList.publishFlag == 0">
            						<font color="red">拍卖会未发布</font><br/>
            					</s:if>
            					<s:if test="#auctionInfoList.publishFlag == 1">
            						<font color="blue">拍卖会已发布</font><br/>
            					</s:if>
            					<a title="拍卖会相关信息查看！"  href="auctionManage_detail?auctionFlag=<s:property value="#auctionInfoList.id"/>">查看</a>
            					<a title="拍卖会相关信息修改，图片设置！" href="javascript:void(0);" onclick="alert('拍卖会正在进行！');return false;"><font color="grey">修改</font></a>
	           					<a title="删除本场拍卖会及相关信息！" href="javascript:void(0);" onclick="alert('拍卖会正在进行！');return false;"><font color="grey">删除</font></a>
	           					<br/>
	           					<a title="对本场拍卖会的拍品分类进行管理！" href="javascript:void(0);" onclick="alert('拍卖会正在进行！');return false;"><font color="grey">拍品特定资质</font></a>
	           					<a title="对本场拍卖会相关的拍品信息管理！" href="itemManage_index?auctionFlag=<s:property value="#auctionInfoList.id"/>" >拍品管理</a>
	              				<br/>
		              			<a title="管理本场拍卖会的申请人员信息！" href="companyAudit_index?auctionFlag=<s:property value="#auctionInfoList.id"/>">竞买人资格管理</a>
	             	 			<br/>
								<a title="查看本场拍卖会账务中心！"  href="javascript:void(0);" onclick="alert('拍卖会正在进行');return false;"><font color="grey">拍卖会账务中心</font></a>
					  			<a title="查看本场拍卖会状态！"  href="javascript:void(0);" onclick="showAuctionStatus('<s:property value="#auctionInfoList.id"/>');return false;">拍卖会状态</a>
                                <a href="inteneterAction_getList?pmhId=<s:property value="#auctionInfoList.id"/>&TB_iframe=true&height=400&width=600"  class="thickbox">观摩人管理</a> 
					  		</s:elseif>
            				<s:elseif test="#auctionInfoList.auctionStatus == 2">
            					<a title="拍卖会相关信息查看！"  href="auctionManage_detail?auctionFlag=<s:property value="#auctionInfoList.id"/>">查看</a>
            					<a title="拍卖会相关信息修改，图片设置！" href="javascript:void(0);" onclick="alert('拍卖会已经结束！');return false;"><font color="grey">修改</font></a>
	           					<a title="删除本场拍卖会及相关信息！" href="javascript:void(0);" onclick="alert('拍卖会已经结束！');return false;"><font color="grey">删除</font></a>
	           					<br/>
	           					<a title="对本场拍卖会的拍品分类进行管理！" href="javascript:void(0);" onclick="alert('拍卖会已经结束');return false;"><font color="grey">拍品特定资质</font></a>
           						<a title="对本场拍卖会相关的拍品信息管理！" href="itemManage_index?auctionFlag=<s:property value="#auctionInfoList.id"/>" >拍品管理</a>
	              				<br/>
		              			<a title="管理本场拍卖会的申请人员信息！" href="companyAudit_index?auctionFlag=<s:property value="#auctionInfoList.id"/>">竞买人资格管理</a>
	             	 			<br/>
								<a title="查看本场拍卖会账务中心！"  href="companyFinance_index?auctionFlag=<s:property value="#auctionInfoList.id"/>" >拍卖会账务中心</a>
					  			<a title="查看本场拍卖会状态！"  href="javascript:void(0);" onclick="showAuctionStatus('<s:property value="#auctionInfoList.id"/>');return false;">拍卖会状态</a>
					  			<br/>
					  			<a title="查看本场拍卖会成果分析！"  href="auctionManage_analyze?auctionFlag=<s:property value="#auctionInfoList.id"/>">拍卖会成果分析</a>
				  				<a title="查看本场拍卖会拍品成交记录！"  href="itemManage_showResult?searchType=1&bidNum=&auctionFlag=<s:property value="#auctionInfoList.id"/>">拍品成交记录</a>
					  		    <a href="inteneterAction_getList?pmhId=<s:property value="#auctionInfoList.id"/>&TB_iframe=true&height=400&width=600"  class="thickbox">观摩人管理</a> 
					  		
					  		
					  			<!--  <a title="拍卖人员导出"  href="itemManage_exportPerson?auctionFlag=<s:property value="#auctionInfoList.id"/>" >  竞买人身份信息导出 </a> 
					  		<a title="工商后备案"  href="itemManage_exportPerson?auctionFlag=<s:property value="#auctionInfoList.id"/>" >  工商后备案 </a>  -->
					  		</s:elseif>
					  		<!-- <a title="拍卖人员导出"  href="itemManage_exportPerson?auctionFlag=<s:property value="#auctionInfoList.id"/>" >  竞买人身份信息导出 </a> 
					  		<a title="工商后备案"  href="itemManage_afterPmhbb?auctionFlag=<s:property value="#auctionInfoList.id"/>" >  工商后备案 </a>  -->
					  	
						</td>
					  <td bgcolor="#FFFFFF" class="state">
					  
					  
					 
					  	<s:if test="#auctionInfoList.auctionStatus == 0">
           					<font color="red">尚未开始</font><br/>
           					<s:if test="#auctionInfoList.xmlFlag == 1">
          			  			<a title="生成核心竞价的xml文件！" href="javascript:void(0);" onclick="alert('xml文件已经生成！');return false;"><font color="grey">更新XML文件</font></a><br/>
	           					<a title="进入flash操作端！" href="biddingManage_controller?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">进入竞拍</a><br/>
						  		<a title="进入flash大屏幕！" href="biddingManage_bigConsole?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">大屏幕</a><br/>
						  		<a title="进入flash拍卖师屏幕！" href="biddingManage_console?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">拍卖师屏幕</a><br/>
						  	</s:if>
          			  		<s:else>
	          			  		<span class="xml_div">
	           						<a title="生成核心竞价的xml文件！" href="javascript:void(0);" onclick="doToXml('<s:property value="#auctionInfoList.id"/>');return false;">更新XML文件</a><br/>
	           					</span>
	           					<span class="mess_div" style="display:none">
	           						<font color="red">处理中。。。</font><br/>
	           					</span>
	           					<a title="进入flash操作端！" href="javascript:void(0);" onclick="alert('xml文件未生成！');return false;"><font color="grey">进入竞拍</font></a><br/>
						  		<a title="进入flash大屏幕！" href="javascript:void(0);" onclick="alert('xml文件未生成！');return false;"><font color="grey">大屏幕</font></a><br/>
						  		<a title="进入flash拍卖师屏幕！" href="javascript:void(0);" onclick="alert('xml文件未生成！');return false;"><font color="grey">拍卖师屏幕</font></a><br/>
						  		
          			  		</s:else>
          			  	</s:if>
            			<s:elseif test="#auctionInfoList.auctionStatus == 1">
            				<font color="blue">正在进行</font><br/>
            				<a title="进入flash操作端！" href="biddingManage_controller?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">进入竞拍</a><br/>
						  		<a title="进入flash大屏幕！" href="biddingManage_bigConsole?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">大屏幕</a><br/>
						  		<a title="进入flash拍卖师屏幕！" href="biddingManage_console?auctionFlag=<s:property value="#auctionInfoList.id"/>" target="_blank">拍卖师屏幕</a><br/>
          			  	
            			</s:elseif>
            			<s:elseif test="#auctionInfoList.auctionStatus == 2">
            				已经结束
            			</s:elseif>
            			
					  </td>
		            </tr>
	        </s:iterator>
          </table>
          </form>
          <table cellSpacing="0" cellPadding="0" width="100%" align="center">
								<tbody>
									<tr>
										<td id="tdPages" class="pageBar_style">
											<jsp:include page="../main/pagination_s.jsp" flush="true"/>
										</td>
									</tr>
								</tbody>
							</table>
          
	   	 	</div>
			<!--end right-->
		</div>
		<!--end main-->
	
	 	<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
<script language="javascript" type="text/javascript">
	function doAuctionDelete(str){
		if(confirm("是否删除该拍卖会！")){
			location.href="auctionManage_delete?auctionFlag="+str;
		}
	}
	function doAuctionPublish(str){
		if(confirm("是否发布该拍卖会！")){
			location.href="auctionManage_publish?auctionFlag="+str;
		}
	}
	function doToXml(str){
		if(confirm("注意：生成xml文件会自动对所有拍品进行排序，是否生成xml文件！")){
			$(".mess_div").show();
			$(".xml_div").hide();
			$.post("biddingManage_toXml?auctionFlag="+str,function(data){
				if(data == 1){
					alert("成功生成xml文件！");
					location.href = "auctionManage_index";
				}else if(data == 2){
					alert("对不起，您还未添加任何拍品！");
					$(".mess_div").hide();
					$(".xml_div").show();
				}else if(data == 3){
					alert("对不起，xml文件已经生成！");
					location.href = "auctionManage_index";
				}else{
					alert("对不起，生成xml文件失败！");
					$(".mess_div").hide();
					$(".xml_div").show();
				}
			});
		}
	}
	function showAuctionStatus(str){
		window.showModalDialog("auctionManage_showStatus?auctionFlag="+str, "","dialogWidth=500px;dialogHeight=500px"); 
	}
</script>
</body>
</html>
