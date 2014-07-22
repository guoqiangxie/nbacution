package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.PassRecover;
import com.useeasy.auction.dao.IPassRecoverDAO;
import com.useeasy.auction.service.IPassRecoverService;

public class PassRecoverServiceImp implements IPassRecoverService {

	private IPassRecoverDAO dao;

	public IPassRecoverDAO getDao() {
		return dao;
	}

	public void setDao(IPassRecoverDAO dao) {
		this.dao = dao;
	}

	public String getPassRecoverCountToday(String usAccount, String passType) {
		// TODO Auto-generated method stub
		return dao.getPassRecoverCountToday(usAccount, passType);
	}

	public void savePassRecover(PassRecover passRecover) {
		// TODO Auto-generated method stub
		dao.savePassRecover(passRecover);
	}

	public PassRecover getPassRecoverTodayOrdered(String usAccount,
			String passType) {
		// TODO Auto-generated method stub
		return dao.getPassRecoverTodayOrdered(usAccount, passType);
	}

	

}
