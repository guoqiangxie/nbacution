package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.dao.IBidRecordInfoDAO;
import com.useeasy.frame.util.BasePage;

public class BidRecordInfoHibernateDAO extends HibernateDaoSupport implements IBidRecordInfoDAO {
	
	public String getBidRecordCountInAuction(String accountId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from AuctionInfoIndexDto " +
				"where deleteFlag=0 and publishFlag=1 and (auctionStatus=1 or auctionStatus=2) " +
				"and id in (select auctionId from BidRecordInfo where currentFlag=0 " +
				"and priceUserId=:accountId group by auctionId)";
		count = Long.parseLong(session.createQuery(hql).setString("accountId", accountId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getBidRecordListInAuction(String accountId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String hql = "from AuctionInfoIndexDto " +
			"where deleteFlag=0 and publishFlag=1 and (auctionStatus=1 or auctionStatus=2) " +
			"and id in (select auctionId from BidRecordInfo where currentFlag=0 " +
			"and priceUserId=:accountId group by auctionId)";
		list = session.createQuery(hql).setString("accountId", accountId)
			.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
			.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> getBidRecordListInItem(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String hql = "from ItemInfo " +
			"where deleteFlag=0 and id in (select itemId from BidRecordInfo " +
			"where currentFlag=0 and auctionId=:auctionId and priceUserId=:accountId) order by itemNumber";
		list = session.createQuery(hql).setString("accountId", accountId)
			.setString("auctionId", auctionId).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getBidRecordListInPrice(String accountId,
			String itemId) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String hql = "from BidRecordInfo " +
			"where currentFlag=0 and itemId=:itemId and priceUserId=:accountId order by priceDate";
		list = session.createQuery(hql).setString("accountId", accountId)
			.setString("itemId", itemId).list();
		session.close();
		return list;
	}
	
	
	
	
	
}
