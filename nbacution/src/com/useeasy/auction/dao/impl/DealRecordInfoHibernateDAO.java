package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.dao.IDealRecordInfoDAO;
import com.useeasy.frame.util.BasePage;

public class DealRecordInfoHibernateDAO extends HibernateDaoSupport implements
		IDealRecordInfoDAO {

	public String getDealRecordCountInAuction(String accountId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from AuctionInfoIndexDto " +
				"where deleteFlag=0 and publishFlag=1 and auctionStatus=2 " +
				"and id in (select auctionId from ItemInfo where deleteFlag=0 " +
				"and itemStatus=5 and priceUserId=:accountId group by auctionId)";
		count = Long.parseLong(session.createQuery(hql).setString("accountId", accountId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getDealRecordListInAuction(String accountId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String hql = "from AuctionInfoIndexDto " +
			"where deleteFlag=0 and publishFlag=1 and auctionStatus=2 " +
			"and id in (select auctionId from ItemInfo where deleteFlag=0 " +
			"and itemStatus=5 and priceUserId=:accountId group by auctionId)";
		list = session.createQuery(hql).setString("accountId", accountId)
			.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
			.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getDealRecordListInItem(String accountId,
			String auctionId) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String hql = "from ItemInfo " +
			"where deleteFlag=0 and itemStatus=5 and auctionId=:auctionId " +
			"and priceUserId=:accountId order by itemNumber";
		list = session.createQuery(hql).setString("accountId", accountId)
			.setString("auctionId", auctionId).list();
		session.close();
		return list;
	}
	
	
	
	
	
	
	/*public String getPayRecordCount(String accountId) {
		long count = 0;
		Session session = getSession();
		String sql = "select count(id) from PayRecordInfo t where t.accountId = :accountId";
		count = Long.parseLong(session.createQuery(sql).setString("accountId", accountId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<PayRecordInfo> getPayRecordList(String accountId,BasePage basePage) {
		List<PayRecordInfo> list = null;
		Session session = getSession();
		String sql = "from PayRecordInfo t where t.accountId=:accountId";
		list = session.createQuery(sql).setString("accountId", accountId)
		.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
		.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public PayRecordInfo getPayRecord(String auctionId,String accountId){
		Session session = getSession();
		String sql = "from PayRecordInfo t where t.auctionId=:auctionId and t.accountId=:accountId";
		List<PayRecordInfo> list = session.createQuery(sql).setString("auctionId", auctionId).setString("accountId", accountId).list();
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}*/
	
}
