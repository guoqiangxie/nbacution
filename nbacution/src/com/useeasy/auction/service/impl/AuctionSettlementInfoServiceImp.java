package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.AuctionSettlementInfo;
import com.useeasy.auction.dao.IAuctionSettlementInfoDAO;
import com.useeasy.auction.service.IAuctionSettlementInfoService;

public class AuctionSettlementInfoServiceImp implements
		IAuctionSettlementInfoService {

	IAuctionSettlementInfoDAO dao;
	
	public IAuctionSettlementInfoDAO getDao() {
		return dao;
	}

	public void setDao(IAuctionSettlementInfoDAO dao) {
		this.dao = dao;
	}
	
	public int getIsSettlement(String auctionId, String accountId) {
		AuctionSettlementInfo auctionSettlementInfo = dao.getIsSettlement(auctionId, accountId);
		if(auctionSettlementInfo == null){
			return 0;
		}else{
			return 1;
		}
	}

	public void saveSettlement(AuctionSettlementInfo auctionSettlementInfo) {
		// TODO Auto-generated method stub
		dao.saveSettlement(auctionSettlementInfo);
	}

	

	
}
