package com.useeasy.auction.dto;

import java.io.Serializable;
import java.util.Date;

public class AuctionInfoDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String auctionName;
	private String auctionCompanyId;
	private String auctionForm;
	private String auctionDelegation;
	private String auctionNature;
	private String auctionType;
	private Date auctionStartTime;
	private String auctionAddress;
	private String auctionLinkTel;
	private String auctionPicType;
	private String auctionPicVal;
	private String auctionStatus;
	private String auctionNum;
	private String auctionShortName;
	private String publishFlag;
	private String xmlFlag;
	private String sortFlag;
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

	public String getAuctionForm() {
		return auctionForm;
	}

	public void setAuctionForm(String auctionForm) {
		this.auctionForm = auctionForm;
	}

	public String getAuctionDelegation() {
		return auctionDelegation;
	}

	public void setAuctionDelegation(String auctionDelegation) {
		this.auctionDelegation = auctionDelegation;
	}

	public String getAuctionNature() {
		return auctionNature;
	}

	public void setAuctionNature(String auctionNature) {
		this.auctionNature = auctionNature;
	}

	public String getAuctionType() {
		return auctionType;
	}

	public void setAuctionType(String auctionType) {
		this.auctionType = auctionType;
	}

	public Date getAuctionStartTime() {
		return auctionStartTime;
	}

	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}

	public String getAuctionAddress() {
		return auctionAddress;
	}

	public void setAuctionAddress(String auctionAddress) {
		this.auctionAddress = auctionAddress;
	}

	public String getAuctionLinkTel() {
		return auctionLinkTel;
	}

	public void setAuctionLinkTel(String auctionLinkTel) {
		this.auctionLinkTel = auctionLinkTel;
	}

	public String getAuctionPicType() {
		return auctionPicType;
	}

	public void setAuctionPicType(String auctionPicType) {
		this.auctionPicType = auctionPicType;
	}

	public String getAuctionPicVal() {
		return auctionPicVal;
	}

	public void setAuctionPicVal(String auctionPicVal) {
		this.auctionPicVal = auctionPicVal;
	}

	public String getAuctionStatus() {
		return auctionStatus;
	}

	public void setAuctionStatus(String auctionStatus) {
		this.auctionStatus = auctionStatus;
	}

	public String getAuctionNum() {
		return auctionNum;
	}

	public void setAuctionNum(String auctionNum) {
		this.auctionNum = auctionNum;
	}

	public String getAuctionShortName() {
		return auctionShortName;
	}

	public void setAuctionShortName(String auctionShortName) {
		this.auctionShortName = auctionShortName;
	}

	public String getAuctionPicUrl() {
		return auctionPicUrl;
	}

	public void setAuctionPicUrl(String auctionPicUrl) {
		this.auctionPicUrl = auctionPicUrl;
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

	public String getXmlFlag() {
		return xmlFlag;
	}

	public void setXmlFlag(String xmlFlag) {
		this.xmlFlag = xmlFlag;
	}

	public String getSortFlag() {
		return sortFlag;
	}

	public void setSortFlag(String sortFlag) {
		this.sortFlag = sortFlag;
	}
	
}
