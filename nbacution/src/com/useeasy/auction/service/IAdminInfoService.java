package com.useeasy.auction.service;

import com.useeasy.auction.bean.AuctionAdmin;

public interface IAdminInfoService{

	public AuctionAdmin getAdminInfo(String id);
	public void save (AuctionAdmin  admin);
	
}

