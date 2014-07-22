package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.dao.IBidRecordInfoDAO;
import com.useeasy.auction.service.IBidRecordInfoService;
import com.useeasy.frame.util.BasePage;

public class BidRecordInfoServiceImp implements IBidRecordInfoService {
	
	private IBidRecordInfoDAO dao;
	
	public IBidRecordInfoDAO getDao() {
		return dao;
	}
	public void setDao(IBidRecordInfoDAO dao) {
		this.dao = dao;
	}

	public String getBidRecordCountInAuction(String accountId) {
		// TODO Auto-generated method stub
		return dao.getBidRecordCountInAuction(accountId);
	}

	public List<Object> getBidRecordListInAuction(String accountId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getBidRecordListInAuction(accountId, basePage);
	}
	
	public List<Object> getBidRecordListInItem(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getBidRecordListInItem(accountId, auctionId);
	}
	public List<Object> getBidRecordListInPrice(String accountId,
			String itemId) {
		// TODO Auto-generated method stub
		return dao.getBidRecordListInPrice(accountId, itemId);
	}
	
	
	
	
	
	
}
