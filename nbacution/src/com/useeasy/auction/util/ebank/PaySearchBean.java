package com.useeasy.auction.util.ebank;

import java.io.Serializable;

public class PaySearchBean implements Serializable {
	
	private static final long serialVersionUID = 1L;

	String order; // 订单号

	String orderDate; // 订单日期

	String orderTime; // 订单时间

	String curType; // 币种

	String amount; // 金额

	String tranDate; // 交易日期

	String tranTime; // 交易时间

	String tranState; // 支付交易状态

	String orderState; // 订单状态

	String fee; // 手续费

	String bankSerialNo; // 银行流水号

	String bankBatNo; // 银行批次号

	String cardType; // 交易卡类型0:借记卡 1：准贷记卡 2:贷记卡

	String merchantBatNo; // 商户批次号

	String merchantComment; // 商户备注

	String bankComment; // 银行备注
	
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
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

	public String getCurType() {
		return curType;
	}

	public void setCurType(String curType) {
		this.curType = curType;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getTranDate() {
		return tranDate;
	}

	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}

	public String getTranTime() {
		return tranTime;
	}

	public void setTranTime(String tranTime) {
		this.tranTime = tranTime;
	}

	public String getTranState() {
		return tranState;
	}

	public void setTranState(String tranState) {
		this.tranState = tranState;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getBankSerialNo() {
		return bankSerialNo;
	}

	public void setBankSerialNo(String bankSerialNo) {
		this.bankSerialNo = bankSerialNo;
	}

	public String getBankBatNo() {
		return bankBatNo;
	}

	public void setBankBatNo(String bankBatNo) {
		this.bankBatNo = bankBatNo;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getMerchantBatNo() {
		return merchantBatNo;
	}

	public void setMerchantBatNo(String merchantBatNo) {
		this.merchantBatNo = merchantBatNo;
	}

	public String getMerchantComment() {
		return merchantComment;
	}

	public void setMerchantComment(String merchantComment) {
		this.merchantComment = merchantComment;
	}

	public String getBankComment() {
		return bankComment;
	}

	public void setBankComment(String bankComment) {
		this.bankComment = bankComment;
	}
	
	

}
