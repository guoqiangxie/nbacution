package com.useeasy.auction.service;

import com.useeasy.auction.bean.AuctionGuest;

public interface IGuestInfoService{

	public AuctionGuest getGuestInfo(String id);
	
	public void saveGuestInfo(AuctionGuest auctionGuest);
}

