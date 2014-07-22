package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionInfoIndexDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String deleteFlag;
	
	private String companyId;
	private String companyName;
	private String companyInterfaceFlag;
	
	private String auctionForm;
	private String auctionDelegation;
	private String auctionNature;
	private String auctionType;
	
	private String auctionName;
	private Date auctionStartTime;
	private String auctionAddress;
	private String auctionLinkTel;
	private String auctionStatus;
	
	private String auctionPicType;
	private String auctionPicVal;
	private String uploadAucUrl;
	private String uploadUrl;
	private String publishFlag;
	
	private String xmlFlag;
	private String sortFlag;
	
	private String auctionWebPay;
	
	private String loginUrl;
	private String visitUrl;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
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
	public String getAuctionName() {
		return auctionName;
	}
	public void setAuctionName(String auctionName) {
		this.auctionName = auctionName;
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
	public String getAuctionStatus() {
		return auctionStatus;
	}
	public void setAuctionStatus(String auctionStatus) {
		this.auctionStatus = auctionStatus;
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
	public String getUploadAucUrl() {
		return uploadAucUrl;
	}
	public void setUploadAucUrl(String uploadAucUrl) {
		this.uploadAucUrl = uploadAucUrl;
	}
	public String getUploadUrl() {
		return uploadUrl;
	}
	public void setUploadUrl(String uploadUrl) {
		this.uploadUrl = uploadUrl;
	}
	public String getPublishFlag() {
		return publishFlag;
	}
	public void setPublishFlag(String publishFlag) {
		this.publishFlag = publishFlag;
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
	public String getAuctionWebPay() {
		return auctionWebPay;
	}
	public void setAuctionWebPay(String auctionWebPay) {
		this.auctionWebPay = auctionWebPay;
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
