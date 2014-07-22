package com.useeasy.auction.pmhinfo.pmhinfodao;

import java.util.ArrayList;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;


public class AuctionIndexMessageHibernateDao  extends HibernateDaoSupport implements AuctionIndexMessageDao{

	public List query(String Auctionid, int page,
			int pagesize) {
//		 Session session=getSession();
//		 List list=session.createQuery("  from  ItemInfo o where o.auctionId in(select    oo.id from AuctionInfo oo    )").setFirstResult(0).setMaxResults(5).list();
//		 session.flush();
//		 session.close();
		 
			List<ItemInfo> list = new ArrayList<ItemInfo>();
			if (page <= 0) {
				return null;
			}
			Session session = getSession();
			String hql = "";
			
			if (null == Auctionid) {
				hql = "from ItemInfo i "
						+ "where i.deleteFlag=0  and  i.auctionId in (select a.id from AuctionInfoIndexDto a where a.deleteFlag=0  AND (auctionStatus=0 or auctionStatus=1)) and i.itemType in ('1','2','3','4','5','6','7') and i.itemStatus=0 order by itemNumber desc";
				list = session.createQuery(hql)
						.setFirstResult((page - 1) * pagesize)
						.setMaxResults(pagesize).list();
			} else {
				int auctionid = Integer.parseInt(Auctionid);
				hql = "from ItemInfo i "
						+ "where i.deleteFlag=0 and i.auctionId="+auctionid+" order by itemNumber asc   ";
				list = session.createQuery(hql)
						.setFirstResult((page - 1) * pagesize)
						.setMaxResults(pagesize).list();
			}
			session.close();
		 return   list;
		
		
	
	}
	
	public  List query_all(Integer firstResult,Integer maxResult,Integer PageNo){
		 Session session=getSession();
		 List list=null;
		 
			String	hql = "from ItemInfo i "
						+ "where i.deleteFlag=0  and  i.auctionId in (select a.id from AuctionInfoIndexDto a where a.deleteFlag=0  AND (auctionStatus=0 or auctionStatus=1)) and i.itemType in ('1','2','3','4','5','6','7') and i.itemStatus=0 order by itemNumber desc";
				list = session.createQuery(hql)
						.setFirstResult((PageNo - 1) * maxResult)
						.setMaxResults(maxResult).list();
		 
		 session.flush();
		 session.close();
	     return  list;
	}
	
	public  List getCount(){
		 Session session=getSession();
		 List list=session.createQuery("select count(i) from ItemInfo i "
						+ "where i.deleteFlag=0  and  i.auctionId in (select a.id from AuctionInfoIndexDto a where a.deleteFlag=0  AND (auctionStatus=0 or auctionStatus=1)) and i.itemType in ('1','2','3','4','5','6','7') and i.itemStatus=0 ").list();
		 session.flush();
		 session.close();
	     return  list;
	}

	public ItemInfo query_all(long id) {
		return getHibernateTemplate().get(ItemInfo.class, id);
 	 	 
	}

	public List querytype(String type,Integer firstResult,Integer maxResult,Integer PageNo) {
      Session session=getSession();
      List list=null;
      Query query =session.createQuery("from ItemInfo i "
						+ "where i.deleteFlag=0  and  i.auctionId in (select a.id from AuctionInfoIndexDto a where a.deleteFlag=0  AND (auctionStatus=0 or auctionStatus=1)) and i.itemType =:auctionType and i.itemStatus=0  ").setString("auctionType", type);
      query.setFirstResult((PageNo-1)*firstResult);
      query.setMaxResults(maxResult);
      list=query.list();
      session.close();
		return list;
	}
	
	public List gettypeont(String type){
		Session session=getSession();
		List list=session.createQuery("select count(i) from ItemInfo i "
						+ "where i.deleteFlag=0  and  i.auctionId in (select a.id from AuctionInfoIndexDto a where a.deleteFlag=0  AND (auctionStatus=0 or auctionStatus=1)) and i.itemType =:auctionType and i.itemStatus=0  ").setString("auctionType", type).list();
		return list;
	}

	
	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(
			String relationId, String uploadType) {
		// TODO Auto-generated method stub
		List<UploadImgInfo> list = null;
		Session session = getSession();
		String hql = "from UploadImgInfo u "
				+ "where u.relationId=:relationId and u.uploadType=:uploadType ";
		list = session.createQuery(hql).setString("relationId", relationId)
				.setString("uploadType", uploadType).list();
		session.close();
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}
}
