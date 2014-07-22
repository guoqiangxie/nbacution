package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.AuctionTeamType;
import com.useeasy.auction.dao.IAuctionTeamTypeDAO;
import com.useeasy.auction.service.IAuctionTeamTypeService;

public class AuctionTeamTypeServiceImp implements IAuctionTeamTypeService {

	private IAuctionTeamTypeDAO dao;

	public IAuctionTeamTypeDAO getDao() {
		return dao;
	}

	public void setDao(IAuctionTeamTypeDAO dao) {
		this.dao = dao;
	}

	public List<AuctionTeamType> getAuctionTeamType(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getAuctionTeamType(auctionId);
	}

	public void saveTeamType(AuctionTeamType auctionTeamType) {
		// TODO Auto-generated method stub
		dao.saveTeamType(auctionTeamType);
	}

	public AuctionTeamType getTeamType(String id) {
		// TODO Auto-generated method stub
		return dao.getTeamType(id);
	}

	public void removeTeamType(AuctionTeamType auctionTeamType) {
		// TODO Auto-generated method stub
		dao.removeTeamType(auctionTeamType);
	}

	

}
