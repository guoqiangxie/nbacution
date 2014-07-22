package com.useeasy.auction.canvass_business_orders.bean;

import java.io.Serializable;
import java.util.Date;
/*
 * 拍卖招商信息
 */
public class BusinessBean implements Serializable {
  	private static final long serialVersionUID = 1L;
  private Integer id;	
  private String title;//标题
  private String imgPath;//标题图片
  private Long cid;//拍卖公司ID
  private String companyName;//拍卖公司名称
  private Date createTime;//发布时间
  private String content;//正文
  private String hitcount="0";//点击次数
  private String zstype;//招商类别()
  
  
  
  
 
  
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getImgPath() {
	return imgPath;
}
public void setImgPath(String imgPath) {
	this.imgPath = imgPath;
}
public Long getCid() {
	return cid;
}
public void setCid(Long cid) {
	this.cid = cid;
}
public String getCompanyName() {
	return companyName;
}
public void setCompanyName(String companyName) {
	this.companyName = companyName;
}
public Date getCreateTime() {
	return createTime;
}
public void setCreateTime(Date createTime) {
	this.createTime = createTime;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getHitcount() {
	return hitcount;
}
public void setHitcount(String hitcount) {
	this.hitcount = hitcount;
}
public String getZstype() {
	return zstype;
}
public void setZstype(String zstype) {
	this.zstype = zstype;
}
  
  
  
  
  
  
  
  
}
