<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>

<div class="pagerWrapper">
	<div style="PADDING-BOTTOM: 2px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; FLOAT: right; PADDING-TOP: 1px">
		<s:if test="page.currentPage==1">
		<span>首页</span>
		</s:if>
		<s:if test="page.currentPage!=1">
		<a href="<s:property value="page.url"/>currentPage=1">首页</a>
		</s:if>
		
		<s:if test="page.pages<=page.pageEntry">
			<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var">
				<s:if test="#index_var != page.currentPage">
					<s:if test="#index_var <= page.pages">
						<a href="<s:property value="page.url"/>currentPage=<s:property value="#index_var"/>"><s:property value="#index_var"/></a>
					</s:if>
				</s:if>
				<s:else>
					<span class="active"><s:property value="#index_var"/></span>
				</s:else>
			</s:iterator>
		</s:if>
		<s:else>
			<s:if test="page.currentPage-(page.pageEntry-1)/2 > 1">
				<s:if test="(page.currentPage+(page.pageEntry-1)/2) <= page.pages">
					<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_fir">
					<s:if test="#index_var_fir <= page.pageEntry">
						<s:if test="page.currentPage-(((page.pageEntry-1)/2)-(#index_var_fir-1)) != page.currentPage">
							<s:if test="page.currentPage-(((page.pageEntry-1)/2)-(#index_var_fir-1)) <= page.pages">
								<a href="<s:property value="page.url"/>currentPage=<s:property value="page.currentPage-(((page.pageEntry-1)/2)-(#index_var_fir-1))"/>"><s:property value="page.currentPage-(((page.pageEntry-1)/2)-(#index_var_fir-1))"/></a>
							</s:if>
						</s:if>
						<s:else>
							<span class="active"><s:property value="page.currentPage"/></span>
						</s:else>
					</s:if>	
					</s:iterator>
				</s:if>
				<s:else>
					<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_sec">
						<s:if test="(page.pages-page.pageEntry+#index_var_sec) != page.currentPage">
							<s:if test="(page.pages-page.pageEntry+#index_var_sec) <= page.pages">
								<a href="<s:property value="page.url"/>currentPage=<s:property value="page.pages-page.pageEntry+#index_var_sec"/>"><s:property value="page.pages-page.pageEntry+#index_var_sec"/></a>
							</s:if>
						</s:if>
						<s:else>
							<span class="active"><s:property value="page.currentPage"/></span>
						</s:else>
					</s:iterator>
				</s:else>
			</s:if>
			<s:else>
				<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_thi">
					<s:if test="#index_var_thi != page.currentPage">
						<s:if test="#index_var_thi <= page.pageEntry">
							<a href="<s:property value="page.url"/>currentPage=<s:property value="#index_var_thi"/>"><s:property value="#index_var_thi"/></a>
						</s:if>
					</s:if>
					<s:else>
						<span class="active"><s:property value="#index_var_thi"/></span>
					</s:else>
				</s:iterator>
			</s:else>
		</s:else>
													
		<s:if test="page.currentPage==page.pages || page.pages==0">
			<span>尾页</span>
		</s:if>
		<s:if test="page.currentPage!=page.pages && page.pages!=0">
			<a href="<s:property value="page.url"/>currentPage=<s:property value="page.pages"/>">尾页</a>
		</s:if>
													
	</div>
											
	<s:if test="page.currentPage==1">
		<span>«上一页</span>
	</s:if>
	<s:if test="page.currentPage!=1">
		<a href="<s:property value="page.url"/>currentPage=<s:property value="page.currentPage-1"/>">«上一页</a>
	</s:if>
	<span><s:property value="page.currentPage"/>/
	<s:if test="page.pages!=0">
		<s:property value="page.pages"/>
	</s:if>
	<s:else>
		1
	</s:else>
	</span>
	<s:if test="page.currentPage==page.pages || page.pages==0">
		<span>下一页 »</span>
	</s:if>
	<s:if test="page.currentPage!=page.pages && page.pages!=0">
		<a href="<s:property value="page.url"/>currentPage=<s:property value="page.currentPage+1"/>">下一页 »</a>
	</s:if>
											
</div>
		
