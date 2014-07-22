package com.useeasy.aucton.calendar.imp;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.aucton.calendar.bean.PMTing;
import com.useeasy.aucton.calendar.bean.UserTime;
import com.useeasy.aucton.calendar.dao.UserTimedao;

public class UserTingImp extends HibernateDaoSupport implements UserTimedao {

	public  UserTime get(Integer id) {
		Session session = getSession();
		Query query=session.createQuery("from UserTime o where id=?   ");
		query.setParameter(0, id);
		UserTime  no =( UserTime ) query.uniqueResult();
		 session.close();
		return no;
	}
 	public void delete(UserTime notice) {
		getHibernateTemplate().delete(notice);
		
	} 
	public void save(UserTime notice) {
		getHibernateTemplate().persist(notice);
		
	}
	@SuppressWarnings("unchecked")
	public List<UserTime> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from UserTime o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	    	
	    }
	    
		 List<UserTime> list = query.list();
		
		session.flush();
		//session.close();
		
		return list;
	}
	public void update(UserTime notice) {
		 
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
			 Query query=session.createSQLQuery("select count(o.id) from  UserTime o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql) );
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
