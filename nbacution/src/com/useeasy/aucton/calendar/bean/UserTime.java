package com.useeasy.aucton.calendar.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
/**
 * 拍卖厅使用时间
 */
public class UserTime implements Serializable {
   private static final long serialVersionUID = 1L;
   private Integer id;
   private String useTime; 
   private String notice;
   private Set<PMTing> pmt = new HashSet<PMTing>();
   
   
   
   
public Integer getId() { 
	 
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public String getUseTime() {
	return useTime;
}
public void setUseTime(String useTime) {
	this.useTime = useTime;
}
public String getNotice() {
	return notice;
}
public void setNotice(String notice) {
	this.notice = notice;
}
public Set<PMTing> getPmt() {
	return pmt;
}
public void setPmt(Set<PMTing> pmt) {
 
	this.pmt = pmt;
}
   
   
   
}
