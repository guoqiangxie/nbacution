package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.AuctionGuide;
import com.useeasy.auction.dao.IAuctionGuideDAO;
import com.useeasy.auction.service.IAuctionGuideService;

public class AuctionGuideServiceImp implements IAuctionGuideService {

	private IAuctionGuideDAO dao;

	public IAuctionGuideDAO getDao() {
		return dao;
	}

	public void setDao(IAuctionGuideDAO dao) {
		this.dao = dao;
	}

	public List<AuctionGuide> getAuctionGuideList(String searchType) {
		// TODO Auto-generated method stub
		return dao.getAuctionGuideList(searchType);
	}

	public void saveAuctionGuide(AuctionGuide auctionGuide) {
		// TODO Auto-generated method stub
		dao.saveAuctionGuide(auctionGuide);
	}

	public AuctionGuide getAuctionGuide(String id) {
		// TODO Auto-generated method stub
		return dao.getAuctionGuide(id);
	}

	

}
