package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.AfterBB;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionInfoIndexDto;
import com.useeasy.auction.bean.BeforBB;
import com.useeasy.auction.dto.AuctionInfoDtoIndex;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.frame.util.BasePage;

public interface IAuctionInfoService{

	public String getAuctionCount(String companyId, String searchKind, String searchType, String pubishType);
	public List<AuctionInfoIndexDto> getAuctionList(String companyId, String searchKind, String searchType, String pubishType, BasePage basePage);
	
	
	
	public String getAuctionInfoDtoCount(String companyId, String searchKind, String searchType, String pubishType);
	public List<AuctionInfoDto> getAuctionInfoDtoList(String companyId, String searchKind, String searchType, String pubishType, BasePage basePage);
	
	public AuctionInfoDto getAuctionInfoDto(String id);
	
	public void saveAuctionInfoDto(AuctionInfoDto auctionInfoDto);
	
	public String getAuctionInfoDtoCountInPublish(String searchKind, String searchTime);
	
	public List<AuctionInfoDto> getAuctionInfoDtoListTop();
	
	public AuctionInfoDtoIndex getAuctionInfoIndexDto(String id);
	
	public String getAuctionInfoDtoCountInSearch(String companyId, String searchKind, String searchType, String pubishType, String key);
	public List<AuctionInfoDto> getAuctionInfoDtoListInSearch(String companyId, String searchKind, String searchType, String pubishType, BasePage basePage, String key);
	
	public void saveAuctionInfo(AuctionInfo auctionInfo);
	
	public AuctionInfo getAuctionInfo(String id);
	
	public List<Object[]> getAuctionAliveStatus(String auctionId);
	public void    saveBeforBB(BeforBB  b);
	public void saveAfter(AfterBB b );
}

