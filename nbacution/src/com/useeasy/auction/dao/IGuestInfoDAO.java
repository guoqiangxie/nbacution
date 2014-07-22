package com.useeasy.auction.dao;

import com.useeasy.auction.bean.AuctionGuest;

public interface IGuestInfoDAO {
	
	public AuctionGuest getGuestInfo(String id);
	
	public void saveGuestInfo(AuctionGuest auctionGuest);
}

