package com.useeasy.auction.tags;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageControllerTag extends BodyTagSupport {
	/**
	 * 分页标签
	 */
	private static final long serialVersionUID = 1L;

	/** 每页显示的记录数(标签的属性) */

	private int pageSize = 20;

	/** 目的地(标签的属性) */

	private String gotoURI;

	/** 总记录数名 */

	public static final String TOTAL = "total";

	/** 当前页号名 */

	public static final String PAGNENO = "pageNo";

	/** 每页要显示的记录数名 */

	public static final String RECORDCOUNT = "pageSize";

	/** 目的地名 */

	public static final String GOTOURI = "gotoURI";

	// 标签处理程序

	public int doStartTag() throws JspException {

		/** 当前页号(从请求对象中得到) */

		int pageNo = 1;

		/** 总记录数(从请求对象中得到) */

		int total = 0;

		/** 总页数(计算得出) */

		int totalPage = 1;

		HttpServletRequest request = (HttpServletRequest) pageContext

		.getRequest();

		// 要输出到页面的HTML文本

		StringBuffer sb = new StringBuffer();

		sb.append(" <form method='post' action='' ").append(

		"name='pageController'> ");

		// 获取所有提交的参数(包括查询条件参数)

		Enumeration enumeration = request.getParameterNames();//得到请求中的秘有元素

		String name = null;

		String value = null;

		while (enumeration.hasMoreElements()) {

			name = (String) enumeration.nextElement();//得到元素名

			value = request.getParameter(name);//根据元素名取的参数值

			if (name.equals(RECORDCOUNT)) {

				continue;

			}

			// 从请求对象中获取要跳转到的页号

			if (name.equals(PAGNENO)) {

				if (null != value && !"".equals(value)) {

					pageNo = Integer.parseInt(value);

				}

				continue;

			}

			sb.append("<input type='hidden' name='").append(name).append(

			"' value='").append(value).append("'/> ");

		}

		// 把当前页号设置成请求参数

		sb.append("<input type='hidden' name='").append(PAGNENO).append(

		"' value='").append(pageNo).append("'/> ");

		// 从请求对象中获取总记录数

		String tot = (String) request.getAttribute(TOTAL);

		if (null != tot && !"".equals(tot)) {

			total = Integer.parseInt(tot);

		}

		// 计算总页数

		totalPage = getTotalPage(total);

		sb.append("<br/> ");

		sb

		.append("&nbsp; ");

		sb.append("共 ").append(totalPage).append(" 页&nbsp;&nbsp;当前第 ").append(
				pageNo)

		.append(" 页 ");

		sb

		.append("&nbsp; ");

		if (pageNo == 1) {

			//sb.append("首页");

			//sb.append("&nbsp;");

			//sb.append("上一页 ");

		} else {

			sb.append("<span onclick='turnOverPage(1)'  style='cursor:pointer;'>首页</span> ");

			sb.append("&nbsp;");

			sb.append("<span style='cursor:pointer;'   onclick='turnOverPage(")

			.append((pageNo - 1)).append(")'>上一页</span> ");

		}

		sb.append("&nbsp;");

		if (pageNo == totalPage) {

			//sb.append("下一页");

			//sb.append("&nbsp;");

			//sb.append("尾页 ");

		} else {

			sb.append("<span   style='cursor:pointer;' onclick='turnOverPage(")

			.append((pageNo + 1)).append(")'>下一页</span> ");

			sb.append("&nbsp;");

			sb.append("<span  style='cursor:pointer;'  onclick='turnOverPage(").append(totalPage)

			.append(")'>尾页</span> ");

		}

		sb.append("&nbsp;");

		sb.append("跳转到<select onchange='turnOverPage(this.value)'> ");

		for (int i = 1; i <= totalPage; i++) {

			if (i == pageNo) {

				sb.append("  <option value='").append(i).append("' selected>第")

				.append(i).append("页</option> ");

			} else {

				sb.append("  <option value='").append(i).append("'>第")

				.append(i).append("页</option> ");

			}

		}

		sb.append("</select> ");

		sb.append("&nbsp; ");

		sb.append("</form> ");

		// 生成提交表单的JS

		sb.append("<script language='javascript'> ");

		sb.append("  function turnOverPage(no){ ");

		sb.append("    var form = document.pageController; ");

		sb.append("      ");

		sb.append("    if(no").append(">").append(totalPage).append(") { ");

		sb.append("        no=").append(totalPage).append("; ");

		sb.append("    } ");

		sb.append("    if(no").append("<=0){ ");

		sb.append("        no=1; ");

		sb.append("    } ");

		sb.append("    form.").append(PAGNENO).append(".value=no; ");

		sb.append("    form.action='").append(gotoURI).append("'; ");

		sb.append("    form.submit(); ");

		sb.append("  } ");

		sb.append("</script> <br/>");

		sb.append("<style>     ").append("</style>");

		try {

			pageContext.getOut().println(sb.toString());

		} catch (IOException e) {

			e.printStackTrace();

		}
           System.out.println(gotoURI);
		return super.doStartTag();

	}

	public String getGotoURI() {

		return gotoURI;

	}

	public void setGotoURI(String gotoURI) {

		this.gotoURI = gotoURI;

	}

	public int getPageSize() {

		return pageSize;

	}

	public void setPageSize(int pageSize) {

		this.pageSize = pageSize;

	}

	/**
	 * 
	 * 根据总记录数得到总页数
	 * 
	 * 
	 * 
	 * @return int 总页数
	 */

	private int getTotalPage(int total) {

		int totalPage = 1;

		if (total == 0) {

			totalPage = 1;

		} else {

			totalPage = (total % pageSize == 0) ? (total / pageSize) : (total

			/ pageSize + 1);

		}

		return totalPage;

	}
}
