package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.dao.ICompanyInfoDAO;
import com.useeasy.auction.dto.CompanyInfoDto;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.service.ICompanyInfoService;

public class CompanyInfoServiceImp implements ICompanyInfoService {

	private ICompanyInfoDAO dao;

	public ICompanyInfoDAO getDao() {
		return dao;
	}

	public void setDao(ICompanyInfoDAO dao) {
		this.dao = dao;
	}

	/*public List<CompanyInfoIndexDto> getIndexList() {
		// TODO Auto-generated method stub
		return dao.getIndexList();
	}*/

	public AuctionCompany getCompanyInfo(String id) {
		// TODO Auto-generated method stub
		return dao.getCompanyInfo(id);
	}

	public void saveCompanyInfo(AuctionCompany AuctionCompany) {
		// TODO Auto-generated method stub
		dao.saveCompanyInfo(AuctionCompany);
	}

	
	
	
	
	public void update_company(AuctionCompany auctionCompany) {
		// TODO Auto-generated method stub
		dao.upd_entity(auctionCompany);
	}
	
	
	public List<CompanyInfoDto> getCompanyInfoDtoList() {
		// TODO Auto-generated method stub
		return dao.getCompanyInfoDtoList();
	}

}
