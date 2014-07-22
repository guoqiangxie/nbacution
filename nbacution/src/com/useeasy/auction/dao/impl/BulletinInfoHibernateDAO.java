package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionBulletin;
import com.useeasy.auction.dao.IBulletinInfoDAO;
import com.useeasy.frame.util.BasePage;

public class BulletinInfoHibernateDAO extends HibernateDaoSupport implements IBulletinInfoDAO {

	public String getBulletinCount(String companyId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from AuctionBulletin a " +
			"where a.deleteFlag=0 and a.companyId=:companyId ";
		count = Long.parseLong(session.createQuery(hql).setString("companyId", companyId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<AuctionBulletin> getBulletinList(String companyId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		List<AuctionBulletin> list = null;
		Session session = getSession();
		String baseSql = "from AuctionBulletin a " +
			"where a.deleteFlag=0 and a.companyId=:companyId ";
		String baseOrder = " order by cast(a.sortFlag as long) desc";
		String hql = "";
		hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("companyId", companyId)
			.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
			.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	public void saveAuctionBulletin(AuctionBulletin auctionBulletin) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionBulletin);
	}

	public AuctionBulletin getAuctionBulletin(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(AuctionBulletin.class, Long.parseLong(id));
	}

	@SuppressWarnings("unchecked")
	public List<AuctionBulletin> getBulletinTopList(String companyId) {
		// TODO Auto-generated method stub
		List<AuctionBulletin> list = null;
		Session session = getSession();
		String baseSql = "from AuctionBulletin a " +
			"where a.deleteFlag=0 and a.companyId=:companyId ";
		String baseOrder = " order by cast(a.sortFlag as long) desc";
		String hql = "";
		hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("companyId", companyId)
			.setFirstResult(0)
			.setMaxResults(5).list();
		session.close();
		return list;
	}
	
	
}