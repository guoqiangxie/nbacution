package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.bean.ItemMarginDto;
import com.useeasy.auction.dao.IItemMarginDAO;
import com.useeasy.auction.service.IItemMarginService;

public class ItemMarginServiceImp implements IItemMarginService {

	private IItemMarginDAO dao;

	public IItemMarginDAO getDao() {
		return dao;
	}

	public void setDao(IItemMarginDAO dao) {
		this.dao = dao;
	}

	public void saveItemMargin(ItemMargin itemMargin) {
		// TODO Auto-generated method stub
		dao.saveItemMargin(itemMargin);
	}

	public String getMarginVal(String accountId, String auctionId,
			String marginType) {
		// TODO Auto-generated method stub
		return dao.getMarginVal(accountId, auctionId, marginType);
	}

	public List<ItemMargin> getItemMargin(String accountId, String auctionId,
			String marginType) {
		// TODO Auto-generated method stub
		return dao.getItemMargin(accountId, auctionId, marginType);
	}

	public void removeItemMargin(ItemMargin itemMargin) {
		// TODO Auto-generated method stub
		dao.removeItemMargin(itemMargin);
	}

	public String getMarginValPayed(String accountId, String auctionId) {
		// TODO Auto-generated method stub
		return dao.getMarginValPayed(accountId, auctionId);
	}

	public List<ItemMargin> getItemMarginInFinance(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemMarginInFinance(accountId, auctionId);
	}

	public List<ItemMarginDto> getItemMarginInPayment(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemMarginInPayment(auctionId);
	}

	

	

}
