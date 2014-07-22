package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemInfoIndexDto;
import com.useeasy.auction.bean.ItemPriceRecord;
import com.useeasy.auction.dto.ItemInfoDto;
import com.useeasy.frame.util.BasePage;

public interface IItemInfoDAO {
	
	public List<ItemInfoIndexDto> getItemRecommendItemList();
	
	public List<ItemInfo> getItemList(String auctionId);
	
	public void saveItemInfo(ItemInfo itemInfo);
	
	public List<ItemInfo> getItemInfoByRecommend(String auctionId);
	
	public ItemInfo getItemInfo(String id);
	
	public ItemInfo getItemInfoByIndexAndAuction(String itemIdex, String auctionId);
	
	public String getItemCount(String auctionId);
	public List<ItemInfoIndexDto> getItemList(String auctionId, BasePage basePage);
	
	public List<ItemInfoIndexDto> getItemInfoListTop(String typeId, String itemId);
	
	public List<ItemInfo> getItemListInFinance(String auctionId);
	
	public String getItemCountInSearch(String companyId, String searchKind,  String key);
	public List<ItemInfoIndexDto> getItemListInSearch(String companyId, String searchKind, BasePage basePage, String key);
	
	public List<ItemInfoIndexDto> getItemInfoTopListInCompanyIndex(String companyId);
	
	public List<ItemPriceRecord> getItemPrice(String itemId);
	
	public String getItemCountInAnalyze(String auctionId, String searchKind);
	public String getItemPriceCountInAnalyze(String auctionId, String searchKind);
	public String getPricedItemCountInAnalyze(String auctionId, String searchKind);
	public String getDealedItemCurrentPriceInAnalyze(String auctionId, String searchKind);
	public String getDealedItemPriceInAnalyze(String auctionId, String searchKind);

	public List<ItemInfo> getItemResultList(String auctionId, String searchType, String bidNum);
	public List<Object> getBidNumResultList(String auctionId);
	
	
	
	
	
	
	
	
	
	public List<Object[]> getItemInfoListRecommend();
	
	public String getItemInfoDtoCount(String auctionId);
	public List<ItemInfoDto> getItemInfoDtoList(String auctionId, BasePage basePage);
	
	public ItemInfoDto getItemInfoDto(String id);
	
	public ItemInfoDto getItemInfoDtoByIndexAndAuction(String itemIndex, String auctionId);
	
	public List<Object[]> getItemInfoListSimilar(String typeId, String itemId);

	public String getItemInfoCountInSearch(String companyId, String searchKind,  String key);
	public List<Object[]> getItemInfoListInSearch(String companyId, String searchKind, BasePage basePage, String key);
	
	public List<Object[]> getItemInfoListTop(String companyId);
	
	public List<ItemInfoDto> getItemInfoDtoList(String auctionId);
}

