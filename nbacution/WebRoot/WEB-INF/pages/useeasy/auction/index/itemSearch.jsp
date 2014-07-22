<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="keywords"	content="网络拍卖,网络拍卖信息系统,同步拍,拍卖" />
<meta http-equiv="discription" content="网络拍卖信息系统"/>
<link href="useeasy/auction/css/main/main.css"	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="useeasy/auction/js/main/onload.js" language="javascript"></script>
<title>宁波市在线同步拍卖交易平台--首页</title>

</head>
<body>
	<!--container-->
	<div class="container">
		<!--topnav-->
		<jsp:include page="../main/topLogin.jsp" flush="true"/>	
		<!--end topnav-->
		
		<!--header-->
		<div class="header">
			
			<!--mainnav-->
			<div class="mainnav">
			<jsp:include page="../main/menu.jsp" flush="true"/>	
			</div>
			<!--end mainnav-->
			
			<div class="search">
			<table width="920" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="18"><img src="useeasy/auction/images/main/icon_s.gif" width="14" height="14" /></td>
					<td class="title">搜索类别</td>
					<td width="15">&nbsp;</td>
					<td><input type="radio" id="search_type_fir" name="auction_radio" value="1"/></td>
					<td>拍卖会</td>
					<td width="12">&nbsp;</td>
					<td><input type="radio" id="search_type_sec" name="auction_radio" value="2" checked="checked"/></td>
					<td>拍卖标的</td>
					<td width="10">&nbsp;</td>
					<td>拍卖公司：</td>
					<td>
						<select id="companyName_val" name="companyName" style="width:100pt">
							<s:if test="#request.companyFlag == 0">
							<option value="0" selected="selected"></option>
							<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoList">
								<option value="<s:property value="#companyInfoDtoList.id"/>"><s:property value="#companyInfoDtoList.companyName"/></option>
							</s:iterator>
							</s:if>
							<s:else>
								<option value="0" ></option>
								<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoListFir">
									<s:if test="#request.companyFlag == #companyInfoDtoListFir.id">
										<option value="<s:property value="#companyInfoDtoListFir.id"/>" selected="selected"><s:property value="#companyInfoDtoListFir.companyName"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="#companyInfoDtoListFir.id"/>"><s:property value="#companyInfoDtoListFir.companyName"/></option>
									</s:else>
								</s:iterator>
							</s:else>
						</select>
					</td> 
					<td width="10">&nbsp;</td>
					<td>标的类别：</td>
					<td>
						<select  id="seracher_val"  >
							<s:if test="#request.auctionType == 1">
							<option value="1" selected="selected" style="width:100px"></option>
							</s:if>
							<s:else>
							<option value="1" style="width:100px"></option>
							</s:else>
							<s:if test="#request.auctionType == 2">
							<option value="2" selected="selected">房地产</option>
							</s:if>
							<s:else>
							<option value="2">房地产</option>
							</s:else>
							<s:if test="#request.auctionType == 3">
							<option value="3" selected="selected">机动车</option>
							</s:if>
							<s:else>
							<option value="3">机动车</option>
							</s:else>
							<s:if test="#request.auctionType == 4">
							<option value="4" selected="selected">物资设备</option>
							</s:if>
							<s:else>
							<option value="4">物资设备</option>
							</s:else>
							<s:if test="#request.auctionType == 5">
							<option value="5" selected="selected">股权</option>
							</s:if>
							<s:else>
							<option value="5">股权</option>
							</s:else>
							<s:if test="#request.auctionType == 6">
							<option value="6" selected="selected">民品</option>
							</s:if>
							<s:else>
							<option value="6">民品</option>
							</s:else>
							<s:if test="#request.auctionType == 7">
							<option value="7" selected="selected">文物艺术品</option>
							</s:if>
							<s:else>
							<option value="7">文物艺术品</option>
							</s:else>
							<s:if test="#request.auctionType == 8">
							<option value="8" selected="selected">其他</option>
							</s:if>
							<s:else>
							<option value="8">其他</option>
							</s:else>
						</select>
					</td>
					<td width="10">&nbsp;</td>
					<td>关键字：</td>
					<td><input id="key_val" type="text" value="<s:property value="#request.key"/>"/></td>
					<td><a href="javascript:void(0);" onclick="doSearch();return false;"><img border="0" src="useeasy/auction/images/main/search_btn.gif"/></a></td>
				</tr>
			</table>
			</div>
			
			<div class="msg">
				<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
				<s:iterator value="#request.auctionInfoDtoListTop" var="auctionInfoDtoListTop">
					<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
					<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property value="#auctionInfoDtoListTop.auctionName"/></a>
				</s:iterator>
				</MARQUEE>
			</div>
				
		</div>
		<!--end header-->
		
		<!--banner-->
		
		<!--end banner-->
		
		<!--main-->
		<div class="main">
			
			
			<!--right-->
			<div id="right" class="right_s" >
				<div class="sidebar">
					
					<div class="title">
						<span class="text_pmh"></span>
					</div>	
					
					<div class="wrap">
						<div class="inside min-height">
							
							
							<div> 
							
								<table cellpadding="0" cellspacing="0" class="info" id="table1" >
                          <thead>
                            <tr>
                              <th class="picCol">图片</th>
                              <th class="nameCol">标的名称</th>
                              <th class="introCol">保证金</th>
                              <th class="priceCol">参考价<%--/佣金--%></th> 
                              <th class="resultCol">拍卖结果</th>
                            </tr>
                          </thead>
                          <tbody>
                          
                          <s:iterator value="#request.itemInfoList" var="itemInfoList">
                          <tr valign="top">
                              <td>
                              	<p>
                              	<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoList[0]'/>">
                              	<s:if test="#itemInfoList[7] == null || #itemInfoList[7] == '' ">
                              	<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" width="88" height="66" border="0" />
                              	</s:if>
                              	<s:else>
                              	<img src="<%=request.getContextPath()%><s:property value="#itemInfoList[7]"/>" width="88" height="66" border="0" />
                              	</s:else>
                              	</a>
                              	</p>
                              	<s:property value="#itemInfoList[2]"/>
                              </td>
                              <td>
                              	<p>
                              	<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value='#itemInfoList[0]'/>">
                              	<s:if test="#itemInfoList[1].length() > 30">
                              		<s:property value="#itemInfoList[1].substring(0,30)"/>...
                              	</s:if>
                              	<s:else>
                              		<s:property value="#itemInfoList[1]"/>
                              	</s:else>
                              	</a>  
                              	<s:if test="#itemInfoList[8] == 1">
                                	<span style="color:red">[多图]</span> 
                                </s:if>                            	
                              	</p>
                              	
                              </td>
                              <td>
                              	<%-- <s:if test="#itemInfoList[3].length() > 50">
                              		<p class="intro" title="<s:property value="#itemInfoList[3].substring(0,50)"/>...">
										<s:property value="#itemInfoList[3].substring(0,50)"/>...
									</p>
                              	</s:if>
                              	<s:else>
	                              	<p class="intro" title="<s:property value="#itemInfoList[3].itemDescription"/>">
										<s:property value="#itemInfoList[3].itemDescription"/>
									</p>
                              	</s:else> --%>
                              	<s:property value="#itemInfoList[3]"/>
                              </td>
                              <td>
                              	  <p class="priceInfo">
                              	  <s:if test="#itemInfoList[4]!= null && #itemInfoList[5] != null">
                              	  <s:property value="#itemInfoList[4]"/>
                              	  -
                              	  <s:property value="#itemInfoList[5]"/>
                              	  </s:if>
                              	  </p>
                              </td> 
                              <td>
                              	  <p>
                              	  <s:if test="#itemInfoList[6] == 0">
                              	  尚未开始
                              	  </s:if>
                              	  <s:elseif test="#itemInfoList[6] == 1 || 
                              	  	#itemInfoList[6] == 2 
                              	  	|| #itemInfoList[6] == 3
                              	  	|| #itemInfoList[6] == 4">
                              	  正在进行
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoList[6] == 5">
                              	  成交
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoList[6] == 6">
                              	  流标
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoList[6] == 7">
                              	  撤拍
                              	  </s:elseif>
                              	  <s:elseif test="#itemInfoList[6] == 8">
                              	  缓拍
                              	  </s:elseif>
                              	  </p>
                              	  
                              </td>
                            </tr>
                          </s:iterator>
                            
                           
                            
                           
                          </tbody>
                      </table>
                      
							</div>
							
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
					</div>
					
					<div class="bottom"></div>
				</div>
				
				
				
			</div>
			<!--end right-->
		</div>
		<!--end main-->
		
		<!--link-->
		<jsp:include page="../main/link.jsp" flush="true"/>
		<!--submenu-->
		<jsp:include page="../main/submenu.jsp" flush="true"/>
		<!--footer-->
		<jsp:include page="../main/footer.jsp" flush="true"/>
	</div>
	<!--end container-->
<script language="javascript" type="text/javascript">


</script>
</body>
</html>