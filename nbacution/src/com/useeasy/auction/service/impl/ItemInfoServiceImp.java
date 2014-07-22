package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemInfoIndexDto;
import com.useeasy.auction.bean.ItemPriceRecord;
import com.useeasy.auction.dao.IItemInfoDAO;
import com.useeasy.auction.dto.ItemInfoDto;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.frame.util.BasePage;

public class ItemInfoServiceImp implements IItemInfoService {

	private IItemInfoDAO dao;

	public IItemInfoDAO getDao() {
		return dao;
	}

	public void setDao(IItemInfoDAO dao) {
		this.dao = dao;
	}

	public List<ItemInfoIndexDto> getItemRecommendItemList() {
		// TODO Auto-generated method stub
		return dao.getItemRecommendItemList();
	}

	public List<ItemInfo> getItemList(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemList(auctionId);
	}

	public void saveItemInfo(ItemInfo itemInfo) {
		// TODO Auto-generated method stub
		dao.saveItemInfo(itemInfo);
	}

	public List<ItemInfo> getItemInfoByRecommend(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoByRecommend(auctionId);
	}

	public ItemInfo getItemInfo(String id) {
		// TODO Auto-generated method stub
		return dao.getItemInfo(id);
	}

	public ItemInfo getItemInfoByIndexAndAuction(String itemIdex,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoByIndexAndAuction(itemIdex, auctionId);
	}

	public String getItemCount(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemCount(auctionId);
	}

	public List<ItemInfoIndexDto> getItemList(String auctionId, BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getItemList(auctionId, basePage);
	}

	public List<ItemInfoIndexDto> getItemInfoListTop(String typeId,
			String itemId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoListTop(typeId, itemId);
	}

	public List<ItemInfo> getItemListInFinance(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemListInFinance(auctionId);
	}

	public String getItemCountInSearch(String companyId, String searchKind,
			String key) {
		// TODO Auto-generated method stub
		return dao.getItemCountInSearch(companyId, searchKind, key);
	}

	public List<ItemInfoIndexDto> getItemListInSearch(String companyId,
			String searchKind, BasePage basePage, String key) {
		// TODO Auto-generated method stub
		return dao.getItemListInSearch(companyId, searchKind, basePage, key);
	}

	public List<ItemInfoIndexDto> getItemInfoTopListInCompanyIndex(
			String companyId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoTopListInCompanyIndex(companyId);
	}

	public List<ItemPriceRecord> getItemPrice(String itemId) {
		// TODO Auto-generated method stub
		return dao.getItemPrice(itemId);
	}

	public String getItemCountInAnalyze(String auctionId, String searchKind) {
		// TODO Auto-generated method stub
		return dao.getItemCountInAnalyze(auctionId, searchKind);
	}

	public String getItemPriceCountInAnalyze(String auctionId, String searchKind) {
		// TODO Auto-generated method stub
		return dao.getItemPriceCountInAnalyze(auctionId, searchKind);
	}

	public String getPricedItemCountInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		return dao.getPricedItemCountInAnalyze(auctionId, searchKind);
	}

	public String getDealedItemCurrentPriceInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		return dao.getDealedItemCurrentPriceInAnalyze(auctionId, searchKind);
	}

	public String getDealedItemPriceInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		return dao.getDealedItemPriceInAnalyze(auctionId, searchKind);
	}

	public List<ItemInfo> getItemResultList(String auctionId,
			String searchType, String bidNum) {
		// TODO Auto-generated method stub
		return dao.getItemResultList(auctionId, searchType, bidNum);
	}

	public List<Object> getBidNumResultList(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getBidNumResultList(auctionId);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public List<Object[]> getItemInfoListRecommend() {
		// TODO Auto-generated method stub
		return dao.getItemInfoListRecommend();
	}

	public String getItemInfoDtoCount(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoDtoCount(auctionId);
	}

	public List<ItemInfoDto> getItemInfoDtoList(String auctionId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getItemInfoDtoList(auctionId, basePage);
	}

	public ItemInfoDto getItemInfoDto(String id) {
		// TODO Auto-generated method stub
		return dao.getItemInfoDto(id);
	}

	public ItemInfoDto getItemInfoDtoByIndexAndAuction(String itemIndex,
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoDtoByIndexAndAuction(itemIndex, auctionId);
	}

	public List<Object[]> getItemInfoListSimilar(String typeId, String itemId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoListSimilar(typeId, itemId);
	}

	public String getItemInfoCountInSearch(String companyId, String searchKind,
			String key) {
		// TODO Auto-generated method stub
		return dao.getItemInfoCountInSearch(companyId, searchKind, key);
	}

	public List<Object[]> getItemInfoListInSearch(String companyId,
			String searchKind, BasePage basePage, String key) {
		// TODO Auto-generated method stub
		return dao.getItemInfoListInSearch(companyId, searchKind, basePage, key);
	}

	public List<Object[]> getItemInfoListTop(String companyId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoListTop(companyId);
	}

	public List<ItemInfoDto> getItemInfoDtoList(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getItemInfoDtoList(auctionId);
	}

	

	

}
