package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.dao.IApplicationDAO;
import com.useeasy.frame.util.BasePage;

public class ApplicationHibernateDAO extends HibernateDaoSupport implements IApplicationDAO{

	@SuppressWarnings("unchecked")
	public ApplicationInfo getApplicationByAccountAndAuctionId(
			String accountId, String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {accountId,auctionId};
		List<ApplicationInfo> list = getHibernateTemplate().findByNamedParam("from ApplicationInfo a  " +
				"where a.deleteFlag=0 and a.accountId=:accountId and " +
				"a.auctionId=:auctionId",new String[]{"accountId","auctionId"},objs);
		if(list != null && list.size() != 0 ){
			return list.get(0);
		}else
			return null;
	}

	public void saveApplication(ApplicationInfo applicationInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(applicationInfo);
	}

	public String getApplicationCount(String accountId, String searchType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 ";
		String sql = "";
		if("1".equals(searchType)){  
			sql = baseSql;
		}else if("2".equals(searchType)){  
			sql = baseSql + " and (a.applyStatus=0 or a.applyStatus=1) ";
		}else if("3".equals(searchType)){  
			sql = baseSql + " and a.applyStatus=2 ";
		}else{
			sql = baseSql;
		}
		count = Long.parseLong(session.createQuery(sql).setString("accountId", accountId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationInfo> getApplicationList(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		List<ApplicationInfo> list = null;
		Session session = getSession();
		String baseSql = "from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 ";
		String baseOrder = " order by a.id ";
		String sql = "";
		if("1".equals(searchType)){  
			sql = baseSql + baseOrder;
		}else if("2".equals(searchType)){  
			sql = baseSql + " and (a.applyStatus=0 or a.applyStatus=1) " + baseOrder;
		}else if("3".equals(searchType)){  
			sql = baseSql + " and a.applyStatus=2 " + baseOrder;
		}else{
			sql = baseSql + baseOrder;
		}
		list = session.createQuery(sql).setString("accountId", accountId)
		.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
		.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	public ApplicationInfo getApply(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(ApplicationInfo.class, Long.parseLong(id));
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationInfo> getApplicationListByCompanyAndAuctionId(
			String companyId, String auctionId) {
		// TODO Auto-generated method stub
		List<ApplicationInfo> list = null;
		Session session = getSession();
		String hql = "from ApplicationInfo a where a.deleteFlag=0 and a.auctionId=:auctionId " +
				"and a.companyId=:companyId ";
		String baseOrder = " order by a.id desc ";
		hql = hql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId)
		.setString("companyId", companyId).list();
		session.close();
		return list;
	}

	public String getApplicationCountInProxy(String accountId, String searchType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 and a.applyStatus=2 ";
		String hql = "";
		if("1".equals(searchType)){  
			hql = baseSql;
		}else if("2".equals(searchType)){  
			hql = baseSql + " and a.auctionStatus=0 ";
		}else if("3".equals(searchType)){  
			hql = baseSql + " and (a.auctionStatus=1 or " +
					"a.auctionStatus=2) ";
		}else{
			hql = baseSql;
		}
		count = Long.parseLong(session.createQuery(hql).setString("accountId", accountId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationInfo> getApplicationListInProxy(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		List<ApplicationInfo> list = null;
		Session session = getSession();
		String baseSql = "from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 and a.applyStatus=2 ";
		String baseOrder = " order by a.id desc ";
		String sql = "";
		if("1".equals(searchType)){  
			sql = baseSql + baseOrder;
		}else if("2".equals(searchType)){  
			sql = baseSql + " and a.auctionStatus=0 "
			+ baseOrder;
		}else if("3".equals(searchType)){  
			sql = baseSql + " and (a.auctionStatus=1 or a.auctionStatus=2) " + baseOrder;
		}else{
			sql = baseSql + baseOrder;
		}
		list = session.createQuery(sql).setString("accountId", accountId)
		.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
		.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}
	
	public String getApplicationCountInFinance(String accountId, String searchType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 and (a.applyStatus=1 or a.applyStatus=2) ";
		count = Long.parseLong(session.createQuery(hql).setString("accountId", accountId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationInfo> getApplicationListInFinance(String accountId,
			String searchType, BasePage basePage) {
		// TODO Auto-generated method stub
		List<ApplicationInfo> list = null;
		Session session = getSession();
		String baseSql = "from ApplicationInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionDeleteFlag=0 and a.auctionPublishFlag=1 and (a.applyStatus=1 or a.applyStatus=2)  ";
		String baseOrder = " order by a.id desc ";
		String sql = baseSql + baseOrder;
		list = session.createQuery(sql).setString("accountId", accountId)
		.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
		.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationInfo> getApplicationListInCompanyFinance(
			String auctionId) {
		// TODO Auto-generated method stub
		List<ApplicationInfo> list = null;
		Session session = getSession();
		String hql = "from ApplicationInfo a where a.deleteFlag=0 and a.auctionId=:auctionId " +
				"and (a.applyStatus=1 or a.applyStatus=2)";
		String baseOrder = " order by a.id desc ";
		hql = hql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId).list();
		session.close();
		return list;
	}
}

