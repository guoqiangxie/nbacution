package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.AuctionTeamType;

public interface IAuctionTeamTypeService{

	public List<AuctionTeamType> getAuctionTeamType(String auctionId);
	
	public void saveTeamType(AuctionTeamType auctionTeamType);
	
	public AuctionTeamType getTeamType(String id);
	
	public void removeTeamType(AuctionTeamType auctionTeamType);
	
}

