package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.ItemProxyPrice;
import com.useeasy.auction.dto.ProxyItemInfoDto;

public interface IItemProxyPriceService{
	
	public List<ProxyItemInfoDto> getProxyItemInfoDtos(String accountId, String auctionId, String searchType);
	
	public void saveItemProxyPrice(ItemProxyPrice itemProxyPrice);
	
	public ItemProxyPrice getItemProxyPrice(String id);
	
	public void removeItemProxyPrice(ItemProxyPrice itemProxyPrice);
	
}

