package com.useeasy.auction.bean;

import java.io.Serializable;

public class ItemInfoIndexDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String deleteFlag;
	
	private String auctionId;
	private String itemName;
	private String itemNumber;
	private String recommendFlag;
	private String itemReferencePriceFir;
	private String itemReferencePriceSec;
	private String itemDescription;
	private String itemLockFlag;
	private String itemStatus;
	private String itemType;
	
	private String auctionStatus;
	private String auctionDeleteFlag;
	private String publishFlag;
	
	private String imgUrl;
	private Long imgCountFlag;
	
	private String companyId;
	
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

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getRecommendFlag() {
		return recommendFlag;
	}

	public void setRecommendFlag(String recommendFlag) {
		this.recommendFlag = recommendFlag;
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

	public String getPublishFlag() {
		return publishFlag;
	}

	public void setPublishFlag(String publishFlag) {
		this.publishFlag = publishFlag;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getItemNumber() {
		return itemNumber;
	}

	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
	}

	public String getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(String auctionId) {
		this.auctionId = auctionId;
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

	public String getItemDescription() {
		return itemDescription;
	}

	public void setItemDescription(String itemDescription) {
		this.itemDescription = itemDescription;
	}

	public String getItemLockFlag() {
		return itemLockFlag;
	}

	public void setItemLockFlag(String itemLockFlag) {
		this.itemLockFlag = itemLockFlag;
	}

	public String getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public Long getImgCountFlag() {
		return imgCountFlag;
	}

	public void setImgCountFlag(Long imgCountFlag) {
		this.imgCountFlag = imgCountFlag;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
}
