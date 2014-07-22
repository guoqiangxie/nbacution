package com.useeasy.auction.service;

import com.useeasy.auction.bean.ItemDetailInfo;

public interface IItemDetailInfoService{

	public void saveItemDetailInfo(ItemDetailInfo itemDetailInfo);
	
	public ItemDetailInfo getItemDetailInfo(String itemId);
	
}

