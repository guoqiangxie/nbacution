package com.useeasy.auction.dto;

import java.io.Serializable;
import java.util.Date;

public class ProxyItemInfoDto implements Serializable{

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
	
	private Long proxyPriceId;
	private String proxyPrice;
	
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
	public Long getProxyPriceId() {
		return proxyPriceId;
	}
	public void setProxyPriceId(Long proxyPriceId) {
		this.proxyPriceId = proxyPriceId;
	}
	public String getProxyPrice() {
		return proxyPrice;
	}
	public void setProxyPrice(String proxyPrice) {
		this.proxyPrice = proxyPrice;
	}
	
	
	
	
}
