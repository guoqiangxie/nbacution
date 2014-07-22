package com.useeasy.auction.notice.bean;

import java.io.Serializable;
import java.util.Date;

public class AuctionNotice implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private long id;
	private String title;
	private String notice_type;//公告类型
	private String notice_content;
	private String phone;
	private Date createtime;
	private String delete_flag="0";
	private String company;
	private String pmhName;
	private String other;
	private long pmhid;//拍卖会d
	private Integer tingID;//拍卖厅id
	private long uid;//拍卖公司ID
	private Date jb; //见报日期
    private String pageNews;

 
	public AuctionNotice() {
		super();
	}

	public String getPageNews() {
		return pageNews;
	}

	public void setPageNews(String pageNews) {
		this.pageNews = pageNews;
	}

	public Date getJb() {
		return jb;
	}

	public void setJb(Date jb) {
		this.jb = jb;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public long getUid() {
		return uid;
	}

	public void setUid(long uid) {
		this.uid = uid;
	}

	 

	public long getPmhid() {
		return pmhid;
	}

	public void setPmhid(long pmhid) {
		this.pmhid = pmhid;
	}

	public Integer getTingID() {
		return tingID;
	}

	public void setTingID(Integer tingID) {
		this.tingID = tingID;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

 

	public String getPmhName() {
		return pmhName;
	}

	public void setPmhName(String pmhName) {
		this.pmhName = pmhName;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getNotice_type() {
		return notice_type;
	}

	public void setNotice_type(String notice_type) {
		this.notice_type = notice_type;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	 

	public String getDelete_flag() {
		return delete_flag;
	}

	public void setDelete_flag(String delete_flag) {
		this.delete_flag = delete_flag;
	}

}
