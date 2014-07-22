package com.useeasy.auction.service;

import com.useeasy.auction.bean.PassRecover;

public interface IPassRecoverService{

	public String getPassRecoverCountToday(String usAccount, String passType);
	
	public void savePassRecover(PassRecover passRecover);
	
	public PassRecover getPassRecoverTodayOrdered(String usAccount, String passType);
}

