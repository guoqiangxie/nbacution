package com.useeasy.auction.service.impl;


import java.util.List;

import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.dao.IApplicationDAO;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.frame.util.BasePage;

public class ApplicationServiceImp implements IApplicationService{

	private IApplicationDAO dao;
	
	public IApplicationDAO getDao() {
		return dao;
	}

	public void setDao(IApplicationDAO dao) {
		this.dao = dao;
	}

	public ApplicationInfo getApplicationByAccountAndAuctionId(
			String accountId, String auctionId) {
		// TODO Auto-generated method stub
		return dao.getApplicationByAccountAndAuctionId(accountId, auctionId);
	}

	public void saveApplication(ApplicationInfo applicationInfo) {
		// TODO Auto-generated method stub
		dao.saveApplication(applicationInfo);
	}

	public String getApplicationCount(String accountId, String searchType) {
		// TODO Auto-generated method stub
		return dao.getApplicationCount(accountId, searchType);
	}

	public List<ApplicationInfo> getApplicationList(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getApplicationList(accountId, searchType, basePage);
	}

	public ApplicationInfo getApply(String id) {
		// TODO Auto-generated method stub
		return dao.getApply(id);
	}

	public List<ApplicationInfo> getApplicationListByCompanyAndAuctionId(
			String companyId, String auctionId) {
		// TODO Auto-generated method stub
		return dao.getApplicationListByCompanyAndAuctionId(companyId, auctionId);
	}

	public String getApplicationCountInProxy(String accountId, String searchType) {
		// TODO Auto-generated method stub
		return dao.getApplicationCountInProxy(accountId, searchType);
	}

	public List<ApplicationInfo> getApplicationListInProxy(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getApplicationListInProxy(accountId, searchType, basePage);
	}

	public String getApplicationCountInFinance(String accountId, String searchType) {
		// TODO Auto-generated method stub
		return dao.getApplicationCountInFinance(accountId, searchType);
	}

	public List<ApplicationInfo> getApplicationListInFinance(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		return dao.getApplicationListInFinance(accountId, searchType, basePage);
	}

	public List<ApplicationInfo> getApplicationListInCompanyFinance(
			String auctionId) {
		// TODO Auto-generated method stub
		return dao.getApplicationListInCompanyFinance(auctionId);
	}

}

