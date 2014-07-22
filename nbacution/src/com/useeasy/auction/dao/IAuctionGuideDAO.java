package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.AuctionGuide;

public interface IAuctionGuideDAO {
	
	public List<AuctionGuide> getAuctionGuideList(String searchType);
	
	public void saveAuctionGuide(AuctionGuide auctionGuide);
	
	public AuctionGuide getAuctionGuide(String  id);
	
}

