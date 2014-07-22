package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionSettlementInfo implements Serializable{

	private static final long serialVersionUID = -8641107581166377556L;

	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	
	private String auctionId;
	private String accountId;
	private String auctionCompanyId;
	private String settlementFlag;
	
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
	public String getAuctionId() {
		return auctionId;
	}
	public void setAuctionId(String auctionId) {
		this.auctionId = auctionId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getAuctionCompanyId() {
		return auctionCompanyId;
	}
	public void setAuctionCompanyId(String auctionCompanyId) {
		this.auctionCompanyId = auctionCompanyId;
	}
	public String getSettlementFlag() {
		return settlementFlag;
	}
	public void setSettlementFlag(String settlementFlag) {
		this.settlementFlag = settlementFlag;
	}
	
	
}
