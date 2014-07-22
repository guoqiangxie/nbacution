package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.ImportPersonInfo;
import com.useeasy.auction.dao.ImportPersonDAO;
import com.useeasy.auction.service.ImportPersonService;

public class ImportPersonServiceImp implements ImportPersonService {
    private ImportPersonDAO dao;
	public List<ImportPersonInfo> getPersonResult(String pmhId) {
		 
		return dao.getPersonResult(pmhId);
	}

	public void sava(ImportPersonInfo person) {
		 
          dao.add(person);
	}

	public ImportPersonDAO getDao() {
		return dao;
	}

	public void setDao(ImportPersonDAO dao) {
		this.dao = dao;
	}

	
	public void get(){
		dao.get();
	}
	
}
