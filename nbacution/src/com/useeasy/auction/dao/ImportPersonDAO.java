package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.ImportPersonInfo;

public interface ImportPersonDAO {
   public void add(ImportPersonInfo person);
   public List<ImportPersonInfo> getPersonResult(String pmh_id);
   public void get();
}
