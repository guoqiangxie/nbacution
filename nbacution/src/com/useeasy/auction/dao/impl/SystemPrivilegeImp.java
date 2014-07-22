package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

 
import com.useeasy.auction.bean.SystemPrivilege;
import com.useeasy.auction.dao.SystemPrivilegeDao;

public class SystemPrivilegeImp extends HibernateDaoSupport implements SystemPrivilegeDao{
	public void delete(SystemPrivilege privilege) {
		getHibernateTemplate().delete(privilege);
		
	} 
	public void save(SystemPrivilege privilege) {
		getHibernateTemplate().save(privilege);
		
	}
	public void batchSave(List<SystemPrivilege> privileges){
		for(SystemPrivilege p : privileges){
			save(p);
		}
	}
	
	public void update(SystemPrivilege privilege) {
		 
		getHibernateTemplate().update(privilege);
	}
	
	public List<SystemPrivilege> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from  SystemPrivilege  o  "+(wherejpql==null || "".equals(wherejpql.trim())? " ": " where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	     }
	    List<SystemPrivilege> list = query.list();
	 	session.flush();
		session.close();
	 		return list;
	}
	public List getcount(String wherejpql, Object[] queryParams) {
		  Session session = this.getSession();
		 Query query=session.createQuery("select count(o.id) from  SystemPrivilege  o  "+(wherejpql==null || "".equals(wherejpql.trim())? " ": " where "+ wherejpql)+" ");
         setQueryParams(query, queryParams);
	     List list = query.list();
	 	session.flush();
		session.close();
	 		return list;
	}
	
	 /**
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
}
