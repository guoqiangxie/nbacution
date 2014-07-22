package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionInfo implements Serializable{

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
	private String auctionStartTimeVal;
	private String auctionAddress;
	private String auctionLinkTel;
	private String auctionPicType;
	private String auctionPicVal;
	private String auctionPicUrl;
	private String auctionBulletin;
	private String auctionNotice;
	private String auctionGuide;
	private String auctionDescription;
	private String auctionStatus;
	private String auctionOnlineUser;
	private String auctionOnlineMaxUser;
	private String auctionCountTime;
	private String auctionKind;
	private String auctionNum;
	private String auctionWebPay;
	private String auctionWebPayCheck;
	private String auctionMarginMax;
	private String auctionMarginLevelFir;
	private String auctionMarginLevelSec;
	private String auctionMarginLevelThi;
	private String auctionWebPayGoods;
	private String auctionShortName;
	private String xmlFlag;
	private String sortFlag;
	private String publishFlag;
	private String autoBidNum;
	private String autoCurrentBidNum;
	private String xmlNumFlag;
	private String controllerNumFlag;
	private String loginUrl;
	private String visitUrl;
	
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
	public String getAuctionOnlineUser() {
		return auctionOnlineUser;
	}
	public void setAuctionOnlineUser(String auctionOnlineUser) {
		this.auctionOnlineUser = auctionOnlineUser;
	}
	public String getAuctionOnlineMaxUser() {
		return auctionOnlineMaxUser;
	}
	public void setAuctionOnlineMaxUser(String auctionOnlineMaxUser) {
		this.auctionOnlineMaxUser = auctionOnlineMaxUser;
	}
	public String getAuctionCountTime() {
		return auctionCountTime;
	}
	public void setAuctionCountTime(String auctionCountTime) {
		this.auctionCountTime = auctionCountTime;
	}
	public String getAuctionKind() {
		return auctionKind;
	}
	public void setAuctionKind(String auctionKind) {
		this.auctionKind = auctionKind;
	}
	public String getAuctionNum() {
		return auctionNum;
	}
	public void setAuctionNum(String auctionNum) {
		this.auctionNum = auctionNum;
	}
	public String getAuctionWebPay() {
		return auctionWebPay;
	}
	public void setAuctionWebPay(String auctionWebPay) {
		this.auctionWebPay = auctionWebPay;
	}
	public String getAuctionWebPayCheck() {
		return auctionWebPayCheck;
	}
	public void setAuctionWebPayCheck(String auctionWebPayCheck) {
		this.auctionWebPayCheck = auctionWebPayCheck;
	}
	public String getAuctionMarginMax() {
		return auctionMarginMax;
	}
	public void setAuctionMarginMax(String auctionMarginMax) {
		this.auctionMarginMax = auctionMarginMax;
	}
	public String getAuctionMarginLevelFir() {
		return auctionMarginLevelFir;
	}
	public void setAuctionMarginLevelFir(String auctionMarginLevelFir) {
		this.auctionMarginLevelFir = auctionMarginLevelFir;
	}
	public String getAuctionMarginLevelSec() {
		return auctionMarginLevelSec;
	}
	public void setAuctionMarginLevelSec(String auctionMarginLevelSec) {
		this.auctionMarginLevelSec = auctionMarginLevelSec;
	}
	public String getAuctionMarginLevelThi() {
		return auctionMarginLevelThi;
	}
	public void setAuctionMarginLevelThi(String auctionMarginLevelThi) {
		this.auctionMarginLevelThi = auctionMarginLevelThi;
	}
	public String getAuctionWebPayGoods() {
		return auctionWebPayGoods;
	}
	public void setAuctionWebPayGoods(String auctionWebPayGoods) {
		this.auctionWebPayGoods = auctionWebPayGoods;
	}
	public String getAuctionStartTimeVal() {
		return auctionStartTimeVal;
	}
	public void setAuctionStartTimeVal(String auctionStartTimeVal) {
		this.auctionStartTimeVal = auctionStartTimeVal;
	}
	public String getAuctionPicUrl() {
		return auctionPicUrl;
	}
	public void setAuctionPicUrl(String auctionPicUrl) {
		this.auctionPicUrl = auctionPicUrl;
	}
	public String getAuctionShortName() {
		return auctionShortName;
	}
	public void setAuctionShortName(String auctionShortName) {
		this.auctionShortName = auctionShortName;
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
	public String getPublishFlag() {
		return publishFlag;
	}
	public void setPublishFlag(String publishFlag) {
		this.publishFlag = publishFlag;
	}
	public String getAutoBidNum() {
		return autoBidNum;
	}
	public void setAutoBidNum(String autoBidNum) {
		this.autoBidNum = autoBidNum;
	}
	public String getAutoCurrentBidNum() {
		return autoCurrentBidNum;
	}
	public void setAutoCurrentBidNum(String autoCurrentBidNum) {
		this.autoCurrentBidNum = autoCurrentBidNum;
	}
	public String getXmlNumFlag() {
		return xmlNumFlag;
	}
	public void setXmlNumFlag(String xmlNumFlag) {
		this.xmlNumFlag = xmlNumFlag;
	}
	public String getControllerNumFlag() {
		return controllerNumFlag;
	}
	public void setControllerNumFlag(String controllerNumFlag) {
		this.controllerNumFlag = controllerNumFlag;
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
