package com.useeasy.auction.vocationbean;

import java.io.Serializable;
import java.util.Date;

import com.useeasy.auction.bean.ItemInfo;



public class AuctionVocationNews  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private  long vnewsid; //行业动态id
    private  String vnewsimagepath;//图片路径
    private  String  vnewstitle;//动态标题
   private Date   vnewsdate;//发布时间
    private String  vnewsperson; //发布人
    private  String  vnewscontent;//正文内容
    private long vnewsviewtime;//浏览次数
    private String vnewstype;//动态信息类型
    private ItemInfo pm;

	public ItemInfo getPm() {
		return pm;
	}
	public void setPm(ItemInfo pm) {
		this.pm = pm;
	}
	public String getVnewstype() {
		return vnewstype;
	}
	public void setVnewstype(String vnewstype) {
		this.vnewstype = vnewstype;
	}
	public long getVnewsviewtime() {
		return vnewsviewtime;
	}
	public void setVnewsviewtime(long vnewsviewtime) {
		this.vnewsviewtime = vnewsviewtime;
	}
	public long getVnewsid() {
		return vnewsid;
	}
	public void setVnewsid(long vnewsid) {
		this.vnewsid = vnewsid;
	}
	public String getVnewsimagepath() {
		return vnewsimagepath;
	}
	public void setVnewsimagepath(String vnewsimagepath) {
		this.vnewsimagepath = vnewsimagepath;
	}
	public String getVnewstitle() {
		return vnewstitle;
	}
	public void setVnewstitle(String vnewstitle) {
		this.vnewstitle = vnewstitle;
	}
	public Date getVnewsdate() {
		return vnewsdate;
	}
	public void setVnewsdate(Date vnewsdate) {
		this.vnewsdate = vnewsdate;
	}
	public String getVnewsperson() {
		return vnewsperson;
	}
	public void setVnewsperson(String vnewsperson) {
		this.vnewsperson = vnewsperson;
	}
	public String getVnewscontent() {
		return vnewscontent;
	}
	public void setVnewscontent(String vnewscontent) {
		this.vnewscontent = vnewscontent;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
    
}
