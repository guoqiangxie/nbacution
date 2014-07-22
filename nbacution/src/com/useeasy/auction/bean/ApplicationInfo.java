package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class ApplicationInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String accountId;
	private String accountName;
	private String userName;
	private String indentityCard;
	private String auctionId;
	private String auctionName;
	private String auctionStatus;
	private String auctionDeleteFlag;
	private String auctionPublishFlag;
	private String auctionWebPay;
	private String companyId;
	private String companyName;
	private String guestId;
	private String applyContent;
	private String bidNum;
	private String applyValidateCode;
	private String applyStatus;
	private Date checkTime;
	private String teamAuthority;
	private String guestNumFlag;
	
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getAuctionId() {
		return auctionId;
	}
	public void setAuctionId(String auctionId) {
		this.auctionId = auctionId;
	}
	public String getApplyContent() {
		return applyContent;
	}
	public void setApplyContent(String applyContent) {
		this.applyContent = applyContent;
	}
	public String getBidNum() {
		return bidNum;
	}
	public void setBidNum(String bidNum) {
		this.bidNum = bidNum;
	}
	public String getApplyValidateCode() {
		return applyValidateCode;
	}
	public void setApplyValidateCode(String applyValidateCode) {
		this.applyValidateCode = applyValidateCode;
	}
	public String getApplyStatus() {
		return applyStatus;
	}
	public void setApplyStatus(String applyStatus) {
		this.applyStatus = applyStatus;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getAuctionName() {
		return auctionName;
	}
	public void setAuctionName(String auctionName) {
		this.auctionName = auctionName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIndentityCard() {
		return indentityCard;
	}
	public void setIndentityCard(String indentityCard) {
		this.indentityCard = indentityCard;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}
	public Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	
	public String getTeamAuthority() {
		return teamAuthority;
	}
	public void setTeamAuthority(String teamAuthority) {
		this.teamAuthority = teamAuthority;
	}
	public String getAuctionStatus() {
		return auctionStatus;
	}
	public void setAuctionStatus(String auctionStatus) {
		this.auctionStatus = auctionStatus;
	}
	public String getAuctionDeleteFlag() {
		return auctionDeleteFlag;
	}
	public void setAuctionDeleteFlag(String auctionDeleteFlag) {
		this.auctionDeleteFlag = auctionDeleteFlag;
	}
	public String getAuctionPublishFlag() {
		return auctionPublishFlag;
	}
	public void setAuctionPublishFlag(String auctionPublishFlag) {
		this.auctionPublishFlag = auctionPublishFlag;
	}
	public String getGuestNumFlag() {
		return guestNumFlag;
	}
	public void setGuestNumFlag(String guestNumFlag) {
		this.guestNumFlag = guestNumFlag;
	}
	public String getAuctionWebPay() {
		return auctionWebPay;
	}
	public void setAuctionWebPay(String auctionWebPay) {
		this.auctionWebPay = auctionWebPay;
	}
	
}
