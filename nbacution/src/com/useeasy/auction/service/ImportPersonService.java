package com.useeasy.auction.service;

import java.util.List;

import com.useeasy.auction.bean.ImportPersonInfo;

public interface ImportPersonService {
	   public void sava(ImportPersonInfo person);
	   public List<ImportPersonInfo> getPersonResult(String pmh_id);
	   public void get();
}
