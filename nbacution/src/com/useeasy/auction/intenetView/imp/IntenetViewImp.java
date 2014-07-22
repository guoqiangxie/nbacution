package com.useeasy.auction.intenetView.imp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.intenetView.bean.IntenetView;
import com.useeasy.auction.intenetView.dao.IntenetetViewDao;

public class IntenetViewImp extends HibernateDaoSupport implements IntenetetViewDao {

	public void add(com.useeasy.auction.intenetView.bean.IntenetView view) {
	     this.getHibernateTemplate().persist(view);

	}

	@SuppressWarnings("unchecked")
	public  IntenetView findBy(
			String accountView, String auctionFlag) {
		
		Object[] objs = {accountView ,auctionFlag};
		List<IntenetView> list =  this. getHibernateTemplate().findByNamedParam("from IntenetView a " +
				"where a.deleteFlag=0 and a.accountName=:accountName and " +
				"  pmh_id =:pmh_id ",new String[]{"accountName" ,"pmh_id"},objs);
		 
		 if(list.size()>0){
			 return list.get(0);
		 }
		 
		 return null;
	}

	@SuppressWarnings("unchecked")
	public List<com.useeasy.auction.intenetView.bean.IntenetView> getViewList(
			String pmhId) {
		Object[] objs = {pmhId};
		return   this. getHibernateTemplate().findByNamedParam("from IntenetView a " +
				"where a.deleteFlag=0 and a.pmh_id=:pmh_id ",new String[]{"pmh_id"},objs);
	}

	public void update(com.useeasy.auction.intenetView.bean.IntenetView view) {
		 this.getHibernateTemplate().update(view);

	}

}
