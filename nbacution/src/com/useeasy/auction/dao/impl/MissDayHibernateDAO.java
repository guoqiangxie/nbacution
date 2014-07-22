package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.MissDayBean;
import com.useeasy.auction.dao.IAccountInfoDAO;
import com.useeasy.auction.dao.MissDayDao;

public class MissDayHibernateDAO extends HibernateDaoSupport implements
		MissDayDao {

	@SuppressWarnings("unchecked")
	public MissDayBean get() {
		Session s = getSession();

		Query q = s.createQuery("from MissDayBean a where a.flag=:flag");
		q.setString("flag", "0");
		List<MissDayBean> list = q.list();
		s.flush();
		s.close();
           if(list.size()>0){
		return list.get(0);
           }
           return null;
	}

	public void add(MissDayBean missDayBean) {

		getHibernateTemplate().saveOrUpdate(missDayBean);
	}

}