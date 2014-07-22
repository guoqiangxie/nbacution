package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemGoodsDto;
import com.useeasy.auction.dao.IItemGoodsDAO;
import com.useeasy.auction.service.IItemGoodsService;

public class ItemGoodsServiceImp implements IItemGoodsService {

	private IItemGoodsDAO dao;

	public IItemGoodsDAO getDao() {
		return dao;
	}

	public void setDao(IItemGoodsDAO dao) {
		this.dao = dao;
	}

	public void saveItemGoods(ItemGoods itemGoods) {
		// TODO Auto-generated method stub
		dao.saveItemGoods(itemGoods);
	}

	public String getGoodsVal(String accountId, String auctionId,
			String goodsType) {
		// TODO Auto-generated method stub
		return dao.getGoodsVal(accountId, auctionId, goodsType);
	}

	public List<ItemGoods> getItemGoodsInFinance(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemGoodsInFinance(accountId, auctionId);
	}

	public List<ItemGoodsDto> getItemGoodsInPayment(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemGoodsInPayment(auctionId);
	}

	
}
