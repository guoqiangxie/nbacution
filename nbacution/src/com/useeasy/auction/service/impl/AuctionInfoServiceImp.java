package com.useeasy.auction.service.impl;


import java.util.List;

import com.useeasy.auction.dao.IAuctionInfoDAO;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.dto.AuctionInfoDtoIndex;
import com.useeasy.auction.bean.AfterBB;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionInfoIndexDto;
import com.useeasy.auction.bean.BeforBB;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.frame.util.BasePage;


public class AuctionInfoServiceImp implements IAuctionInfoService {

	private IAuctionInfoDAO dao;

	public IAuctionInfoDAO getDao() {
		return dao;
	}

	public void setDao(IAuctionInfoDAO dao) {
		this.dao = dao;
	}

	public String getAuctionCount(String companyId, String searchKind,
			String searchType, String pubishType) {
		// TODO Auto-generated method stub
		return dao.getAuctionCount(companyId, searchKind, searchType, pubishType);
	}

	public List<AuctionInfoIndexDto> getAuctionList(String companyId,
			String searchKind, String searchType, String pubishType,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getAuctionList(companyId, searchKind, searchType, pubishType, basePage);
	}

	

	

	

	

	
	
	
	
	
	
	
	
	
	
	
	public String getAuctionInfoDtoCount(String companyId, String searchKind,
			String searchType, String pubishType) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoCount(companyId, searchKind, searchType, pubishType);
	}
	
	public List<AuctionInfoDto> getAuctionInfoDtoList(String companyId,
			String searchKind, String searchType, String pubishType,
			BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoList(companyId, searchKind, searchType, pubishType, basePage);
	}

	public AuctionInfoDto getAuctionInfoDto(String id) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDto(id);
	}

	public void saveAuctionInfoDto(AuctionInfoDto auctionInfoDto) {
		// TODO Auto-generated method stub
		dao.saveAuctionInfoDto(auctionInfoDto);
	}
	
	public String getAuctionInfoDtoCountInPublish(String searchKind,
			String searchTime) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoCountInPublish(searchKind, searchTime);
	}

	public List<AuctionInfoDto> getAuctionInfoDtoListTop() {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoListTop();
	}

	public AuctionInfoDtoIndex getAuctionInfoIndexDto(String id) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoIndexDto(id);
	}

	public String getAuctionInfoDtoCountInSearch(String companyId,
			String searchKind, String searchType, String pubishType, String key) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoCountInSearch(companyId, searchKind, searchType, pubishType, key);
	}

	public List<AuctionInfoDto> getAuctionInfoDtoListInSearch(String companyId,
			String searchKind, String searchType, String pubishType,
			BasePage basePage, String key) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfoDtoListInSearch(companyId, searchKind, searchType, pubishType, basePage, key);
	}

	public void saveAuctionInfo(AuctionInfo auctionInfo) {
		// TODO Auto-generated method stub
		dao.saveAuctionInfo(auctionInfo);
	}

	public AuctionInfo getAuctionInfo(String id) {
		// TODO Auto-generated method stub
		return dao.getAuctionInfo(id);
	}

	public List<Object[]> getAuctionAliveStatus(String auctionId) {
		// TODO Auto-generated method stub
		return dao.getAuctionAliveStatus(auctionId);
	}
   public void	saveBeforBB(BeforBB  b){
	   dao.saveBeforBB(b);
   }
   
   public void saveAfter(AfterBB b){
	    dao.saveAfter(b);
   }
}
