package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.dao.IAdminInfoDAO;

public class AdminInfoHibernateDAO extends HibernateDaoSupport implements IAdminInfoDAO {

	@SuppressWarnings("unchecked")
	public AuctionAdmin getAdminInfo(String id) {
		// TODO Auto-generated method stub
		List<AuctionAdmin> list = null;
		Session session = getSession();
		String hql = "from AuctionAdmin a " +
			"where a.deleteFlag=0 and a.id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	

	public void save (AuctionAdmin  admin){
		this.getHibernateTemplate().saveOrUpdate(admin);
	}
	
	
}