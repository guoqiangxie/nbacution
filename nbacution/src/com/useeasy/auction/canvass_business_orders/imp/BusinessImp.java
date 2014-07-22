package com.useeasy.auction.canvass_business_orders.imp;

import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.canvass_business_orders.bean.BusinessBean;
import com.useeasy.auction.canvass_business_orders.dao.BusinessDao;



public class BusinessImp extends HibernateDaoSupport implements
		BusinessDao {

	public  BusinessBean get(Integer id) {
		Session session = getSession();
		Query query=session.createQuery("from BusinessBean o where o.id=?   ");
		query.setParameter(0, id);
		BusinessBean  no =( BusinessBean ) query.uniqueResult();
		 session.flush();
		 session.close();
		return no;
	}
 	public void del(BusinessBean notice) {
		getHibernateTemplate().delete(notice);
		
	} 
	public void save(BusinessBean notice) {
		getHibernateTemplate().persist(notice);
		
	}
	@SuppressWarnings("unchecked")
	public List<BusinessBean> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from BusinessBean o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	    	
	    }
	    
		 List<BusinessBean> list = query.list();
		
		session.flush();
		session.close();
		
		return list;
	}
	public void update(BusinessBean notice) {
		 
		getHibernateTemplate().update(notice);
	}/**
	 * 组装where语句
	 * @param orderby
	 * @return
	 */
	protected  static void setQueryParams(Query query, Object[] queryParams){
		if(queryParams!=null && queryParams.length>0){
			 
			for(int i=0; i<queryParams.length; i++){
				 
				query.setParameter(i, queryParams[i]);
			}
		}
	}
	public Long getCount(String wherejpql, Object[] queryParams) {
		  Session session = this.getSession();
			 Query query=session.createSQLQuery("select count(o.id_num) from  BusinessBean o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql) );
	         setQueryParams(query, queryParams);
		     List list = query.list();
			 session.flush();
			session.close();
			if(list.size()>0){
			  return Long.valueOf(list.get(0).toString());
			}
			
		return Long.valueOf(0);
	}

}
