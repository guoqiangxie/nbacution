package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.ItemDetailInfo;
import com.useeasy.auction.dao.IItemDetailInfoDAO;
import com.useeasy.auction.service.IItemDetailInfoService;

public class ItemDetailInfoServiceImp implements IItemDetailInfoService {

	private IItemDetailInfoDAO dao;

	public IItemDetailInfoDAO getDao() {
		return dao;
	}

	public void setDao(IItemDetailInfoDAO dao) {
		this.dao = dao;
	}

	
	public void saveItemDetailInfo(ItemDetailInfo itemDetailInfo) {
		// TODO Auto-generated method stub
		dao.saveItemDetailInfo(itemDetailInfo);
	}

	public ItemDetailInfo getItemDetailInfo(String itemId) {
		// TODO Auto-generated method stub
		return dao.getItemDetailInfo(itemId);
	}

}
