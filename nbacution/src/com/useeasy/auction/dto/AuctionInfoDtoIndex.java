package com.useeasy.auction.dto;

import java.io.Serializable;
import java.util.Date;

public class AuctionInfoDtoIndex implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String auctionName;
	private String auctionCompanyId;
	private Date auctionStartTime;
	private String auctionBulletin;
	private String auctionNotice;
	private String auctionGuide;
	private String auctionDescription;
	private String auctionStatus;
	private String publishFlag;
	private String loginUrl;
	private String visitUrl;
	
	private String companyName;
	private String auctionPicUrl;
	private String companyInterfaceFlag;
	
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
	public String getAuctionName() {
		return auctionName;
	}
	public void setAuctionName(String auctionName) {
		this.auctionName = auctionName;
	}
	public String getAuctionCompanyId() {
		return auctionCompanyId;
	}
	public void setAuctionCompanyId(String auctionCompanyId) {
		this.auctionCompanyId = auctionCompanyId;
	}
	public Date getAuctionStartTime() {
		return auctionStartTime;
	}
	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}
	public String getAuctionBulletin() {
		return auctionBulletin;
	}
	public void setAuctionBulletin(String auctionBulletin) {
		this.auctionBulletin = auctionBulletin;
	}
	public String getAuctionNotice() {
		return auctionNotice;
	}
	public void setAuctionNotice(String auctionNotice) {
		this.auctionNotice = auctionNotice;
	}
	public String getAuctionGuide() {
		return auctionGuide;
	}
	public void setAuctionGuide(String auctionGuide) {
		this.auctionGuide = auctionGuide;
	}
	public String getAuctionDescription() {
		return auctionDescription;
	}
	public void setAuctionDescription(String auctionDescription) {
		this.auctionDescription = auctionDescription;
	}
	public String getAuctionStatus() {
		return auctionStatus;
	}
	public void setAuctionStatus(String auctionStatus) {
		this.auctionStatus = auctionStatus;
	}
	public String getPublishFlag() {
		return publishFlag;
	}
	public void setPublishFlag(String publishFlag) {
		this.publishFlag = publishFlag;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAuctionPicUrl() {
		return auctionPicUrl;
	}
	public void setAuctionPicUrl(String auctionPicUrl) {
		this.auctionPicUrl = auctionPicUrl;
	}
	public String getCompanyInterfaceFlag() {
		return companyInterfaceFlag;
	}
	public void setCompanyInterfaceFlag(String companyInterfaceFlag) {
		this.companyInterfaceFlag = companyInterfaceFlag;
	}
	public String getLoginUrl() {
		return loginUrl;
	}
	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}
	public String getVisitUrl() {
		return visitUrl;
	}
	public void setVisitUrl(String visitUrl) {
		this.visitUrl = visitUrl;
	}

	
}
