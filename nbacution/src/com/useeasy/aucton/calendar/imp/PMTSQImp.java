package com.useeasy.aucton.calendar.imp;

import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.aucton.calendar.bean.PMTSQ;
import com.useeasy.aucton.calendar.bean.PMTing;
import com.useeasy.aucton.calendar.dao.PMSQdao;

public class PMTSQImp extends HibernateDaoSupport implements PMSQdao {

	public  PMTSQ get(Integer id) {
		Session session = getSession();
		Query query=session.createQuery("from PMTSQ o where id=?   ");
		query.setParameter(0, id);
		PMTSQ  no =( PMTSQ ) query.uniqueResult();
		 session.close();
		return no;
	}
 	public void delete(PMTSQ notice) {
		getHibernateTemplate().delete(notice);
		
	} 
	public void save(PMTSQ notice) {
		getHibernateTemplate().persist(notice);
		
	}
	@SuppressWarnings("unchecked")
	public List<PMTSQ> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from PMTSQ o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	    	
	    }
	    
		 List<PMTSQ> list = query.list();
		
		session.flush();
		session.close();
		
		return list;
	}
	public void update(PMTSQ notice) {
		 
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
			 Query query=session.createSQLQuery("select count(o.id) from  PMTSQ o "+(wherejpql==null || "".equals(wherejpql.trim())? "": " where "+ wherejpql) );
	         setQueryParams(query, queryParams);
		     List list = query.list();
			 session.flush();
			session.close();
			if(list.size()>0){
			  return Long.valueOf(list.get(0).toString());
			}
			
		return Long.valueOf(0);
	}
 
	public Long getCount(String day) {
		  Session session = this.getSession();
			 Query query=session.createSQLQuery("select count(o.id) from  PMTSQ o  where o.useDay =:day" );
	         query.setString("day", day);
		     List list = query.list();
			 session.flush();
			session.close();
			if(list.size()>0){
			  return Long.valueOf(list.get(0).toString());
			}
			
		return Long.valueOf(0);
	}
 /*
  * 获取拍卖会列表
  */
public List<AuctionInfo> guajiePmhList(int page, int firstPage, int maxPage,
		String wherejpql, Object[] queryParams, String orderBy){
	    List<AuctionInfo> list;
	    Session session=null;
	try {
		session = this.getSession();
		Query query=session.createQuery(" from AuctionInfo o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+" "+orderBy);
		setQueryParams(query, queryParams);
		if(firstPage!=-1 && maxPage!=-1){
		   query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
		    	
		  }
		    
	     list = query.list();
	     return list;	
			
	} catch (Exception e) {
		e.printStackTrace(); 
	}finally{
		if(session!=null){
			session.flush();
			session.close();
		}
		
	}
		return null;
}
	
	
}
