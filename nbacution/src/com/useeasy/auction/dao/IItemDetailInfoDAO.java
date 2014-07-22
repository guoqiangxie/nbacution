package com.useeasy.auction.dao;

import com.useeasy.auction.bean.ItemDetailInfo;

public interface IItemDetailInfoDAO {
	
	public void saveItemDetailInfo(ItemDetailInfo itemDetailInfo);
	
	public ItemDetailInfo getItemDetailInfo(String itemId);
}

