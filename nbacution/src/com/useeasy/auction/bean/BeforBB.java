package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;
/*
 * 备案前报备信息
 */
public class BeforBB implements Serializable{
    
	private static final long serialVersionUID = 1238265391242475264L;
	private Integer id;
    private String pmh_id;
    private Date createTime;
    private String bbType;//报备类型，工商还是法院0为工商
    private String pmhName;//拍卖会名称
    private String pmhAddress;// 拍卖会地址 
    private Date pmhTime;// 拍卖会时间 
    private String pp;//主要拍品 
    private String ggmt;//公告发布媒体     
    private Date pubTime;//  公告发布日期 
    private Date biaoTime;// 拍卖标的展示日期 
    private String biaoAddress;//拍卖标的展示地址  
    private String pmsName;// 拍卖师姓名：
    private String pmNumber;//拍卖师证号
    private String fzrName;//现场负责人姓名
    private String accountBook;//拍卖委托书份数
    private Double wtMoney;//拍卖委托金额
    private String lxr;//联系人
    private String lxTel;// 联系方式
    private String qymc;//填表企业名称
    private String zgzfyj;//拍卖师资格证复印件
    private String pmggfyj;//拍卖公告复印件
    private String bdqd;//	拍卖标的清单
    private String spwj;//相关审批文件
    private String tbgd;//竞买人须知及拍卖特别规定 
    
    
	public BeforBB(Integer id, String pmhId, Date createTime, String bbType,
			String pmhName, String pmhAddress, Date pmhTime, String pp,
			String ggmt, Date pubTime, Date biaoTime, String biaoAddress,
			String pmsName, String pmNumber, String fzrName,
			String accountBook, Double wtMoney, String lxr, String lxTel,
			String qymc, String zgzfyj, String pmggfyj, String bdqd,
			String spwj, String tbgd) {
		
		this.id = id;
		pmh_id = pmhId;
		this.createTime = createTime;
		this.bbType = bbType;
		this.pmhName = pmhName;
		this.pmhAddress = pmhAddress;
		this.pmhTime = pmhTime;
		this.pp = pp;
		this.ggmt = ggmt;
		this.pubTime = pubTime;
		this.biaoTime = biaoTime;
		this.biaoAddress = biaoAddress;
		this.pmsName = pmsName;
		this.pmNumber = pmNumber;
		this.fzrName = fzrName;
		this.accountBook = accountBook;
		this.wtMoney = wtMoney;
		this.lxr = lxr;
		this.lxTel = lxTel;
		this.qymc = qymc;
		this.zgzfyj = zgzfyj;
		this.pmggfyj = pmggfyj;
		this.bdqd = bdqd;
		this.spwj = spwj;
		this.tbgd = tbgd;
	}
	public String getQymc() {
		return qymc;
	}
	public void setQymc(String qymc) {
		this.qymc = qymc;
	}
	public String getZgzfyj() {
		return zgzfyj;
	}
	public void setZgzfyj(String zgzfyj) {
		this.zgzfyj = zgzfyj;
	}
	public String getPmggfyj() {
		return pmggfyj;
	}
	public void setPmggfyj(String pmggfyj) {
		this.pmggfyj = pmggfyj;
	}
	public String getBdqd() {
		return bdqd;
	}
	public void setBdqd(String bdqd) {
		this.bdqd = bdqd;
	}
	public String getSpwj() {
		return spwj;
	}
	public void setSpwj(String spwj) {
		this.spwj = spwj;
	}
	public String getTbgd() {
		return tbgd;
	}
	public void setTbgd(String tbgd) {
		this.tbgd = tbgd;
	}
	public String getPmsName() {
		return pmsName;
	}
	public void setPmsName(String pmsName) {
		this.pmsName = pmsName;
	}
	public String getPmNumber() {
		return pmNumber;
	}
	public void setPmNumber(String pmNumber) {
		this.pmNumber = pmNumber;
	}
	public String getFzrName() {
		return fzrName;
	}
	public void setFzrName(String fzrName) {
		this.fzrName = fzrName;
	}
	public String getAccountBook() {
		return accountBook;
	}
	public void setAccountBook(String accountBook) {
		this.accountBook = accountBook;
	}
	public Double getWtMoney() {
		return wtMoney;
	}
	public void setWtMoney(Double wtMoney) {
		this.wtMoney = wtMoney;
	}
	public String getLxr() {
		return lxr;
	}
	public void setLxr(String lxr) {
		this.lxr = lxr;
	}
	public String getLxTel() {
		return lxTel;
	}
	public void setLxTel(String lxTel) {
		this.lxTel = lxTel;
	}
	public BeforBB() {
		 
	}
	 	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPmh_id() {
		return pmh_id;
	}
	public void setPmh_id(String pmhId) {
		pmh_id = pmhId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getBbType() {
		return bbType;
	}
	public void setBbType(String bbType) {
		this.bbType = bbType;
	}
	public String getPmhName() {
		return pmhName;
	}
	public void setPmhName(String pmhName) {
		this.pmhName = pmhName;
	}
	public String getPmhAddress() {
		return pmhAddress;
	}
	public void setPmhAddress(String pmhAddress) {
		this.pmhAddress = pmhAddress;
	}
	public Date getPmhTime() {
		return pmhTime;
	}
	public void setPmhTime(Date pmhTime) {
		this.pmhTime = pmhTime;
	}
	public String getPp() {
		return pp;
	}
	public void setPp(String pp) {
		this.pp = pp;
	}
	public String getGgmt() {
		return ggmt;
	}
	public void setGgmt(String ggmt) {
		this.ggmt = ggmt;
	}
	public Date getPubTime() {
		return pubTime;
	}
	public void setPubTime(Date pubTime) {
		this.pubTime = pubTime;
	}
	public Date getBiaoTime() {
		return biaoTime;
	}
	public void setBiaoTime(Date biaoTime) {
		this.biaoTime = biaoTime;
	}
	public String getBiaoAddress() {
		return biaoAddress;
	}
	public void setBiaoAddress(String biaoAddress) {
		this.biaoAddress = biaoAddress;
	}
    
    
    
    
}
