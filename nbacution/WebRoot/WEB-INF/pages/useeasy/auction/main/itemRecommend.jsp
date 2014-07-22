<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="inside">
<%-- 滚动图片 --%>

	<div class=""  id="marquee_demo" style="overflow:hidden;width:100%;  ">
		
		<s:if test="#request.itemInfoListRecommend.size() >= 8 ">
		<MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=3  >
		<ul style="list-style:none;float:left">
			<s:iterator value="#request.itemInfoListRecommend" var="itemInfoListRecommend">
					<li style="list-style:none;float:left">
				<table><tr><td>
				<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value="#itemInfoListRecommend[0]"/>">
				<s:if test="#itemInfoListRecommend[2] == null || #itemInfoListRecommend[2] == '' ">
                	<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="65" width="80" border="0" title=' <s:property value="#itemInfoListRecommend[1]"/>' />
                </s:if>
                <s:else>
					<img src="<%=request.getContextPath()%><s:property value="#itemInfoListRecommend[2]"/>" height="65" width="80" border="0" title=' <s:property value="#itemInfoListRecommend[1]"/>'/>
				</s:else>
				</a>
				</td></tr>
				<tr><td>
				<a target="_blank" title=' <s:property value="#itemInfoListRecommend[1]"/>' href="auctionIndex_itemDetail?itemFlag=<s:property value="#itemInfoListRecommend[0]"/>">
				<s:if test="#itemInfoListRecommend[1].length()>10">
                      <s:property value="#itemInfoListRecommend[1].substring(0, 8)" />...
               </s:if>
               <s:else>
                      <s:property value="#itemInfoListRecommend[1]"/>
               </s:else>

				</a>
				<span title=""></span>
				</td>
				</tr>
				</table>
				</li>
			</s:iterator>
		</ul>
		</MARQUEE>
		</s:if>
		<s:else>
			<ul>
			<s:iterator value="#request.itemInfoListRecommend" var="itemInfoListRecommend">
				<li style="list-style:none;float:left">
				<table><tr><td>
				<a target="_blank" href="auctionIndex_itemDetail?itemFlag=<s:property value="#itemInfoListRecommend[0]"/>">
				<s:if test="#itemInfoListRecommend[2] == null || #itemInfoListRecommend[2] == '' ">
                	<img src="<%=request.getContextPath()%>/uploadFile/image/base/nopic.jpg" height="65" width="80" border="0" title=' <s:property value="#itemInfoListRecommend[1]"/>' />
                </s:if>
                <s:else>
					<img src="<%=request.getContextPath()%><s:property value="#itemInfoListRecommend[2]"/>" height="65" width="80" border="0" title=' <s:property value="#itemInfoListRecommend[1]"/>'/>
				</s:else>
				</a>
				</td></tr>
				<tr><td>
				<a target="_blank" title=' <s:property value="#itemInfoListRecommend[1]"/>' href="auctionIndex_itemDetail?itemFlag=<s:property value="#itemInfoListRecommend[0]"/>">
				<s:if test="#itemInfoListRecommend[1].length()>10">
                      <s:property value="#itemInfoListRecommend[1].substring(0, 8)" />...
               </s:if>
               <s:else>
                      <s:property value="#itemInfoListRecommend[1]"/>
               </s:else>

				</a>
				<span title=""></span>
				</td>
				</tr>
				</table>
				</li>
			</s:iterator>
			</ul>
		</s:else>
	</div>
</div>