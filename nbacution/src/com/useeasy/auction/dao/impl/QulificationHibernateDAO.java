package com.useeasy.auction.dao.impl;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.QulificationInfo;
import com.useeasy.auction.dao.IQulificationDAO;
																				
public class QulificationHibernateDAO extends HibernateDaoSupport implements IQulificationDAO{

	public boolean checkQulification(String accountId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from QulificationInfo q where " +
				"q.accountId=:accountId ";
		count = Long.parseLong(session.createQuery(hql).setString("accountId", accountId)
				.uniqueResult().toString());
		session.close();
		if(count != 0)
			return true;
		else
			return false;
		
	}

	public void saveQulification(QulificationInfo qulificationInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(qulificationInfo);
	}

	

	
	
}

