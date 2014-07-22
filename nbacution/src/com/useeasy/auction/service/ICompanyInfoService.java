package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.dto.CompanyInfoDto;

public interface ICompanyInfoService{

	//public List<CompanyInfoIndexDto> getIndexList();
	
	public AuctionCompany getCompanyInfo(String id);
	
	public void saveCompanyInfo(AuctionCompany AuctionCompany);
	
	public void update_company(AuctionCompany auctionCompany);
	
	
	
	public List<CompanyInfoDto> getCompanyInfoDtoList();
	
}

