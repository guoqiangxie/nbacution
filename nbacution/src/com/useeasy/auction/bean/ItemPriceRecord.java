package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class ItemPriceRecord implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private String auctionId; 
	private String itemId;
	private String priceValue; 
	private String priceUserId;  
	private Date priceDate;
	private String priceUserType;  
	private String currentFlag;  
	private String bidNum;
	private String itemIndex;
	private String accountName;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public String getPriceValue() {
		return priceValue;
	}
	public void setPriceValue(String priceValue) {
		this.priceValue = priceValue;
	}
	public String getPriceUserId() {
		return priceUserId;
	}
	public void setPriceUserId(String priceUserId) {
		this.priceUserId = priceUserId;
	}
	public Date getPriceDate() {
		return priceDate;
	}
	public void setPriceDate(Date priceDate) {
		this.priceDate = priceDate;
	}
	public String getPriceUserType() {
		return priceUserType;
	}
	public void setPriceUserType(String priceUserType) {
		this.priceUserType = priceUserType;
	}
	public String getCurrentFlag() {
		return currentFlag;
	}
	public void setCurrentFlag(String currentFlag) {
		this.currentFlag = currentFlag;
	}
	public String getBidNum() {
		return bidNum;
	}
	public void setBidNum(String bidNum) {
		this.bidNum = bidNum;
	}
	public String getItemIndex() {
		return itemIndex;
	}
	public void setItemIndex(String itemIndex) {
		this.itemIndex = itemIndex;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	
	
	
}
