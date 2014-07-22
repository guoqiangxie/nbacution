package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionAliveStatus implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private Date operateDate;  
	private String statusContent;  
	private String auctionId;  
	private String itemId;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getOperateDate() {
		return operateDate;
	}
	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}
	
	public String getStatusContent() {
		return statusContent;
	}
	public void setStatusContent(String statusContent) {
		this.statusContent = statusContent;
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
	
}
