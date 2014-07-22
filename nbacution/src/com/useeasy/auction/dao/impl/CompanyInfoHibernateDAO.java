package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.dao.ICompanyInfoDAO;
import com.useeasy.auction.dto.CompanyInfoDto;
import com.useeasy.auction.bean.AuctionCompany;

public class CompanyInfoHibernateDAO extends HibernateDaoSupport implements ICompanyInfoDAO {

	/*@SuppressWarnings("unchecked")
	public List<CompanyInfoIndexDto> getIndexList() {
		// TODO Auto-generated method stub
		List<CompanyInfoIndexDto> list = null;
		Session session = getSession();
		String baseSql = "from CompanyInfoIndexDto c " +
			"where c.deleteFlag=0  ";
		String baseOrder = " order by c.companyOrder desc";
		String hql = "";
		hql = baseSql + baseOrder;
		list = session.createQuery(hql).list();	
		session.close();
		return list;
	}*/

	@SuppressWarnings("unchecked")
	public AuctionCompany getCompanyInfo(String id) {
		// TODO Auto-generated method stub
		List<AuctionCompany> list = null;
		Session session = getSession();
		String hql = "from AuctionCompany c " +
			"where c.deleteFlag=0 and c.id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
		
	}

	public void saveCompanyInfo(AuctionCompany AuctionCompany) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(AuctionCompany);
	}

	@SuppressWarnings("unchecked")
	public List<CompanyInfoDto> getCompanyInfoDtoList() {
		// TODO Auto-generated method stub
		List<CompanyInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from CompanyInfoDto " +
			"where deleteFlag=0 ";
		String baseOrder = " order by companyOrder desc ";
		String hql = "";
		hql = baseSql + baseOrder;
		list = session.createQuery(hql).list();	
		session.close();
		return list;
	}
	
	public void upd_entity(Object object) {
		// TODO Auto-generated method stub
		getHibernateTemplate().update(object);
	}
	
}