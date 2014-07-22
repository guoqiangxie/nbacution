package com.useeasy.auction.service.impl;

import com.useeasy.auction.bean.QulificationInfo;
import com.useeasy.auction.dao.IQulificationDAO;
import com.useeasy.auction.service.IQulificationService;

public class QulificationServiceImp implements IQulificationService{

	private IQulificationDAO dao;
	
	public IQulificationDAO getDao() {
		return dao;
	}

	public void setDao(IQulificationDAO dao) {
		this.dao = dao;
	}

	public boolean checkQulification(String accountId) {
		// TODO Auto-generated method stub
		return dao.checkQulification(accountId);
	}

	public void saveQulification(QulificationInfo qulificationInfo) {
		// TODO Auto-generated method stub
		dao.saveQulification(qulificationInfo);
	}

	

	

}

