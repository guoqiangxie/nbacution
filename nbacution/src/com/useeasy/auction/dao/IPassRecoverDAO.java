package com.useeasy.auction.dao;

import com.useeasy.auction.bean.PassRecover;

public interface IPassRecoverDAO {
	
	public String getPassRecoverCountToday(String usAccount, String passType);
	
	public void savePassRecover(PassRecover passRecover);
	
	public PassRecover getPassRecoverTodayOrdered(String usAccount, String passType);
	
}

