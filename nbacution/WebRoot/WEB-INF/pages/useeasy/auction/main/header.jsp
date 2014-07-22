<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!--mainnav-->
 
<div class="mainnav"> 
<ul>
	<li id="index" class="over"><a href="auctionIndex_index?searchKind=1&searchType=1&currentPage=1"><span>首页</span></a></li>       
	<li id="house" class="over"><a href="auctionIndex_index?searchKind=2&searchType=5&currentPage=1"><span>房地产</span></a></li>
	<li id="automobile" class="over"><a href="auctionIndex_index?searchKind=3&searchType=5&currentPage=1"><span>机动车</span></a></li>
	<li id="material" class="over"><a href="auctionIndex_index?searchKind=4&searchType=5&currentPage=1"><span>物资设备</span></a></li>
	<li id="stock" class="over"><a href="auctionIndex_index?searchKind=5&searchType=5&currentPage=1"><span>股权</span></a></li>
	<li id="mlpllz" class="over"><a href="auctionIndex_index?searchKind=6&searchType=5&currentPage=1"><span>民品</span></a></li>
	<li id="art" class="over"><a href="auctionIndex_index?searchKind=7&searchType=5&currentPage=1"><span>文物艺术品</span></a></li>
	<li id="other" class="over"><a href="auctionIndex_index?searchKind=8&searchType=5&currentPage=1"><span>其他</span></a></li>
	<li class="line"></li>		
</ul>

<span class="topbtn">
	<a href="auctionIndex_index?searchKind=9&searchType=5&currentPage=1">
	<img src="useeasy/auction/images/main/top_btn01.gif" border=0/></a>
	<a href="auctionIndex_index?searchKind=10&searchType=5&currentPage=1">
	<img src="useeasy/auction/images/main/top_btn02.gif" border=0/></a>
</span> 
</div>
<!--end mainnav-->
<div class="search">
<table width="920" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="18"><img src="useeasy/auction/images/main/icon_s.gif" width="14" height="14" /></td>
		<td class="title">搜索类别</td>
		<td width="15">&nbsp;</td>
		<td><input type="radio" id="search_type_fir" name="auction_radio" value="1" checked="checked"/></td>
		<td>拍卖会</td>
		<td width="12">&nbsp;</td>
		<td><input type="radio" id="search_type_sec" name="auction_radio" value="2"/></td>
		<td>拍卖标的</td>
		<td width="10">&nbsp;</td>
		<td>拍卖公司：</td>
		<td>
			<select id="companyName_val" name="companyName" style="width:100pt">
				<option value="0" selected="selected"></option>
				<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoListFir">
					<option value="<s:property value="#companyInfoDtoListFir.id"/>"><s:property value="#companyInfoDtoListFir.companyName"/></option>
				</s:iterator>
			</select>
		</td> 
		<td width="10">&nbsp;</td>
		<td>标的类别：</td>
		<td>
			<select  id="seracher_val"  ><option value="1" selected="selected" style="width:100px"></option>
				<option value="2">房地产</option>
				<option value="3">机动车</option>
				<option value="4">物资设备</option>
				<option value="5">股权</option>
				<option value="6">民品</option>
				<option value="7">文物艺术品</option>
				<option value="8">其他</option>
			</select>
		</td>
		<td width="10">&nbsp;</td>
		<td>关键字：</td>
		<td><input id="key_val" type="text"/></td>
		<td><a href="javascript:void(0);"  onclick="doSearch();return false;"><img border="0" src="useeasy/auction/images/main/search_btn.gif"/></a></td>
	</tr>
</table>
</div>

<div class="msg">
	<table width="920" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="1%">
				<img src="useeasy/auction/images/main/icon05.gif" width="11" height="12" />
			</td>
			<td width="15%">累计拍卖会<span class="number"><s:property value="#request.allCount"/></span> 场
			</td>
			<td width="1%">
				<img src="useeasy/auction/images/main/icon05.gif" width="11" height="12" />
			</td>
			<td width="15%">
				当年拍卖会
				<span class="number"><s:property value="#request.yearCount"/></span> 场
			</td>
			<td width="1%">
				<img src="useeasy/auction/images/main/icon05.gif" width="11" height="12" />
			</td>
			<td width="15%">
				本月拍卖会
				<span class="number"><s:property value="#request.monthCount"/></span> 场
			</td>
			<td width="1%">
				<img src="useeasy/auction/images/main/icon05.gif" width="11" height="12" />
			</td>
			<td width="15%">累计标的<span class="number"><s:property value="#request.allItem"/></span> 个
			</td>
			
			<%-- 滚动栏 --%>
			<td width="355"  class="text">	
			<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
			<s:iterator value="#request.auctionInfoDtoListTop" var="auctionInfoDtoListTop">
				<img src="useeasy/auction/images/main/icon06.gif" width="11" height="11" />
				<a target="_blank" href="auctionIndex_auctionDetail?auctionFlag=<s:property value='#auctionInfoDtoListTop.id'/>&currentPage=1"><s:property value="#auctionInfoDtoListTop.auctionName"/></a>
			</s:iterator>
			</MARQUEE>
			</td>
		</tr>
	</table>
</div>
		
