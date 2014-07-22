package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.PassRecover;
import com.useeasy.auction.dao.IPassRecoverDAO;
import com.useeasy.frame.util.Tools;

public class PassRecoverHibernateDAO extends HibernateDaoSupport implements IPassRecoverDAO {

	public String getPassRecoverCountToday(String usAccount, String passType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from PassRecover p " +
				"where p.accountName=:usAccount and p.accountPassType=:passType ";
		String hql = baseSql + " and  (p.createTime>=:todayStart and p.createTime<=:todayEnd) ";
		count = Long.parseLong(session.createQuery(hql)
				.setString("usAccount", usAccount).setString("passType", passType)
				.setTimestamp("todayStart", Tools.getStartTimeByToday())
				.setTimestamp("todayEnd", Tools.getEndTimeByToday())
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	public void savePassRecover(PassRecover passRecover) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(passRecover);
	}

	@SuppressWarnings("unchecked")
	public PassRecover getPassRecoverTodayOrdered(String usAccount,
			String passType) {
		// TODO Auto-generated method stub
		List<PassRecover> list = null;
		Session session = getSession();
		String baseSql = "from PassRecover p " +
			"where p.accountName=:usAccount and p.accountPassType=:passType ";
		String hql = baseSql + " and  (p.createTime>=:todayStart and p.createTime<=:todayEnd) " +
				"order by p.createTime desc";
		list = session.createQuery(hql)
			.setString("usAccount", usAccount).setString("passType", passType)
			.setTimestamp("todayStart", Tools.getStartTimeByToday())
			.setTimestamp("todayEnd", Tools.getEndTimeByToday())
			.list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	
	
}