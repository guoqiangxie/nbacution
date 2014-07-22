package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.frame.util.BasePage;

public interface IBidRecordInfoService {
	
	public String getBidRecordCountInAuction(String accountId);
	public List<Object> getBidRecordListInAuction(String accountId, BasePage basePage);
	
	public List<Object> getBidRecordListInItem(String accountId,String auctionId);
	
	public List<Object> getBidRecordListInPrice(String accountId,String itemId);
	
	
}
