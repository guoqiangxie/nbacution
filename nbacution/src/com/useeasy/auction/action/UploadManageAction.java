package com.useeasy.auction.action;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class UploadManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(UploadManageAction.class);
	
	public String imgUpload() {logger.info("11111___________");
		String imageFlag = ServletActionContext.getRequest().getParameter("imageFlag");
		ServletActionContext.getRequest().setAttribute("imageFlag", imageFlag);
		return "imgUpload";
	}
	
}
