package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.frame.util.BasePage;

public interface IApplicationDAO{
	
	public ApplicationInfo getApplicationByAccountAndAuctionId(String accountId, String auctionId);
	
	public void saveApplication(ApplicationInfo applicationInfo);
	
	public String getApplicationCount(String accountId, String searchType);
	public List<ApplicationInfo> getApplicationList(String accountId, String searchType, BasePage basePage);
	
	public ApplicationInfo getApply(String id);
	
	public List<ApplicationInfo> getApplicationListByCompanyAndAuctionId(String companyId, String auctionId);

	public String getApplicationCountInProxy(String accountId, String search_type);
	public List<ApplicationInfo> getApplicationListInProxy(String accountId, String search_type, BasePage basePage);
	
	public String getApplicationCountInFinance(String accountId, String search_type);
	public List<ApplicationInfo> getApplicationListInFinance(String accountId, String search_type, BasePage basePage);
	
	public List<ApplicationInfo> getApplicationListInCompanyFinance(String auctionId);
}

