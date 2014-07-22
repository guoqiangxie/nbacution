package com.useeasy.auction.bean;

import java.io.Serializable;

public class CompanyInfoIndexDto implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String deleteFlag;
	
	private String companyName;
	private Long companyOrder;
	
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
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public Long getCompanyOrder() {
		return companyOrder;
	}
	public void setCompanyOrder(Long companyOrder) {
		this.companyOrder = companyOrder;
	}
	
	
}
