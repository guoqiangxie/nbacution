package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.AuctionBulletin;
import com.useeasy.frame.util.BasePage;

public interface IBulletinInfoDAO {
	
	public String getBulletinCount(String companyId);
	public List<AuctionBulletin> getBulletinList(String companyId, BasePage basePage);
	
	public void saveAuctionBulletin(AuctionBulletin auctionBulletin);
	
	public AuctionBulletin getAuctionBulletin(String id);
	
	public List<AuctionBulletin> getBulletinTopList(String companyId);
}

