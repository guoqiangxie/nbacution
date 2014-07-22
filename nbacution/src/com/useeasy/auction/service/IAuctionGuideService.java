package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.AuctionGuide;

public interface IAuctionGuideService {
	
	public List<AuctionGuide> getAuctionGuideList(String searchType);
	
	public void saveAuctionGuide(AuctionGuide auctionGuide);
	
	public AuctionGuide getAuctionGuide(String  id);
	
}

