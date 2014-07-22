package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class BidRecordInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7417441001324394804L;

	
	private Long id;
	//拍卖会id
	private String auctionId;
	//拍品id
	private String itemId;
	//用户类型
	private String priceUserType;
	//用户类型
	private String priceUserId;
	//出价额
	private String priceValue;
	//出价有效性(0:有效)
	private String currentFlag;
	//拍牌号
	private String bidNum;
	
	private Date priceDate;
	
	
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
	public String getPriceUserType() {
		return priceUserType;
	}
	public void setPriceUserType(String priceUserType) {
		this.priceUserType = priceUserType;
	}
	public String getPriceUserId() {
		return priceUserId;
	}
	public void setPriceUserId(String priceUserId) {
		this.priceUserId = priceUserId;
	}
	public String getPriceValue() {
		return priceValue;
	}
	public void setPriceValue(String priceValue) {
		this.priceValue = priceValue;
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
	public Date getPriceDate() {
		return priceDate;
	}
	public void setPriceDate(Date priceDate) {
		this.priceDate = priceDate;
	}

}
