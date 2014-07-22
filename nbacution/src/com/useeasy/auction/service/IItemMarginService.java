package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.bean.ItemMarginDto;

public interface IItemMarginService{
	
	public void saveItemMargin(ItemMargin itemMargin);
	
	public String getMarginVal(String accountId, String auctionId, String marginType);
	
	public List<ItemMargin> getItemMargin(String accountId, String auctionId, String marginType);
	
	public void removeItemMargin(ItemMargin itemMargin);
	
	public String getMarginValPayed(String accountId, String auctionId);
	
	public List<ItemMargin> getItemMarginInFinance(String accountId, String auctionId);
	
	public List<ItemMarginDto> getItemMarginInPayment(String auctionId);
	
}

