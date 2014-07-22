package com.useeasy.auction.bean;

import java.io.Serializable;
/*
 * 导入人员信息表
 */
public class ImportPersonInfo implements Serializable {
 
	private static final long serialVersionUID = 1L;
	private Integer id;//Id号设为自增长
	private String uName;//姓名
	private String uSex;//性别	//
	private String tel;//电话
	private String address;//	住址
	private String bid;//	牌号
	private String pmh_id;//所属拍卖会
	 
	
	
	 
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getuSex() {
		return uSex;
	}
	public void setuSex(String uSex) {
		this.uSex = uSex;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getPmh_id() {
		return pmh_id;
	}
	public void setPmh_id(String pmhId) {
		pmh_id = pmhId;
	}
	public ImportPersonInfo(Integer id, String uName, String uSex,
			String tel, String address, String bid, String pmhId) {
		 
		this.id = id;
		this.uName = uName;
		this.uSex = uSex;
		this.tel = tel;
		this.address = address;
		this.bid = bid;
		pmh_id = pmhId;
	}
	public ImportPersonInfo() {
		super();
	}
 

}
