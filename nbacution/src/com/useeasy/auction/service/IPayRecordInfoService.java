package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.PayRecordInfo;

public interface IPayRecordInfoService {
	
	public void savePayRecordInfo(PayRecordInfo payRecordInfo);
	
	public List<PayRecordInfo> getCheckedPayRecordList(String auctionId, String accountId, String payType);
	
	public PayRecordInfo getPayRecordInfoByOrderId(String orderId);
	
}
