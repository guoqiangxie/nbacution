package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemGoodsDto;

public interface IItemGoodsDAO {
	
	public void saveItemGoods(ItemGoods itemGoods);
	
	public String getGoodsVal(String accountId, String auctionId, String goodsType);
	
	public List<ItemGoods> getItemGoodsInFinance(String accountId, String auctionId);
	
	public List<ItemGoodsDto> getItemGoodsInPayment(String auctionId);
	
}

