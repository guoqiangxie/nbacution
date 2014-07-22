package com.useeasy.auction.service;

import com.useeasy.auction.bean.QulificationInfo;

public interface IQulificationService{

	public boolean checkQulification(String accountId);
	
	public void saveQulification(QulificationInfo qulificationInfo);
}

