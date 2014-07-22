package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionGuest;
import com.useeasy.auction.dao.IGuestInfoDAO;

public class GuestInfoHibernateDAO extends HibernateDaoSupport implements IGuestInfoDAO {

	@SuppressWarnings("unchecked")
	public AuctionGuest getGuestInfo(String id) {
		// TODO Auto-generated method stub
		List<AuctionGuest> list = null;
		Session session = getSession();
		String hql = "from AuctionGuest g " +
			"where g.deleteFlag=0 and g.id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	public void saveGuestInfo(AuctionGuest auctionGuest) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionGuest);
	}

	

	
	
}