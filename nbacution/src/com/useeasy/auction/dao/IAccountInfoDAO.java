package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.AuctionAccount;

public interface IAccountInfoDAO {
	
	public List<AuctionAccount> getAccountByNameAndPass(String usAccount, 
				String usAccountPass);
	
	public boolean isNotExistAccountName(String accountName);
	
	public void saveAuctionAccount(AuctionAccount auctionAccount);
	
	public AuctionAccount getAccountInfo(String id);
	
	public AuctionAccount getAccountInfoByAccountName(String accountName);
	
	public boolean isExistAccountIdentityCard(String accountIdentityCard);
	public List<AuctionAccount> getAccountInfoByAccountNameList(String accountName,String type);
	public List<AuctionAccount> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy);
	public List getcount(String wherejpql, Object[] queryParams);
	public List <Object []>  findBysfz(String sfzhm);
	public AuctionAccount getAccountInfoByID(String id) ;
}

