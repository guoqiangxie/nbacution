package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.frame.util.BasePage;

public interface IBidRecordInfoDAO {
	
	public String getBidRecordCountInAuction(String accountId);
	public List<Object> getBidRecordListInAuction(String accountId, BasePage basePage);
	
	public List<Object> getBidRecordListInItem(String accountId,String auctionId);
	
	public List<Object> getBidRecordListInPrice(String accountId,String itemId);
	
	
}
