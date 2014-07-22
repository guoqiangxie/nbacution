package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class AuctionAccount implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Date createTime;
	private Date updateTime;
	private String deleteFlag;
	private String pmManager;
	private String accountName;
	private String accountPass;
	private String accountStatus;
	private String accountType;
	private String accountRelationId;
	private String accountRegisterCode;
	private Set<SystemPrivilege> privilege = new HashSet<SystemPrivilege>();
	
	 
	public Set<SystemPrivilege> getPrivilege() {
		return privilege;
	}
	public void setPrivilege(Set<SystemPrivilege> privilege) {
		this.privilege = privilege;
	}

	
	
	public String getPmManager() {
		return pmManager;
	}
	public void setPmManager(String pmManager) {
		this.pmManager = pmManager;
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
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getAccountPass() {
		return accountPass;
	}
	public void setAccountPass(String accountPass) {
		this.accountPass = accountPass;
	}
	public String getAccountStatus() {
		return accountStatus;
	}
	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}
	public String getAccountType() {
		return accountType;
	}
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	public String getAccountRelationId() {
		return accountRelationId;
	}
	public void setAccountRelationId(String accountRelationId) {
		this.accountRelationId = accountRelationId;
	}
	public String getAccountRegisterCode() {
		return accountRegisterCode;
	}
	public void setAccountRegisterCode(String accountRegisterCode) {
		this.accountRegisterCode = accountRegisterCode;
	}
	
}
