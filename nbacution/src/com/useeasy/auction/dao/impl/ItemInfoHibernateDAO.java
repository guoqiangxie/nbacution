package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemInfoIndexDto;
import com.useeasy.auction.bean.ItemPriceRecord;
import com.useeasy.auction.dao.IItemInfoDAO;
import com.useeasy.auction.dto.ItemInfoDto;
import com.useeasy.frame.util.BasePage;

public class ItemInfoHibernateDAO extends HibernateDaoSupport implements IItemInfoDAO {

	@SuppressWarnings("unchecked")
	public List<ItemInfoIndexDto> getItemRecommendItemList() {
		// TODO Auto-generated method stub
		List<ItemInfoIndexDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoIndexDto i " +
			"where i.deleteFlag=0 and i.recommendFlag=1 " +
			"and i.auctionDeleteFlag=0 and i.publishFlag=1 " +
			"and (i.auctionStatus=0 or i.auctionStatus=1) ";
		String baseOrder = " order by i.id ";
		String hql = "";
		hql = baseSql + baseOrder;
		list = session.createQuery(hql).list();	
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfo> getItemList(String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemInfo itemInfo  " +
				"where itemInfo.deleteFlag=0 and itemInfo.auctionId=:auctionId " +
				"order by itemInfo.itemNumber,itemInfo.updateTime desc",new String[]{"auctionId"},objs);
	}

	public void saveItemInfo(ItemInfo itemInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(itemInfo);
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfo> getItemInfoByRecommend(String auctionId) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		Object[] objs = {auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemInfo itemInfo  where itemInfo.deleteFlag=0 and itemInfo.auctionId=:auctionId and itemInfo.recommendFlag=1 order by itemInfo.itemNumber,itemInfo.updateTime desc",new String[]{"auctionId"},objs);
	}

	public ItemInfo getItemInfo(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(ItemInfo.class, Long.parseLong(id));
	}

	@SuppressWarnings("unchecked")
	public ItemInfo getItemInfoByIndexAndAuction(String itemIndex,
			String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {itemIndex,auctionId};
		List<ItemInfo> list = getHibernateTemplate().findByNamedParam("from ItemInfo itemInfo " +
				"where itemInfo.deleteFlag=0 and itemInfo.itemNumber=:itemIndex and itemInfo.auctionId=:auctionId " +
				"order by itemInfo.itemNumber,itemInfo.updateTime desc",new String[]{"itemIndex","auctionId"},objs);
		if(list != null && list.size() > 0){
			return (ItemInfo)list.get(0);
		}else{
			return null;
		}
	}

	public String getItemCount(String auctionId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from ItemInfo itemInfo " +
				"where itemInfo.deleteFlag=0 and itemInfo.auctionId=:auctionId ";
		count = Long.parseLong(session.createQuery(hql)
				.setString("auctionId", auctionId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfoIndexDto> getItemList(String auctionId, BasePage basePage) {
		// TODO Auto-generated method stub
		List<ItemInfoIndexDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoIndexDto a " +
			"where a.deleteFlag=0 and a.auctionId=:auctionId ";
		String baseOrder = " order by a.itemNumber ";
		String hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId)
			.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
			.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemInfoIndexDto> getItemInfoListTop(String typeId,
			String itemId) {
		// TODO Auto-generated method stub
		List<ItemInfoIndexDto> list = null;
		Session session = getSession();
		String hql = "select a from ItemInfoIndexDto a, AuctionInfo b " +
			"where a.deleteFlag=0 and a.auctionId=b.id and b.deleteFlag=0 " +
			"and b.publishFlag=1 and b.auctionStatus<>2 and a.id<>:itemId and a.itemType=:typeId";
		list = session.createQuery(hql).setString("itemId", itemId)
			.setString("typeId", typeId).setMaxResults(9).list();
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemInfo> getItemListInFinance(String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemInfo itemInfo  " +
				"where itemInfo.deleteFlag=0 and itemInfo.auctionId=:auctionId " +
				"and itemInfo.itemStatus=5 " +
				"order by itemInfo.itemNumber,itemInfo.updateTime desc",new String[]{"auctionId"},objs);
	}

	public String getItemCountInSearch(String companyId, String searchKind,
			String key) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from ItemInfoIndexDto i " +
			"where i.deleteFlag=0 and i.auctionDeleteFlag=0 and i.publishFlag=1 " +
			"and i.itemName like :key ";
		String hql = "";
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=7 ";
		}
		
		if(companyId == null){
			hql = baseSql;
			count = Long.parseLong(session.createQuery(hql)
				.setString("key", "%" + key + "%").uniqueResult().toString());
		}else{
			hql = baseSql + " and i.companyId=:companyId ";
			count = Long.parseLong(session.createQuery(hql)
				.setString("companyId", companyId)
				.setString("key", "%" + key + "%").uniqueResult().toString());
		}
		
		session.close();
		return "" + count;
	} 
	

	@SuppressWarnings("unchecked")
	public List<ItemInfoIndexDto> getItemListInSearch(String companyId,
			String searchKind, BasePage basePage, String key) {
		// TODO Auto-generated method stub
		List<ItemInfoIndexDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoIndexDto i " +
			"where i.deleteFlag=0 and i.auctionDeleteFlag=0 and i.publishFlag=1 " +
			"and i.itemName like :key ";
		String hql = "";
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and i.itemType=7 ";
		}
		
		if(companyId == null){
			hql = baseSql;
			list = session.createQuery(hql)
				.setString("key", "%" + key + "%")
				.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
				.setMaxResults((int)(basePage.getPageSize())).list();
		}else{
			hql = baseSql + " and i.companyId=:companyId ";
			list = session.createQuery(hql)
				.setString("companyId", companyId)
				.setString("key", "%" + key + "%")
				.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
				.setMaxResults((int)(basePage.getPageSize())).list();
		}
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfoIndexDto> getItemInfoTopListInCompanyIndex(
			String companyId) {
		// TODO Auto-generated method stub
		List<ItemInfoIndexDto> list = null;
		Session session = getSession();
		String hql = "select a from ItemInfoIndexDto a, AuctionInfo b " +
			"where a.deleteFlag=0 and a.auctionId=b.id and b.deleteFlag=0 " +
			"and b.publishFlag=1 and b.auctionStatus<>2 and a.companyId=:companyId ";
		list = session.createQuery(hql).setString("companyId", companyId)
			.setMaxResults(5).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<ItemPriceRecord> getItemPrice(String itemId) {
		// TODO Auto-generated method stub
		List<ItemPriceRecord> list = null;
		Session session = getSession();
		String hql = "from ItemPriceRecord where itemId=:itemId and currentFlag = 0";
		list = session.createQuery(hql).setString("itemId", itemId).list();
		session.close();
		return list;
	}

	public String getItemCountInAnalyze(String auctionId, String searchKind) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from ItemInfo i " +
			"where i.deleteFlag=0 and i.auctionId=:auctionId ";
		String hql = "";
		if("1".equals(searchKind)){  //all
			hql = baseSql + "";
		}else if("2".equals(searchKind)){  //deal
			hql = baseSql + " and i.itemStatus=5 ";
		}else if("3".equals(searchKind)){  //pass
			hql = baseSql + " and i.itemStatus=6 ";
		}else if("4".equals(searchKind)){  //che
			hql = baseSql + " and i.itemStatus=7 ";
		}else if("5".equals(searchKind)){  //huan
			hql = baseSql + " and i.itemStatus=8 ";
		}else if("6".equals(searchKind)){  //deal
			hql = baseSql + " and i.itemStatus=5 and i.priceUserType=1";
		}else if("7".equals(searchKind)){  //deal
			hql = baseSql + " and i.itemStatus=5 and i.priceUserType=2";
		}else{
			hql = baseSql + "";
		}
		count = Long.parseLong(session.createQuery(hql)
				.setString("auctionId", auctionId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	public String getItemPriceCountInAnalyze(String auctionId, String searchKind) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from ItemPriceRecord p " +
			"where p.currentFlag=0 and p.auctionId=:auctionId ";
		String hql = "";
		if("1".equals(searchKind)){  //all
			hql = baseSql + "";
		}else if("2".equals(searchKind)){  //alive
			hql = baseSql + " and p.priceUserType=1 ";
		}else if("3".equals(searchKind)){  //net
			hql = baseSql + " and p.priceUserType=2 ";
		}else{
			hql = baseSql + "";
		}
		count = Long.parseLong(session.createQuery(hql)
				.setString("auctionId", auctionId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	public String getPricedItemCountInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select p.item_id from pmh.dbo.auction_price_recorder_info p " +
			"where p.current_flag=0 and p.auction_id=:auctionId ";
		String hql = "";
		if("1".equals(searchKind)){  //all
			hql = baseSql + "";
		}else if("2".equals(searchKind)){  //alive
			hql = baseSql + " and p.price_user_type=1 ";
		}else if("3".equals(searchKind)){  //net
			hql = baseSql + " and p.price_user_type=2 ";
		}else{
			hql = baseSql + "";
		}
		hql = "select count(*) from ( " + hql + " group by p.item_id ) as b";
		count = Long.parseLong(session.createSQLQuery(hql)
				.setString("auctionId", auctionId)
				.uniqueResult().toString());
		session.close();
		return "" + count;
	}

	public String getDealedItemCurrentPriceInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		double count = 0;
		Session session = getSession();
		String baseSql = "select sum(cast(i.itemCurrentPrice as double)) from ItemInfo i " +
			"where i.deleteFlag=0 and i.auctionId=:auctionId and i.itemStatus=5 ";
		String hql = "";
		if("1".equals(searchKind)){  //all
			hql = baseSql + "";
		}else if("2".equals(searchKind)){  //alive
			hql = baseSql + " and i.priceUserType=1 ";
		}else if("3".equals(searchKind)){  //net
			hql = baseSql + " and i.priceUserType=2 ";
		}else{
			hql = baseSql + "";
		}
		Object object = session.createQuery(hql)
				.setString("auctionId", auctionId)
				.uniqueResult();
		if(object != null)
			count = Double.parseDouble(object.toString());
		else
			count = 0;
		session.close();
		java.math.BigDecimal bd = new java.math.BigDecimal(count);  
		return "" + bd.toPlainString();
	}

	public String getDealedItemPriceInAnalyze(String auctionId,
			String searchKind) {
		// TODO Auto-generated method stub
		double count = 0;
		Session session = getSession();
		String baseSql = "select sum(cast(i.itemPrice as double)) from ItemInfo i " +
			"where i.deleteFlag=0 and i.auctionId=:auctionId and i.itemStatus=5 ";
		String hql = "";
		if("1".equals(searchKind)){  //all
			hql = baseSql + "";
		}else if("2".equals(searchKind)){  //alive
			hql = baseSql + " and i.priceUserType=1 ";
		}else if("3".equals(searchKind)){  //net
			hql = baseSql + " and i.priceUserType=2 ";
		}else{
			hql = baseSql + "";
		}
		Object object = session.createQuery(hql)
				.setString("auctionId", auctionId)
				.uniqueResult();
		if(object != null)
			count = Double.parseDouble(object.toString());
		else
			count = 0;
		session.close();
		java.math.BigDecimal bd = new java.math.BigDecimal(count);  
		return "" + bd.toPlainString();
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfo> getItemResultList(String auctionId,
			String searchType, String bidNum) {
		// TODO Auto-generated method stub
		List<ItemInfo> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfo i  " +
				"where i.deleteFlag=0 and i.auctionId=:auctionId ";
		String hql = "";
		String order = " order by i.itemNumber";
		if(bidNum != null){
			baseSql = baseSql + " and i.priceBidNum=:bidNum ";
			if("1".equals(searchType)){  
				baseSql = baseSql + "";
			}else if("2".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=5 ";
			}else if("3".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=6 ";
			}else if("4".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=7 ";
			}else if("5".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=8 ";
			}else{
				baseSql = baseSql + "";
			}
			hql = baseSql + order;
			list = session.createQuery(hql)
					.setString("auctionId", auctionId)
					.setString("bidNum", bidNum).list();
		}else{
			baseSql = baseSql + "";
			if("1".equals(searchType)){  
				baseSql = baseSql + "";
			}else if("2".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=5 ";
			}else if("3".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=6 ";
			}else if("4".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=7 ";
			}else if("5".equals(searchType)){  
				baseSql = baseSql + " and i.itemStatus=8 ";
			}else{
				baseSql = baseSql + "";
			}
			hql = baseSql + order;
			list = session.createQuery(hql)
					.setString("auctionId", auctionId).list();
		}
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getBidNumResultList(String auctionId) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String baseSql = "select i.priceBidNum from ItemInfo i  " +
				"where i.deleteFlag=0 and i.auctionId=:auctionId and i.itemStatus=5 and i.priceBidNum is not null";
		String hql = "";
		String group = " group by i.priceBidNum";
		String order = " order by cast(i.priceBidNum as long)";
		baseSql = baseSql + "";
		hql = baseSql + group + order;
		list = session.createQuery(hql)
					.setString("auctionId", auctionId).list();
		session.close();
		return list;
	}

	
	
	
	
	
	
	
	
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getItemInfoListRecommend() {
		// TODO Auto-generated method stub
		List<Object[]> list = null;
		Session session = getSession();
		String baseSql = "select i.id_num,i.o_cname,i.id_num,i.id_num " +
				"from pmh.dbo.auction_item_info as i " +
				"left outer join pmh.dbo.auction_pmh_info as a on i.pub_id=a.id_num " +
				"where i.delete_flag=0 and i.recommend_type=1 and a.delete_flag=0 " +
				"and a.publish_flag=1 and (a.auction_status=0 or a.auction_status=1) " +
				"order by i.id_num";
		String hql = "";
		hql = baseSql;
		list = session.createSQLQuery(hql).list();	
		session.close();
		return list;
	}

	public String getItemInfoDtoCount(String auctionId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String hql = "select count(id) from ItemInfoDto " +
				"where deleteFlag=0 and auctionId=:auctionId ";
		count = Long.parseLong(session.createQuery(hql)
				.setString("auctionId", auctionId).uniqueResult().toString());
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfoDto> getItemInfoDtoList(String auctionId,
			BasePage basePage) {
		// TODO Auto-generated method stub
		List<ItemInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoDto " +
			"where deleteFlag=0 and auctionId=:auctionId ";
		String baseOrder = " order by itemNumber ";
		String hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId)
			.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
			.setMaxResults((int)(basePage.getPageSize())).list();
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public ItemInfoDto getItemInfoDto(String id) {
		// TODO Auto-generated method stub
		List<ItemInfoDto> list = null;
		Session session = getSession();
		String hql = "from ItemInfoDto " +
			"where deleteFlag=0 and id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	@SuppressWarnings("unchecked")
	public ItemInfoDto getItemInfoDtoByIndexAndAuction(String itemIndex,
			String auctionId) {
		// TODO Auto-generated method stub
		List<ItemInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoDto " +
			"where deleteFlag=0 and itemNumber=:itemIndex and auctionId=:auctionId ";
		String baseOrder = " order by itemNumber ";
		String hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId)
				.setString("itemIndex", itemIndex).list();
		session.close();
		if(list != null && list.size() > 0){
			return (ItemInfoDto)list.get(0);
		}else{
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getItemInfoListSimilar(String typeId, String itemId) {
		// TODO Auto-generated method stub
		List<Object[]> list = null;
		Session session = getSession();
		String baseSql = "select i.id_num,i.o_cname " +
				"from pmh.dbo.auction_item_info as i " +
				"left outer join pmh.dbo.auction_pmh_info as a on i.pub_id=a.id_num " +
				"where i.delete_flag=0 and a.delete_flag=0 " +
				"and a.publish_flag=1 and (a.auction_status=0 or a.auction_status=1) " +
				"and i.id_num<>:itemId and i.type_id=:typeId";
		String hql = "";
		hql = baseSql;
		list = session.createSQLQuery(hql).setString("itemId", itemId)
				.setString("typeId", typeId).setMaxResults(9).list();	
		session.close();
		return list;
	}

	public String getItemInfoCountInSearch(String companyId, String searchKind,
			String key) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(i.id_num) " +
				"from pmh.dbo.auction_item_info as i " +
				"left outer join pmh.dbo.auction_pmh_info as a on i.pub_id=a.id_num " +
				"where i.delete_flag=0 and a.delete_flag=0 and a.publish_flag=1 " +
				"and i.o_cname like :key ";
		String hql = "";
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=7 ";
		}
		if(companyId == null){
			hql = baseSql;
			count = Long.parseLong(session.createSQLQuery(hql)
				.setString("key", "%" + key + "%").uniqueResult().toString());
		}else{
			hql = baseSql + " and i.c_id=:companyId ";
			count = Long.parseLong(session.createSQLQuery(hql)
				.setString("companyId", companyId)
				.setString("key", "%" + key + "%").uniqueResult().toString());
		}
		
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getItemInfoListInSearch(String companyId,
			String searchKind, BasePage basePage, String key) {
		// TODO Auto-generated method stub
		List<Object[]> list = null;
		Session session = getSession();
		String baseSql = "select i.id_num,i.o_cname,o_number,o_margin," +
				"o_reference_1,o_reference_2,o_state,i.id_num as aaa,i.id_num as bbb " +
				"from pmh.dbo.auction_item_info as i " +
				"left outer join pmh.dbo.auction_pmh_info as a on i.pub_id=a.id_num " +
				"where i.delete_flag=0 and a.delete_flag=0 and a.publish_flag=1 " +
				"and i.o_cname like :key ";
		String hql = "";
		hql = baseSql;
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and i.type_id=7 ";
		}
		if(companyId == null){
			hql = baseSql;
			list = session.createSQLQuery(hql)
				.setString("key", "%" + key + "%")
				.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
				.setMaxResults((int)(basePage.getPageSize())).list();
		}else{
			hql = baseSql + " and i.c_id=:companyId ";
			list = session.createSQLQuery(hql)
				.setString("companyId", companyId)
				.setString("key", "%" + key + "%")
				.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
				.setMaxResults((int)(basePage.getPageSize())).list();
		}
		session.close();
		return list;
		
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getItemInfoListTop(String companyId) {
		// TODO Auto-generated method stub
		List<Object[]> list = null;
		Session session = getSession();
		String baseSql = "select i.id_num,i.o_cname,i.id_num,i.id_num " +
				"from pmh.dbo.auction_item_info as i " +
				"left outer join pmh.dbo.auction_pmh_info as a on i.pub_id=a.id_num " +
				"where i.delete_flag=0 and a.delete_flag=0 " +
				"and a.publish_flag=1 and (a.auction_status=0 or a.auction_status=1) " +
				"and i.c_id=:companyId ";
		String hql = "";
		hql = baseSql;
		list = session.createSQLQuery(hql).setString("companyId", companyId)
				.setMaxResults(5).list();	
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<ItemInfoDto> getItemInfoDtoList(String auctionId) {
		// TODO Auto-generated method stub
		List<ItemInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from ItemInfoDto " +
			"where deleteFlag=0 and auctionId=:auctionId ";
		String baseOrder = " order by itemNumber ";
		String hql = baseSql + baseOrder;
		list = session.createQuery(hql).setString("auctionId", auctionId).list();
		session.close();
		return list;
	}
	
	
}