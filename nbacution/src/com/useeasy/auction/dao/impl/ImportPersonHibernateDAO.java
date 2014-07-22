package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ImportPersonInfo;
import com.useeasy.auction.dao.ImportPersonDAO;

public class ImportPersonHibernateDAO extends HibernateDaoSupport implements
		ImportPersonDAO {

	public void add(ImportPersonInfo person) {
	   getHibernateTemplate().saveOrUpdate(person);
	}

	@SuppressWarnings("unchecked")
	public List<ImportPersonInfo> getPersonResult(String pmhId) {
		String hql="from ImportPersonInfo o where o.pmh_id=:id";
		Session session = getSession();
		Query  query =session.createQuery(hql);
		List  list=  query.setString("id", pmhId).list();
		session.flush();
		session.close();
		return list;
	}

	public void get(){
		String hql="  select  sum(case   when   price_user_type='2'  then  convert(float,o_current_rate) else 0  end )as'网络成交额'" +
				",sum(case   when   price_user_type='1'  then   convert(float,o_current_rate)   end )as'本地成交额' ," +
				"count(case   when   price_user_type='2'  then   convert(float,o_current_rate)   end) as'网络竟买人数'," +
				"count(case   when   price_user_type='1'  then   convert(float,o_current_rate)   end) as'本地竟买人数' " +
				"  from pmh.dbo.auction_item_info ,(select id_num,auction_name from pmh.dbo.auction_pmh_info  " +
				"where id_num in(select distinct  pub_id from pmh.dbo.auction_item_info where pub_id " +
				"in(select id_num from pmh.dbo.auction_pmh_info where auction_company_id=74)  ))  as " +
				" pmh left join (select auction_view.pmh_id, count(auction_view.pmh_id)as 'pmh_count' " +
				"from pmh.dbo.auction_view group by pmh_id) as pmh_view on pmh.id_num=pmh_view.pmh_id where pub_id=pmh.id_num  " +
				"  and o_state = '5'    and create_time>'2011-01-01'  ";
		Session session = getSession();
		Query  query =session.createSQLQuery(hql);
		 System.out.println(query.list().size()); 
		session.flush();
		session.close();
	}
	
}
