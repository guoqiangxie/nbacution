package com.useeasy.auction.notice.imp;

import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.notice.bean.AuctionNotice;
import com.useeasy.auction.notice.dao.AuctionNoticeDao;
 

 

public class AuctionNoticeImp extends HibernateDaoSupport implements AuctionNoticeDao {

  	public  AuctionNotice get(long id) {
		Session session = getSession();
		Query query=session.createQuery("from AuctionNotice o where id=?   ");
		query.setParameter(0, id);
		 AuctionNotice  no =( AuctionNotice ) query.uniqueResult();
		 session.close();
		return no;
	}
 	public void del(AuctionNotice notice) {
		getHibernateTemplate().delete(notice);
		
	} 
	public void save(AuctionNotice notice) {
		getHibernateTemplate().persist(notice);
		
	}
	@SuppressWarnings("unchecked")
	public List<AuctionNotice> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from AuctionNotice o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	    	
	    }
	    
		 List<AuctionNotice> list = query.list();
		
		session.flush();
		session.close();
		
		return list;
	}
	public void update(AuctionNotice notice) {
		 
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
			 Query query=session.createSQLQuery("select count(o.id) from  AuctionNotice o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql) );
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
