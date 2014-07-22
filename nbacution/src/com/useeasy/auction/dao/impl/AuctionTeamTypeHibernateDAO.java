package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionTeamType;
import com.useeasy.auction.dao.IAuctionTeamTypeDAO;

public class AuctionTeamTypeHibernateDAO extends HibernateDaoSupport implements IAuctionTeamTypeDAO {

	@SuppressWarnings("unchecked")
	public List<AuctionTeamType> getAuctionTeamType(String auctionId) {
		// TODO Auto-generated method stub
		List<AuctionTeamType> list = null;
		Session session = getSession();
		String hql = "from AuctionTeamType a " +
			"where a.auctionId=:auctionId";
		list = session.createQuery(hql).setString("auctionId", auctionId).list();	
		session.close();
		return list;
	}

	public void saveTeamType(AuctionTeamType auctionTeamType) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionTeamType);
	}

	public AuctionTeamType getTeamType(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(AuctionTeamType.class, Long.parseLong(id));
	}

	public void removeTeamType(AuctionTeamType auctionTeamType) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(auctionTeamType);
	}

	
}