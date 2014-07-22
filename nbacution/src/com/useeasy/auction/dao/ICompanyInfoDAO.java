package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.dto.CompanyInfoDto;

public interface ICompanyInfoDAO {
	
	//public List<CompanyInfoIndexDto> getIndexList();
	
	public AuctionCompany getCompanyInfo(String id);
	
	public void saveCompanyInfo(AuctionCompany AuctionCompany);
	
	
	public void upd_entity(Object object);
		 
	
	
	public List<CompanyInfoDto> getCompanyInfoDtoList();
}

