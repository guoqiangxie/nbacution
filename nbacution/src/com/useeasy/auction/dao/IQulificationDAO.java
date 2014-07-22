package com.useeasy.auction.dao;

import com.useeasy.auction.bean.QulificationInfo;

public interface IQulificationDAO{
	
	public boolean checkQulification(String accountId);
	
	public void saveQulification(QulificationInfo qulificationInfo);
	
}

