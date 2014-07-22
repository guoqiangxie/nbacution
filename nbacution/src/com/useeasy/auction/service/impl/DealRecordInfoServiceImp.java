package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.dao.IDealRecordInfoDAO;
import com.useeasy.auction.service.IDealRecordInfoService;
import com.useeasy.frame.util.BasePage;

public class DealRecordInfoServiceImp implements IDealRecordInfoService {

	private IDealRecordInfoDAO dao;
	
	public IDealRecordInfoDAO getDao() {
		return dao;
	}

	public void setDao(IDealRecordInfoDAO dao) {
		this.dao = dao;
	}

	public String getDealRecordCountInAuction(String accountId) {
		// TODO Auto-generated method stub
		return dao.getDealRecordCountInAuction(accountId);
	}

	public List<Object> getDealRecordListInAuction(String accountId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getDealRecordListInAuction(accountId, basePage);
	}

	public List<Object> getDealRecordListInItem(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getDealRecordListInItem(accountId, auctionId);
	}

	
	/*public String getPayRecordCount(String accountId) {
	return dao.getPayRecordCount(accountId);
	}
	
	public List<PayRecordInfo> getPayRecordList(String accountId,
			BasePage basePage) {
		return dao.getPayRecordList(accountId, basePage);
	}
	
	public PayRecordInfo getPayRecord(String auctionId,String accountId){
		return dao.getPayRecord(auctionId, accountId);
	}*/
}
