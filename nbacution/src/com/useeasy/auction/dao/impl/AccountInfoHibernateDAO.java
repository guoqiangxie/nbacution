package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.dao.IAccountInfoDAO;

public class AccountInfoHibernateDAO extends HibernateDaoSupport implements IAccountInfoDAO {

	@SuppressWarnings("unchecked")
	public List<AuctionAccount> getAccountByNameAndPass(String usAccount,
			String usAccountPass) {
		// TODO Auto-generated method stub
		Object[] objs = {usAccount,usAccountPass};
		return getHibernateTemplate().findByNamedParam("from AuctionAccount a " +
				"where a.deleteFlag=0 and a.accountName=:accountName and " +
				"a.accountPass=:accountPass",new String[]{"accountName","accountPass"},objs);
	}
	
	public boolean isNotExistAccountName(String accountName) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from AuctionAccount a where " +
				"a.deleteFlag=0 and a.accountName=:accountName";
		count = Long.parseLong(session.createQuery(hql).setString("accountName", accountName)
				.uniqueResult().toString());
		session.close();
		if(count == 0)
			return true;
		else
			return false;
	}

	public void saveAuctionAccount(AuctionAccount auctionAccount) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionAccount);
	}

	@SuppressWarnings("unchecked")
	public AuctionAccount getAccountInfo(String id) {
		// TODO Auto-generated method stub
		List<AuctionAccount> list = null;
		Session session = getSession();
		String hql = "from AuctionAccount a " +
			"where a.deleteFlag=0 and a.id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}
	
	@SuppressWarnings("unchecked")
	public AuctionAccount getAccountInfoByAccountName(String accountName) {
		// TODO Auto-generated method stub
		List<AuctionAccount> list = null;
		Session session = getSession();
		String hql = "from AuctionAccount a " +
			"where a.deleteFlag=0 and a.accountName=:accountName";
		list = session.createQuery(hql).setString("accountName", accountName).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	//identity...
	public boolean isExistAccountIdentityCard(String guestIdentityCard) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from AuctionGuest where " +
				"deleteFlag=0 and guestIdentityCard=:guestIdentityCard";
		count = Long.parseLong(session.createQuery(hql).setString("guestIdentityCard", guestIdentityCard)
				.uniqueResult().toString());
		session.close();
		if(count != 0)
			return true;
		else
			return false;
	}

	  
	public List<AuctionAccount> getAccountInfoByAccountNameList(String accountName,String type) {
		// TODO Auto-generated method stub
		List<AuctionAccount> list = null;
		Session session = getSession();
		String hql = "from AuctionAccount a " +
			"where a.accountName like  ?  and a.accountType =?" ;
		list = session.createQuery(hql).setString(0, "%"+accountName.trim()+"%").setString(1, type.trim()).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list;
		}
	}

	//根据ID来查
	public AuctionAccount getAccountInfoByID(String id) {
		// TODO Auto-generated method stub
		List<AuctionAccount> list = null;
		Session session = getSession();
		String hql = "from AuctionAccount a " +
			"where  a.id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}
	
	
	 
	public List<AuctionAccount> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) {
		  Session session = this.getSession();
		 Query query=session.createQuery(" from  AuctionAccount  o  "+(wherejpql==null || "".equals(wherejpql.trim())? " ": " where "+ wherejpql)+" "+orderBy);
         setQueryParams(query, queryParams);
	    if(firstPage!=-1 && maxPage!=-1){
	    	query.setFirstResult((page-1)*firstPage).setMaxResults(maxPage);
	     }
	    List<AuctionAccount> list = query.list();
	 	session.flush();
		session.close();
	 		return list;
	}
	public List getcount(String wherejpql, Object[] queryParams) {
		  Session session = this.getSession();
		 Query query=session.createQuery("select count(o.id) from  AuctionAccount  o  "+(wherejpql==null || "".equals(wherejpql.trim())? " ": " where "+ wherejpql)+" ");
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
	//根据身份证来查
	@SuppressWarnings({ "unchecked", "null" })
	public List <Object []>  findBysfz(String sfzhm){
	 	List<Object[]> list =null;
		Session session = getSession();
	  	Query query=session.createQuery("select a.id,a. accountName,b.guestName,b.guestIdentityCard from AuctionAccount a ,AuctionGuest b where  a.accountRelationId=b.id and b.guestIdentityCard = ?");
		query.setString(0, sfzhm.trim() );
		list = query.list();
		 session.close();
	     return list;
	 
    }
	
}