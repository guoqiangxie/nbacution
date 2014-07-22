package com.useeasy.auction.dao;

import com.useeasy.auction.bean.AuctionAdmin;

public interface IAdminInfoDAO{

	public AuctionAdmin getAdminInfo(String id);
	
	public void save (AuctionAdmin  admin);
		 
}

