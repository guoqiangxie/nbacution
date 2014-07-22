package com.useeasy.auction.vocationdao;

import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.vocationbean.AuctionVocationNews;

 

public class AuctionVocationDao extends HibernateDaoSupport  implements IAuctionVocationNews{

	public boolean addvocationnews(AuctionVocationNews aun) {
		boolean flag=false;
		this.getHibernateTemplate().save(aun);
		flag=true;	
		return flag;
	}

	public boolean deletevocationnews(AuctionVocationNews aun) {
		boolean flag=false;
        this.getHibernateTemplate().delete(aun);

		flag=true;	
		return flag;
	}

	public List queryall(Integer firstResult,Integer maxResult,Integer PageNo) {
       Session session=getSession();
       List list=null;
        Query query=session.createQuery("from  AuctionVocationNews");
        query.setFirstResult((PageNo-1)*firstResult);
        query.setMaxResults(maxResult);
        list=query.list();
       session.close();
		return list;
	}

	public List queryid(long id) {

		  Session session=getSession();
	        List list=(List)session.createQuery("from  AuctionVocationNews where vnewsid=:id").setLong("id", id).list();
	       session.flush();
	       session.close();
			return list;
		
	}

	public List queryshow(AuctionVocationNews aun) {
		  Session session=getSession();
	        List list=(List)session.createQuery("from  AuctionVocationNews  order by  vnewsid desc ").setFirstResult(0).setMaxResults(4).list();
	       session.flush();
	       session.close();
			return list;
	}

	public boolean updatevocationnews(AuctionVocationNews aun) {
		boolean flag=false;
      this.getHibernateTemplate().update(aun);
      flag=true;
		return flag;
	}
	
	public  AuctionVocationNews get(long id) {
		Session session = getSession();
		Query query=session.createQuery("from AuctionVocationNews o where o.id=?   ");
		query.setParameter(0, id);
		AuctionVocationNews  no =( AuctionVocationNews ) query.uniqueResult();
		 session.close();
		return no;
	}
	public List indexqueryall(Integer firstResult,Integer maxResult,Integer PageNo) {
		Session session=getSession();
		List list=null;
        Query query=session.createQuery("from  AuctionVocationNews");
        query.setFirstResult((PageNo-1)*firstResult);
        query.setMaxResults(maxResult);
        list=query.list();
       session.flush();
       session.close();
		return list;

	}
	public List queryvocationcont(){
		Session session =getSession();
		List list=session.createQuery("select count(o) from AuctionVocationNews o").list();
		return list;
	}

}
