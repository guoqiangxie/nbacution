package com.useeasy.auction.intenetView.bean;

import java.util.Date;

public class IntenetView {
	private Long id;
	private String accountName;// not null
	private String accountPass; // String not null
	private String pmh_id;// Long not null
	private String viewSta="0"; // String //(2) 默认0 审过1
    private Date createTime = new Date();
	private String deleteFlag = "0";
	
	
	
	
	public IntenetView() {
		super();
	}
   
	public IntenetView(String accountName, String accountPass, String pmhId,
			String viewSta) {
		super();
		this.accountName = accountName;
		this.accountName = accountName;
		pmh_id = pmhId;
		this.viewSta = viewSta;
	}

	 
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getPmh_id() {
		return pmh_id;
	}

	public void setPmh_id(String pmhId) {
		pmh_id = pmhId;
	}

	public String getViewSta() {
		return viewSta;
	}

	public void setViewSta(String viewSta) {
		this.viewSta = viewSta;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

}
