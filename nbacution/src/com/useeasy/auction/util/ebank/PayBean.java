package com.useeasy.auction.util.ebank;

import java.io.Serializable;

public class PayBean implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String interfaceVersion;//消息版本号
	
	private String merID;//商户客户号
	
	private String orderid;//订单号
	
	private String orderDate;//订单日期

	private String orderTime;//订单时间

	private String tranType;//交易类别  0  B2C

	private String amount;//金额

	private String curType;//币种

	private String orderContent;//订单内容

	private String orderMono;//商家备注

	private String phdFlag;//物流配送标志 0 非物流 1 物流配送

	private String notifyType;//通知方式 0 不通知 1 通知 2 转页面

	private String merURL;//主动通知URL 为空则不发通知

	private String goodsURL;//取货URL

	private String jumpSeconds;//自动跳转时间

	private String payBatchNo;//商户批次号

	private String proxyMerName;//代理商家名称

	private String proxyMerType;//代理商家证件类型

	private String proxyMerCredentials;//代理商家证件号码

	private String netType;//渠道编号

	private String sourceMsg;  //消息数据

	private String signMsg; //商家签名
	
	public PayBean() {
		this.interfaceVersion = "1.0.0.0";
		this.tranType = "0";
		this.curType = "CNY";
		this.phdFlag = "0";
		this.netType = "0";
	}

	public String getInterfaceVersion() {
		return interfaceVersion;
	}

	public void setInterfaceVersion(String interfaceVersion) {
		this.interfaceVersion = interfaceVersion;
	}

	public String getMerID() {
		return merID;
	}

	public void setMerID(String merID) {
		this.merID = merID;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getTranType() {
		return tranType;
	}

	public void setTranType(String tranType) {
		this.tranType = tranType;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getCurType() {
		return curType;
	}

	public void setCurType(String curType) {
		this.curType = curType;
	}

	public String getOrderContent() {
		return orderContent;
	}

	public void setOrderContent(String orderContent) {
		this.orderContent = orderContent;
	}

	public String getOrderMono() {
		return orderMono;
	}

	public void setOrderMono(String orderMono) {
		this.orderMono = orderMono;
	}

	public String getPhdFlag() {
		return phdFlag;
	}

	public void setPhdFlag(String phdFlag) {
		this.phdFlag = phdFlag;
	}

	public String getNotifyType() {
		return notifyType;
	}

	public void setNotifyType(String notifyType) {
		this.notifyType = notifyType;
	}

	public String getMerURL() {
		return merURL;
	}

	public void setMerURL(String merURL) {
		this.merURL = merURL;
	}

	public String getGoodsURL() {
		return goodsURL;
	}

	public void setGoodsURL(String goodsURL) {
		this.goodsURL = goodsURL;
	}

	public String getJumpSeconds() {
		return jumpSeconds;
	}

	public void setJumpSeconds(String jumpSeconds) {
		this.jumpSeconds = jumpSeconds;
	}

	public String getPayBatchNo() {
		return payBatchNo;
	}

	public void setPayBatchNo(String payBatchNo) {
		this.payBatchNo = payBatchNo;
	}

	public String getProxyMerName() {
		return proxyMerName;
	}

	public void setProxyMerName(String proxyMerName) {
		this.proxyMerName = proxyMerName;
	}

	public String getProxyMerType() {
		return proxyMerType;
	}

	public void setProxyMerType(String proxyMerType) {
		this.proxyMerType = proxyMerType;
	}

	public String getProxyMerCredentials() {
		return proxyMerCredentials;
	}

	public void setProxyMerCredentials(String proxyMerCredentials) {
		this.proxyMerCredentials = proxyMerCredentials;
	}

	public String getNetType() {
		return netType;
	}

	public void setNetType(String netType) {
		this.netType = netType;
	}

	public String getSourceMsg() {
		return sourceMsg;
	}

	public void setSourceMsg(String sourceMsg) {
		this.sourceMsg = sourceMsg;
	}

	public String getSignMsg() {
		return signMsg;
	}

	public void setSignMsg(String signMsg) {
		this.signMsg = signMsg;
	}

}
