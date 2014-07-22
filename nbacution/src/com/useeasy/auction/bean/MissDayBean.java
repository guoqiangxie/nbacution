package com.useeasy.auction.bean;

import java.util.Date;


/*
 * 计算注册过期bean
 */
public class MissDayBean {
  private Integer id;
  private Date zhuCeDay ;//注册
  private Date useDay;//使用的掉的日期
  private Integer missDay;//过期天
  private String flag="0";//标记是否作废记录
public Date getZhuCeDay() {
	return zhuCeDay;
}
public void setZhuCeDay(Date zhuCeDay) {
	this.zhuCeDay = zhuCeDay;
}
public Date getUseDay() {
	return useDay;
}
public void setUseDay(Date useDay) {
	this.useDay = useDay;
}
public Integer getMissDay() {
	return missDay;
}
public void setMissDay(Integer missDay) {
	this.missDay = missDay;
}
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public String getFlag() {
	return flag;
}
public void setFlag(String flag) {
	this.flag = flag;
}
  
}
