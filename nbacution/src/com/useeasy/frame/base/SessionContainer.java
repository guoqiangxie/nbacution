package com.useeasy.frame.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.AuctionGuest;

public class SessionContainer {
	
	static final Logger logger = LoggerFactory.getLogger(SessionContainer.class);
    
	private AuctionAccount auctionAccount;
	private AuctionAdmin auctionAdmin;
	private AuctionGuest auctionGuest;
	private AuctionCompany auctionCompany;
	
	private static SessionContainer instance = null;
	
	public static SessionContainer getInstance() {
		instance = new SessionContainer();
		return instance;
	}

	public AuctionAccount getAuctionAccount() {
		return auctionAccount;
	}

	public void setAuctionAccount(AuctionAccount auctionAccount) {
		this.auctionAccount = auctionAccount;
	}

	public AuctionAdmin getAuctionAdmin() {
		return auctionAdmin;
	}

	public void setAuctionAdmin(AuctionAdmin auctionAdmin) {
		this.auctionAdmin = auctionAdmin;
	}

	public AuctionGuest getAuctionGuest() {
		return auctionGuest;
	}

	public void setAuctionGuest(AuctionGuest auctionGuest) {
		this.auctionGuest = auctionGuest;
	}

	public AuctionCompany getAuctionCompany() {
		return auctionCompany;
	}

	public void setAuctionCompany(AuctionCompany auctionCompany) {
		this.auctionCompany = auctionCompany;
	}

}
