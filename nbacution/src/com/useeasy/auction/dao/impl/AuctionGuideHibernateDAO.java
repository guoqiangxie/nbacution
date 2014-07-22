package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionGuide;
import com.useeasy.auction.dao.IAuctionGuideDAO;

public class AuctionGuideHibernateDAO extends HibernateDaoSupport implements IAuctionGuideDAO {

	@SuppressWarnings("unchecked")
	public List<AuctionGuide> getAuctionGuideList(String searchType) {
		// TODO Auto-generated method stub
		List<AuctionGuide> list = null;
		Session session = getSession();
		String hql = "";
		if(("0").equals(searchType)){
			hql = "from AuctionGuide a " +
				"where a.deleteFlag=0 ";
			list = session.createQuery(hql).list();
		}else {
			hql = "from AuctionGuide a " +
				"where a.deleteFlag=0 and a.guideType=:searchType ";
			list = session.createQuery(hql)
				.setString("searchType", searchType).list();
		}
		session.close();
		return list;
	}

	public void saveAuctionGuide(AuctionGuide auctionGuide) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionGuide);
	}

	public AuctionGuide getAuctionGuide(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(AuctionGuide.class, Long.parseLong(id));
	}

	
}