package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;

public class QulificationInfo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	
	private String accountId;
	private String qualifyCompany;
	
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getQualifyCompany() {
		return qualifyCompany;
	}
	public void setQualifyCompany(String qualifyCompany) {
		this.qualifyCompany = qualifyCompany;
	}
	
	
	
	
}
