package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class ItemInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String companyId;
	private String auctionId;
	private String itemName;
	private String itemNumber;
	private String viewOrder;
	private String valuationMethod;
	private String countNumber;  
	private String countUnit;
	private String countContent;
	private String itemCommissionType;
	private String itemCommissionValue;
	private String margin;
	private String marginFlag;
	private String itemBasePrice;
	private String itemPrice;
	private String itemReferencePriceFir;
	private String itemReferencePriceSec;
	private String teamId;
	private String recommendFlag;
	private String proxyPriceFlag;
	private String publishFlag;
	private String itemDescription; 
	private String itemType;
	private String itemStatus; 
	private String itemCurrentPrice;
	private String itemPriceRange;
	
	private String itemPriceRangeType;
	private String itemPriceRangeMode; 
	private String currentFlag;
	private String pauseFlag;
	private String oldStatusFlag;
	private String countTimeFlag;
	private String priceUserId;
	private String priceUserType;
	private String priceBidNum;
	private String proxyType;
	private String proxyMaxValue; 
	private String proxySecValue;
	private String proxyUserId;  
	private String proxyBidNum;
	private String commissionValue;
	private String countValue;
	private String auctionDeleteFlag;
	private String imgUrl;
	private String companyName;
	private Date auctionStartTime;
	private String auctionStatus;
	private String auctionName;
	
	
	
	public String getAuctionName() {
		return auctionName;
	}
	public void setAuctionName(String auctionName) {
		this.auctionName = auctionName;
	}
	public String getAuctionStatus() {
		return auctionStatus;
	}
	public void setAuctionStatus(String auctionStatus) {
		this.auctionStatus = auctionStatus;
	}
	public Date getAuctionStartTime() {
		return auctionStartTime;
	}
	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}
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
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getAuctionId() {
		return auctionId;
	}
	public void setAuctionId(String auctionId) {
		this.auctionId = auctionId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemNumber() {
		return itemNumber;
	}
	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
	}
	public String getViewOrder() {
		return viewOrder;
	}
	public void setViewOrder(String viewOrder) {
		this.viewOrder = viewOrder;
	}
	public String getValuationMethod() {
		return valuationMethod;
	}
	public void setValuationMethod(String valuationMethod) {
		this.valuationMethod = valuationMethod;
	}
	public String getCountNumber() {
		return countNumber;
	}
	public void setCountNumber(String countNumber) {
		this.countNumber = countNumber;
	}
	public String getCountUnit() {
		return countUnit;
	}
	public void setCountUnit(String countUnit) {
		this.countUnit = countUnit;
	}
	public String getCountContent() {
		return countContent;
	}
	public void setCountContent(String countContent) {
		this.countContent = countContent;
	}
	public String getItemCommissionType() {
		return itemCommissionType;
	}
	public void setItemCommissionType(String itemCommissionType) {
		this.itemCommissionType = itemCommissionType;
	}
	public String getItemCommissionValue() {
		return itemCommissionValue;
	}
	public void setItemCommissionValue(String itemCommissionValue) {
		this.itemCommissionValue = itemCommissionValue;
	}
	public String getMargin() {
		return margin;
	}
	public void setMargin(String margin) {
		this.margin = margin;
	}
	public String getMarginFlag() {
		return marginFlag;
	}
	public void setMarginFlag(String marginFlag) {
		this.marginFlag = marginFlag;
	}
	public String getItemBasePrice() {
		return itemBasePrice;
	}
	public void setItemBasePrice(String itemBasePrice) {
		this.itemBasePrice = itemBasePrice;
	}
	public String getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
	}
	public String getItemReferencePriceFir() {
		return itemReferencePriceFir;
	}
	public void setItemReferencePriceFir(String itemReferencePriceFir) {
		this.itemReferencePriceFir = itemReferencePriceFir;
	}
	public String getItemReferencePriceSec() {
		return itemReferencePriceSec;
	}
	public void setItemReferencePriceSec(String itemReferencePriceSec) {
		this.itemReferencePriceSec = itemReferencePriceSec;
	}
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getRecommendFlag() {
		return recommendFlag;
	}
	public void setRecommendFlag(String recommendFlag) {
		this.recommendFlag = recommendFlag;
	}
	public String getPublishFlag() {
		return publishFlag;
	}
	public void setPublishFlag(String publishFlag) {
		this.publishFlag = publishFlag;
	}
	public String getItemDescription() {
		return itemDescription;
	}
	public void setItemDescription(String itemDescription) {
		this.itemDescription = itemDescription;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItemStatus() {
		return itemStatus;
	}
	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}
	public String getItemCurrentPrice() {
		return itemCurrentPrice;
	}
	public void setItemCurrentPrice(String itemCurrentPrice) {
		this.itemCurrentPrice = itemCurrentPrice;
	}
	public String getItemPriceRange() {
		return itemPriceRange;
	}
	public void setItemPriceRange(String itemPriceRange) {
		this.itemPriceRange = itemPriceRange;
	}
	public String getProxyPriceFlag() {
		return proxyPriceFlag;
	}
	public void setProxyPriceFlag(String proxyPriceFlag) {
		this.proxyPriceFlag = proxyPriceFlag;
	}
	public String getItemPriceRangeType() {
		return itemPriceRangeType;
	}
	public void setItemPriceRangeType(String itemPriceRangeType) {
		this.itemPriceRangeType = itemPriceRangeType;
	}
	public String getItemPriceRangeMode() {
		return itemPriceRangeMode;
	}
	public void setItemPriceRangeMode(String itemPriceRangeMode) {
		this.itemPriceRangeMode = itemPriceRangeMode;
	}
	public String getCurrentFlag() {
		return currentFlag;
	}
	public void setCurrentFlag(String currentFlag) {
		this.currentFlag = currentFlag;
	}
	public String getPauseFlag() {
		return pauseFlag;
	}
	public void setPauseFlag(String pauseFlag) {
		this.pauseFlag = pauseFlag;
	}
	public String getOldStatusFlag() {
		return oldStatusFlag;
	}
	public void setOldStatusFlag(String oldStatusFlag) {
		this.oldStatusFlag = oldStatusFlag;
	}
	public String getCountTimeFlag() {
		return countTimeFlag;
	}
	public void setCountTimeFlag(String countTimeFlag) {
		this.countTimeFlag = countTimeFlag;
	}
	public String getPriceUserId() {
		return priceUserId;
	}
	public void setPriceUserId(String priceUserId) {
		this.priceUserId = priceUserId;
	}
	public String getPriceUserType() {
		return priceUserType;
	}
	public void setPriceUserType(String priceUserType) {
		this.priceUserType = priceUserType;
	}
	public String getPriceBidNum() {
		return priceBidNum;
	}
	public void setPriceBidNum(String priceBidNum) {
		this.priceBidNum = priceBidNum;
	}
	public String getProxyType() {
		return proxyType;
	}
	public void setProxyType(String proxyType) {
		this.proxyType = proxyType;
	}
	public String getProxyMaxValue() {
		return proxyMaxValue;
	}
	public void setProxyMaxValue(String proxyMaxValue) {
		this.proxyMaxValue = proxyMaxValue;
	}
	public String getProxySecValue() {
		return proxySecValue;
	}
	public void setProxySecValue(String proxySecValue) {
		this.proxySecValue = proxySecValue;
	}
	public String getProxyUserId() {
		return proxyUserId;
	}
	public void setProxyUserId(String proxyUserId) {
		this.proxyUserId = proxyUserId;
	}
	public String getProxyBidNum() {
		return proxyBidNum;
	}
	public void setProxyBidNum(String proxyBidNum) {
		this.proxyBidNum = proxyBidNum;
	}
	public String getCommissionValue() {
		return commissionValue;
	}
	public void setCommissionValue(String commissionValue) {
		this.commissionValue = commissionValue;
	}
	public String getCountValue() {
		return countValue;
	}
	public void setCountValue(String countValue) {
		this.countValue = countValue;
	}
	
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAuctionDeleteFlag() {
		return auctionDeleteFlag;
	}
	public void setAuctionDeleteFlag(String auctionDeleteFlag) {
		this.auctionDeleteFlag = auctionDeleteFlag;
	}
	
}
