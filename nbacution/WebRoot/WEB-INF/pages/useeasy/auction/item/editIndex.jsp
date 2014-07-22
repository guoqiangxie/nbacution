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
<script type="text/javascript" src="useeasy/plugins/checkbox/js/checkboxgroup.js" language="javascript"></script>
<script type="text/javascript" src="useeasy/auction/js/item/index.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台</title>
</head>
<body>
<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		<div id="shx"></div>
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
		  	<div class="l">拍卖标的目录</div>
		  	<div class="r">
		  		<a style="color:blue; font-weight:bold;"  href="itemManage_add?auctionFlag=<s:property value="#request.auctionFlag"/>" >【拍品新建】</a> 
	  			<s:if test="#request.sortFlag == 0">
	  				<s:if test="#request.itemInfoDtoList.size() != 0">
	  					<a style="color:blue; font-weight:bold;" onclick="doItemAutoSort('<s:property value="#request.auctionFlag"/>')" href="###">【自动排序】</a> 
	  				</s:if>
	  			</s:if>
	  			<a style="color:blue; font-weight:bold;"  href="itemManage_importItems?auctionFlag=<s:property value="#request.auctionFlag"/>" >【导入拍品（批量）】</a> 
  				<s:if test="#request.itemInfoDtoList.size() != 0">
  					<a style="color:blue; font-weight:bold;"  href="###" onclick="doUploadPicAll(<s:property value="#request.auctionFlag"/>)" >【导入图片（批量）】</a> 
	  			</s:if>
	  			<a style="color:blue; font-weight:bold;"  href="auctionManage_index?currentPage=1">【返回】</a> 
  			</div>
		  </div>
		  
 		  
		  <form action="" method="post">
		  <input  type="hidden" name="auctionFlag" value="<s:property value="#request.auctionFlag"/>"/>
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#eed09c">
            <tr align="center">
			  <td width="2%" align="center" bgcolor="#FFFFFF">
			  <input type="checkbox" class="checkall"/>
			  </td>
              <td width="10%" bgcolor="#FFFFFF">拍品序号</td>
              <td width="10%" bgcolor="#FFFFFF">显示编号</td>
              <td width="15%" align="center" bgcolor="#FFFFFF">拍品名称</td>
			  <td width="5%" bgcolor="#FFFFFF">保证金</td>
			  <td width="5%" bgcolor="#FFFFFF">起拍价</td>
			  <td width="8%" bgcolor="#FFFFFF">加价幅度</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金方式</td>
			  <td width="10%" bgcolor="#FFFFFF">佣金数额</td>
			  <td width="13%" align="center" bgcolor="#FFFFFF">拍品名称</td>
			  <td width="10%" bgcolor="#FFFFFF">管理</td>
            </tr>
            	
            	<s:iterator value="#request.itemInfoDtoList" var="iInfo_list" status="status">
            		
            	
			            <tr align="center" id="">
		
						  <td bgcolor="#FFFFFF" >
						  	<input class="groupclass" name="group" type="checkbox" value="<s:property value="#iInfo_list.id"/>"/>
						  </td>
						  <td bgcolor="#FFFFFF"><input type="text" size="2" value="<s:property value="#iInfo_list.itemNumber"/>"/></td>
			              <td bgcolor="#FFFFFF"><input type="text" size="2" value="<s:property value="#iInfo_list.viewOrder"/>"/></td>
						  
						  <td bgcolor="#FFFFFF"  width="100"><input type="text" size="5" value="<s:property value="#iInfo_list.itemName"/>"/></td>
						  <td bgcolor="#FFFFFF"><input type="text" size="5" value="<s:property value="#iInfo_list.margin"/>"/></td>
						  <td bgcolor="#FFFFFF"><input type="text" size="5" value="<s:property value="#iInfo_list.itemPrice"/>"/></td>
						  <td bgcolor="#FFFFFF"><input type="text" size="5" value="<s:property value="#iInfo_list.itemPriceRange"/>"/></td>
						  <td bgcolor="#FFFFFF">
						  	<s:if test="#iInfo_list.itemCommissionType == 1">
						  	固定比率
						  	</s:if>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
						  	定额佣金
						  	</s:elseif>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
						  	执行最高院司法规定
						  	</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 4">浙江省高级人民法院</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 5">慈溪市人民法院</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 6">镇海区人民法院</s:elseif>
						  </td>
						  <td bgcolor="#FFFFFF">
						  	<s:if test="#iInfo_list.itemCommissionType == 1">
						  		<s:property value="#iInfo_list.itemCommissionValue"/>%
						  	</s:if>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 2">
						  		<s:property value="#iInfo_list.itemCommissionValue"/>
						  	</s:elseif>
						  	<s:elseif test="#iInfo_list.itemCommissionType == 3">
						  		执行最高院司法规定
						  	</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 4">浙江省高级人民法院</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 5">慈溪市人民法院</s:elseif>
						  	 <s:elseif test="#iInfo_list.itemCommissionType == 6">镇海区人民法院</s:elseif>
						  </td>
						  <td bgcolor="#FFFFFF"  width="100"><s:property value="#iInfo_list.itemName"/></td>
						  <td bgcolor="#FFFFFF">
							  <s:if test="#iInfo_list.itemLockFlag == 0"><img src="useeasy/auction/images/main/lock.gif"/></s:if>
							  	<a href="itemManage_edit?itemFlag=<s:property value="#iInfo_list.id"/>" >编辑</a><br/>
						   		<a class="innerButton" href="###" onclick="doItemDelete('<s:property value="#iInfo_list.id"/>')">删除</a>
							   	<br/>
							   	<a href="itemManage_picManage?itemFlag=<s:property value="#iInfo_list.id"/>" >图片管理</a>
						  </td>
						   
			            </tr>
			</s:iterator>
			<tr align="left" >
				
			</tr>
          </table>
          
          <s:if test="#request.itemInfoDtoList.size() != 0">
	  	  <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#eed09c" style="margin-top: 5pt;">
			<tr>
				<td><span id="button_span">
					<input type="button" class="button" value="批量删除" id="delArticles" onclick="doDeleteCheckedbox('<s:property value="#request.auctionFlag"/>')"/>
					<input type="button" class="button" value="批量编辑" id="BatchArticles" onclick="doBatchEditCheckedbox('<s:property value="#request.auctionFlag"/>')"/>
					<input type="button"  value="公开(拍卖结果)" onclick="doOpenResultCheckedbox('<s:property value="#request.auctionFlag"/>')"/>
					<input type="button" value="不公开(拍卖结果)" onclick="doCloseResultCheckedbox('<s:property value="#request.auctionFlag"/>')"/>
					<br/>
					<input type="text"  size="10" id="bzj_batch" style="margin-bottom: 5pt;"/>
					<input type="button" class="button" value="批量更新保证金" onclick="doBathcMarginCheckedbox('<s:property value="#request.auctionFlag"/>')" style="margin-bottom: 5pt;"/>
					<input type="text" size="10" value="" id="itemPriceRange_batch" style="margin-bottom: 5pt;"/>
					<input type="button" class="button" value="批量更新加价幅度" onclick="doBathcPriceRangeCheckedbox('<s:property value="#request.auctionFlag"/>')" style="margin-bottom: 5pt;"/>
					<br/>
					<input type="radio" id="yjfs_batch_fir" name="yjfs_batch" value="1" />固定比率
					<input type="text" size="10" id="gdbl_batch" />%&nbsp;&nbsp;
					<input type="radio" id="yjfs_batch_sec" name="yjfs_batch" value="2"/>定额佣金
					<input type="text" size="10"  id="deyj_batch" />&nbsp;&nbsp;
					<input type="radio" id="yjfs_batch_thi" name="yjfs_batch" value="3"/>执行最高院司法规定&nbsp;
					 <input type="radio" id="yjfs_batch_thi" name="yjfs_batch" value="4"/> 浙江省高级人民法院 
					 <input type="radio" id="yjfs_batch_thi" name="yjfs_batch" value="5"/>慈溪市人民法院 
					 <input type="radio" id="yjfs_batch_thi" name="yjfs_batch" value="6"/>镇海区人民法院
					
						  	 
						    
					<input type="button" class="button" value="批量更新佣金" onclick="doBathcCommissionCheckedbox('<s:property value="#request.auctionFlag"/>')"/>
					</span>
					<span id="message_span" style="display:none">
						<font color="red">信息处理中。。。</font>
					</span>
				</td>
			</tr>
		  </table>
		  </s:if>
		  </form>
		 </div>
		<!--end right-->
		</div>
		<!--end main-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	 	<!--footer-->
	</div>
<script language="javascript" type="text/javascript">
	function doItemDelete(str){
		if(confirm("是否删除该拍品")){
			document.forms[0].action="itemManage_delete?itemFlag="+str;
			document.forms[0].submit();
		}
	}
	function doItemAutoSort(str){
		if(confirm("是否自动排序这些拍品")){
			document.forms[0].action="itemManage_autoSort?auctionFlag="+str;
			document.forms[0].submit();
		}
	}
	function doUploadPicAll(str){
		if(confirm("是否批量上传图片")){
			var url = "itemManage_uploadPicAll?auctionFlag=" + str;
			var sRet = window.showModalDialog(url,"","dialogHeight:500px;dialogWidth:800px");
			
		}
	}
</script>
</body>
</html>
