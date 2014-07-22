package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class ItemMarginDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	
	private String accountId;
	private String auctionId;
	private String itemId;
	private String companyId;
	
	private String marginVal;
	private String marginType;
	
	private String orderId;
	
	private String accountName;
	private String guestName;
	private String guestIdentityCard;
	private String guestPhone;
	
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
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getMarginVal() {
		return marginVal;
	}
	public void setMarginVal(String marginVal) {
		this.marginVal = marginVal;
	}
	public String getMarginType() {
		return marginType;
	}
	public void setMarginType(String marginType) {
		this.marginType = marginType;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getGuestIdentityCard() {
		return guestIdentityCard;
	}
	public void setGuestIdentityCard(String guestIdentityCard) {
		this.guestIdentityCard = guestIdentityCard;
	}
	public String getGuestPhone() {
		return guestPhone;
	}
	public void setGuestPhone(String guestPhone) {
		this.guestPhone = guestPhone;
	}
	
	
	
}
