package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.dao.IAccountInfoDAO;
import com.useeasy.auction.service.IAccountInfoService;

public class AccountInfoServiceImp implements IAccountInfoService {

	private IAccountInfoDAO dao;

	public IAccountInfoDAO getDao() {
		return dao;
	}

	public void setDao(IAccountInfoDAO dao) {
		this.dao = dao;
	}

	public List<AuctionAccount> getAccountByNameAndPass(String usAccount,
			String usAccountPass) {
		// TODO Auto-generated method stub
		return dao.getAccountByNameAndPass(usAccount, usAccountPass);
	}

	public boolean isNotExistAccountName(String accountName) {
		// TODO Auto-generated method stub
		return dao.isNotExistAccountName(accountName);
	}

	public void saveAuctionAccount(AuctionAccount auctionAccount) {
		// TODO Auto-generated method stub
		dao.saveAuctionAccount(auctionAccount);
	}

	public AuctionAccount getAccountInfo(String id) {
		// TODO Auto-generated method stub
		return dao.getAccountInfo(id);
	}

	public AuctionAccount getAccountInfoByAccountName(String accountName) {
		// TODO Auto-generated method stub
		return dao.getAccountInfoByAccountName(accountName);
	}

	public boolean isExistAccountIdentityCard(String accountIdentityCard) {
		// TODO Auto-generated method stub
		return dao.isExistAccountIdentityCard(accountIdentityCard);
	}

	public List<AuctionAccount> getAccountInfoByAccountNameList(String accountName,String type){
		return dao.getAccountInfoByAccountNameList( accountName, type);
	}

	public AuctionAccount getAccountInfoByID(String id) {
		  
		return dao.getAccountInfoByID(id);
	}
	public List<AuctionAccount> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy){
		return dao.getList(page, firstPage, maxPage, wherejpql, queryParams, orderBy);
	}
	public List getcount(String wherejpql, Object[] queryParams){
		return dao.getcount(wherejpql, queryParams);
	}
	public List <Object []>  findBysfz(String sfzhm){
		return dao.findBysfz(sfzhm);
	}

}
