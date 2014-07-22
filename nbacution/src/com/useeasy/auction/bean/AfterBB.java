package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.Date;
/*
 * 拍卖 会后工商报备
 */
public class AfterBB implements Serializable {
 
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String pmh_id;//拍卖会ID
    private String pmhName;//拍卖会名称
    private Date pmhTime;//拍卖时间
    private Date createTime;//报备时间
    private String cheJiao;//成交数
    private String chenJiaoE;//成交额
    private String jinMaiRen;//竟买人
    private String liuPai;//流拍数
    private String chePai;//撤拍数
    private String  xianChangQk;//现在情况
    private String taRenWeiTuo;//他人委托
    private String pubGongHangTel;//拍卖公告举报
    private String jingJiaChenXun;//经过竟价程序
    private String weiTuoJinMai;//是否委托竟买
    private String diJiaXieLou;//底价泄露
    private String shiXiaDingJia;//私下定价
    private String yaJia;//压价
    private String qiHangBaShi;//欺行霸市
    private String touShu;//投诉情况
    private String other;//其他
    
    
    
    
	public String getPmh_id() {
		return pmh_id;
	}
	public void setPmh_id(String pmhId) {
		pmh_id = pmhId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPmhName() {
		return pmhName;
	}
	public void setPmhName(String pmhName) {
		this.pmhName = pmhName;
	}
	public Date getPmhTime() {
		return pmhTime;
	}
	public void setPmhTime(Date pmhTime) {
		this.pmhTime = pmhTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCheJiao() {
		return cheJiao;
	}
	public void setCheJiao(String cheJiao) {
		this.cheJiao = cheJiao;
	}
	public String getChenJiaoE() {
		return chenJiaoE;
	}
	public void setChenJiaoE(String chenJiaoE) {
		this.chenJiaoE = chenJiaoE;
	}
	public String getJinMaiRen() {
		return jinMaiRen;
	}
	public void setJinMaiRen(String jinMaiRen) {
		this.jinMaiRen = jinMaiRen;
	}
	public String getLiuPai() {
		return liuPai;
	}
	public void setLiuPai(String liuPai) {
		this.liuPai = liuPai;
	}
	public String getChePai() {
		return chePai;
	}
	public void setChePai(String chePai) {
		this.chePai = chePai;
	}
	public String getXianChangQk() {
		return xianChangQk;
	}
	public void setXianChangQk(String xianChangQk) {
		this.xianChangQk = xianChangQk;
	}
	public String getTaRenWeiTuo() {
		return taRenWeiTuo;
	}
	public void setTaRenWeiTuo(String taRenWeiTuo) {
		this.taRenWeiTuo = taRenWeiTuo;
	}
	public String getPubGongHangTel() {
		return pubGongHangTel;
	}
	public void setPubGongHangTel(String pubGongHangTel) {
		this.pubGongHangTel = pubGongHangTel;
	}
	public String getJingJiaChenXun() {
		return jingJiaChenXun;
	}
	public void setJingJiaChenXun(String jingJiaChenXun) {
		this.jingJiaChenXun = jingJiaChenXun;
	}
	public String getWeiTuoJinMai() {
		return weiTuoJinMai;
	}
	public void setWeiTuoJinMai(String weiTuoJinMai) {
		this.weiTuoJinMai = weiTuoJinMai;
	}
	public String getDiJiaXieLou() {
		return diJiaXieLou;
	}
	public void setDiJiaXieLou(String diJiaXieLou) {
		this.diJiaXieLou = diJiaXieLou;
	}
	public String getShiXiaDingJia() {
		return shiXiaDingJia;
	}
	public void setShiXiaDingJia(String shiXiaDingJia) {
		this.shiXiaDingJia = shiXiaDingJia;
	}
	public String getYaJia() {
		return yaJia;
	}
	public void setYaJia(String yaJia) {
		this.yaJia = yaJia;
	}
	public String getQiHangBaShi() {
		return qiHangBaShi;
	}
	public void setQiHangBaShi(String qiHangBaShi) {
		this.qiHangBaShi = qiHangBaShi;
	}
	public String getTouShu() {
		return touShu;
	}
	public void setTouShu(String touShu) {
		this.touShu = touShu;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
    
    
    
    
    
    
    
}
