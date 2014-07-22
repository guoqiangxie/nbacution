package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class PassRecover implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	
	private String accountName;
	private String accountPassTemp;
	private String accountPassType;
	
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
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getAccountPassTemp() {
		return accountPassTemp;
	}
	public void setAccountPassTemp(String accountPassTemp) {
		this.accountPassTemp = accountPassTemp;
	}
	public String getAccountPassType() {
		return accountPassType;
	}
	public void setAccountPassType(String accountPassType) {
		this.accountPassType = accountPassType;
	}
	
	
}
