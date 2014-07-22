package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionGuide implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String guideTitle;
	private String guideType;
	private String guideContent;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getGuideTitle() {
		return guideTitle;
	}
	public void setGuideTitle(String guideTitle) {
		this.guideTitle = guideTitle;
	}
	public String getGuideType() {
		return guideType;
	}
	public void setGuideType(String guideType) {
		this.guideType = guideType;
	}
	public String getGuideContent() {
		return guideContent;
	}
	public void setGuideContent(String guideContent) {
		this.guideContent = guideContent;
	}
	
	
	
}
