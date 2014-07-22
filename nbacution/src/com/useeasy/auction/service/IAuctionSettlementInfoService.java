package com.useeasy.auction.service;

import com.useeasy.auction.bean.AuctionSettlementInfo;

public interface IAuctionSettlementInfoService {
	
	public int getIsSettlement(String auctionId,String accountId);
	
	public void saveSettlement(AuctionSettlementInfo auctionSettlementInfo);
}
