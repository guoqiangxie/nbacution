package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.frame.util.BasePage;

public interface IDealRecordInfoService {
	
	public String getDealRecordCountInAuction(String accountId);
	public List<Object> getDealRecordListInAuction(String accountId, BasePage basePage);
	
	public List<Object> getDealRecordListInItem(String accountId,String auctionId);
	
	/*public String getPayRecordCount(String accountId);
	public List<PayRecordInfo> getPayRecordList(String accountId,BasePage basePage);
	public PayRecordInfo getPayRecord(String auctionId,String accountId);*/
}
