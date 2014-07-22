package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.ItemProxyPrice;
import com.useeasy.auction.dao.IItemProxyPriceDAO;
import com.useeasy.auction.dto.ProxyItemInfoDto;
import com.useeasy.auction.service.IItemProxyPriceService;

public class ItemProxyPriceServiceImp implements IItemProxyPriceService {

	private IItemProxyPriceDAO dao;

	public IItemProxyPriceDAO getDao() {
		return dao;
	}

	public void setDao(IItemProxyPriceDAO dao) {
		this.dao = dao;
	}
	
	public List<ProxyItemInfoDto> getProxyItemInfoDtos(String accountId,
			String auctionId, String searchType) {
		// TODO Auto-generated method stub
		return dao.getProxyItemInfoDtos(accountId, auctionId, searchType);
	}

	public void saveItemProxyPrice(ItemProxyPrice itemProxyPrice) {
		// TODO Auto-generated method stub
		dao.saveItemProxyPrice(itemProxyPrice);
	}

	public ItemProxyPrice getItemProxyPrice(String id) {
		// TODO Auto-generated method stub
		return dao.getItemProxyPrice(id);
	}

	public void removeItemProxyPrice(ItemProxyPrice itemProxyPrice) {
		// TODO Auto-generated method stub
		dao.removeItemProxyPrice(itemProxyPrice);
	}
	
	
	
}
