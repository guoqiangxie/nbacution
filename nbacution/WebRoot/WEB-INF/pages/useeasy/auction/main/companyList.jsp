<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="list list_h">
<ul>
	<s:iterator value="#request.companyInfoDtoList" var="companyInfoDtoListSec">
		<li>
			<a target="_blank" href="companyIndex_index?currentPage=1&searchType=1&companyId=<s:property value="#companyInfoDtoListSec.id"/>" ><s:property value="#companyInfoDtoListSec.companyName"/></a>
		</li>
	</s:iterator>
</ul>
</div>