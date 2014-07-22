package com.useeasy.aucton.calendar.bean;

import java.util.Date;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.notice.bean.AuctionNotice;

/*
 * 拍卖厅申请
 */
public class PMTSQ {
    private Integer id;
    private Date useDay;//使用天
    private String pmType;//拍卖类别
    private String pmhName;//拍卖会名称
    private String pmCompany;//拍卖公司
    private Date pmTime;//拍卖时间
    private String pmAddress;//拍卖地址
    private String person;//使用人
    private String tel;//电话
    private String phone;//手机
    private String newsPaper;//刊登报纸
    private Date paperTime;//见报日期
    private Long pmhId;//拍卖会关联
    private Long gongGaoId;//公告ID
    private Integer pmt;//拍卖厅
    private Integer ut;//使用时间段
    private String internetMain;//公司网址
    private Long u_id;//公司帐号
    private String stu;//状态，0未补1充补全，2申请删除3修改厅标注是否资料填写，（可先申请厅后填写资料,每次登录后如果有未填写的提示填写）
    private Date creatTime =new Date();
    private String delete ="0";
    private String pmtName;//拍卖厅会名
    private String utName;//时间段名
    private String gongGaoTitle;//公告标题
    private String note;//文本
    
    
    
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getGongGaoTitle() {
		return gongGaoTitle;
	}
	public void setGongGaoTitle(String gongGaoTitle) {
		this.gongGaoTitle = gongGaoTitle;
	}
	public String getPmtName() {
		return pmtName;
	}
	public void setPmtName(String pmtName) {
		this.pmtName = pmtName;
	}
	public String getUtName() {
		return utName;
	}
	public void setUtName(String utName) {
		this.utName = utName;
	}
	public String getStu() {
		return stu;
	}
	public void setStu(String stu) {
		this.stu = stu;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getUseDay() {
		return useDay;
	}
	public void setUseDay(Date useDay) {
		this.useDay = useDay;
	}
	public String getPmType() {
		return pmType;
	}
	public void setPmType(String pmType) {
		this.pmType = pmType;
	}
	public String getPmhName() {
		return pmhName;
	}
	public void setPmhName(String pmhName) {
		this.pmhName = pmhName;
	}
	public String getPmCompany() {
		return pmCompany;
	}
	public void setPmCompany(String pmCompany) {
		this.pmCompany = pmCompany;
	}
	public Date getPmTime() {
		return pmTime;
	}
	public void setPmTime(Date pmTime) {
		this.pmTime = pmTime;
	}
	public String getPmAddress() {
		return pmAddress;
	}
	public void setPmAddress(String pmAddress) {
		this.pmAddress = pmAddress;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNewsPaper() {
		return newsPaper;
	}
	public void setNewsPaper(String newsPaper) {
		this.newsPaper = newsPaper;
	}
	public Date getPaperTime() {
		return paperTime;
	}
	public void setPaperTime(Date paperTime) {
		this.paperTime = paperTime;
	}
	public Long getPmhId() {
		return pmhId;
	}
	public void setPmhId(Long pmhId) {
		this.pmhId = pmhId;
	}
	public Long getGongGaoId() {
		return gongGaoId;
	}
	public void setGongGaoId(Long gongGaoId) {
		this.gongGaoId = gongGaoId;
	}
	public Integer getPmt() {
		return pmt;
	}
	public void setPmt(Integer pmt) {
		this.pmt = pmt;
	}
	public Integer getUt() {
		return ut;
	}
	public void setUt(Integer ut) {
		this.ut = ut;
	}
	public String getInternetMain() {
		return internetMain;
	}
	public void setInternetMain(String internetMain) {
		this.internetMain = internetMain;
	}
	public Long getU_id() {
		return u_id;
	}
	public void setU_id(Long uId) {
		u_id = uId;
	}
	public PMTSQ() {
		 
	}
	public PMTSQ(Date useDay, Integer pmt, Integer ut,Long u_id,String pmCompany) {
		 
		this.useDay = useDay;
		this.pmt = pmt;
		this.ut = ut;
		this.pmCompany = pmCompany;
		this.u_id = u_id;
	}
	public Date getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}
	public String getDelete() {
		return delete;
	}
	public void setDelete(String delete) {
		this.delete = delete;
	}
	
	
	
    
    
    
}
