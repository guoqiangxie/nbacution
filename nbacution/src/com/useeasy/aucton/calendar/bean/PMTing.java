package com.useeasy.aucton.calendar.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
/*
 * 拍卖厅编制
 */
 
public class PMTing implements Serializable{
 
	private static final long serialVersionUID = -7869603575283371824L;
    private Integer id;
    private String pmtName; 
	private String notice;  
	private Set<UserTime>  ut = new HashSet<UserTime>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPmtName() {
		return pmtName;
	}
	public void setPmtName(String pmtName) {
		this.pmtName = pmtName;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public Set<UserTime> getUt() {
		return ut;
	}
	public void setUt(Set<UserTime> ut) {
		this.ut = ut;
	}
	 
	
	
}
