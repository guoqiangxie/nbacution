package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.dao.IAdminInfoDAO;
import com.useeasy.auction.service.IAdminInfoService;

public class AdminInfoServiceImp implements IAdminInfoService {

	private IAdminInfoDAO dao;

	public IAdminInfoDAO getDao() {
		return dao;
	}

	public void setDao(IAdminInfoDAO dao) {
		this.dao = dao;
	}

	public AuctionAdmin getAdminInfo(String admin_id) {
		// TODO Auto-generated method stub
		return dao.getAdminInfo(admin_id);
	}

	
	public void save (AuctionAdmin  admin){
		 dao.save(admin);
	}
	
	
}
