package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.AuctionGuest;
import com.useeasy.auction.dao.IGuestInfoDAO;
import com.useeasy.auction.service.IGuestInfoService;

public class GuestInfoServiceImp implements IGuestInfoService {

	private IGuestInfoDAO dao;

	public IGuestInfoDAO getDao() {
		return dao;
	}

	public void setDao(IGuestInfoDAO dao) {
		this.dao = dao;
	}

	public AuctionGuest getGuestInfo(String guest_id) {
		// TODO Auto-generated method stub
		return dao.getGuestInfo(guest_id);
	}

	public void saveGuestInfo(AuctionGuest auctionGuest) {
		// TODO Auto-generated method stub
		dao.saveGuestInfo(auctionGuest);
	}

	
	

	
	
}
