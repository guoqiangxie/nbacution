<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
<div class="pagerWrapper">
	<div style="PADDING-BOTTOM: 2px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; FLOAT: right; PADDING-TOP: 1px">
		<s:if test="#request.basePage.currentPage==1">
		<span>首页</span>
		</s:if>
		<s:if test="#request.basePage.currentPage!=1">
		<a href="<s:property value="#request.basePage.url"/>currentPage=1">首页</a>
		</s:if>
		
		<s:if test="#request.basePage.pages<=#request.basePage.pageEntry">
			<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var">
				<s:if test="#index_var != #request.basePage.currentPage">
					<s:if test="#index_var <= #request.basePage.pages">
						<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#index_var"/>"><s:property value="#index_var"/></a>
					</s:if>
				</s:if>
				<s:else>
					<span class="active"><s:property value="#index_var"/></span>
				</s:else>
			</s:iterator>
		</s:if>
		<s:else>
			<s:if test="#request.basePage.currentPage-(#request.basePage.pageEntry-1)/2 > 1">
				<s:if test="(#request.basePage.currentPage+(#request.basePage.pageEntry-1)/2) <= #request.basePage.pages">
					<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_fir">
					<s:if test="#index_var_fir <= #request.basePage.pageEntry">
						<s:if test="#request.basePage.currentPage-(((#request.basePage.pageEntry-1)/2)-(#index_var_fir-1)) != #request.basePage.currentPage">
							<s:if test="#request.basePage.currentPage-(((#request.basePage.pageEntry-1)/2)-(#index_var_fir-1)) <= #request.basePage.pages">
								<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#request.basePage.currentPage-(((#request.basePage.pageEntry-1)/2)-(#index_var_fir-1))"/>"><s:property value="#request.basePage.currentPage-(((#request.basePage.pageEntry-1)/2)-(#index_var_fir-1))"/></a>
							</s:if>
						</s:if>
						<s:else>
							<span class="active"><s:property value="#request.basePage.currentPage"/></span>
						</s:else>
					</s:if>	
					</s:iterator>
				</s:if>
				<s:else>
					<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_sec">
						<s:if test="(#request.basePage.pages-#request.basePage.pageEntry+#index_var_sec) != #request.basePage.currentPage">
							<s:if test="(#request.basePage.pages-#request.basePage.pageEntry+#index_var_sec) <= #request.basePage.pages">
								<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#request.basePage.pages-#request.basePage.pageEntry+#index_var_sec"/>"><s:property value="#request.basePage.pages-#request.basePage.pageEntry+#index_var_sec"/></a>
							</s:if>
						</s:if>
						<s:else>
							<span class="active"><s:property value="#request.basePage.currentPage"/></span>
						</s:else>
					</s:iterator>
				</s:else>
			</s:if>
			<s:else>
				<s:iterator value="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}" var="index_var_thi">
					<s:if test="#index_var_thi != #request.basePage.currentPage">
						<s:if test="#index_var_thi <= #request.basePage.pageEntry">
							<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#index_var_thi"/>"><s:property value="#index_var_thi"/></a>
						</s:if>
					</s:if>
					<s:else>
						<span class="active"><s:property value="#index_var_thi"/></span>
					</s:else>
				</s:iterator>
			</s:else>
		</s:else>
													
		<s:if test="#request.basePage.currentPage==#request.basePage.pages || #request.basePage.pages==0">
			<span>尾页</span>
		</s:if>
		<s:if test="#request.basePage.currentPage!=#request.basePage.pages && #request.basePage.pages!=0">
			<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#request.basePage.pages"/>">尾页</a>
		</s:if>
													
	</div>
											
	<s:if test="#request.basePage.currentPage==1">
		<span>«上一页</span>
	</s:if>
	<s:if test="#request.basePage.currentPage!=1">
		<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#request.basePage.currentPage-1"/>">«上一页</a>
	</s:if>
	<span><s:property value="#request.basePage.currentPage"/>/
	<s:if test="#request.basePage.pages!=0">
		<s:property value="#request.basePage.pages"/>
	</s:if>
	<s:else>
		1
	</s:else>
	</span>
	<s:if test="#request.basePage.currentPage==#request.basePage.pages || #request.basePage.pages==0">
		<span>下一页 »</span>
	</s:if>
	<s:if test="#request.basePage.currentPage!=#request.basePage.pages && #request.basePage.pages!=0">
		<a href="<s:property value="#request.basePage.url"/>currentPage=<s:property value="#request.basePage.currentPage+1"/>">下一页 »</a>
	</s:if>
											
</div>
		
