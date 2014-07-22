package com.useeasy.auction.dao;


import com.useeasy.auction.bean.AuctionSettlementInfo;

public interface IAuctionSettlementInfoDAO {
	
	public AuctionSettlementInfo getIsSettlement(String auctionId,String accountId);
	
	public void saveSettlement(AuctionSettlementInfo auctionSettlementInfo);
	
}
