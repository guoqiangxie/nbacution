package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.AuctionBulletin;
import com.useeasy.auction.dao.IBulletinInfoDAO;
import com.useeasy.auction.service.IBulletinInfoService;
import com.useeasy.frame.util.BasePage;

public class BulletinInfoServiceImp implements IBulletinInfoService {

	private IBulletinInfoDAO dao;

	public IBulletinInfoDAO getDao() {
		return dao;
	}
	
	public void setDao(IBulletinInfoDAO dao) {
		this.dao = dao;
	}

	public String getBulletinCount(String companyId) {
		// TODO Auto-generated method stub
		return dao.getBulletinCount(companyId);
	}

	public List<AuctionBulletin> getBulletinList(String companyId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getBulletinList(companyId, basePage);
	}

	public void saveAuctionBulletin(AuctionBulletin auctionBulletin) {
		// TODO Auto-generated method stub
		dao.saveAuctionBulletin(auctionBulletin);
	}

	public AuctionBulletin getAuctionBulletin(String id) {
		// TODO Auto-generated method stub
		return dao.getAuctionBulletin(id);
	}

	public List<AuctionBulletin> getBulletinTopList(String companyId) {
		// TODO Auto-generated method stub
		return dao.getBulletinTopList(companyId);
	}
	
}
