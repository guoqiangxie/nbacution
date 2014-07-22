package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.bean.ItemMarginDto;
import com.useeasy.auction.dao.IItemMarginDAO;

public class ItemMarginHibernateDAO extends HibernateDaoSupport implements IItemMarginDAO {

	public void saveItemMargin(ItemMargin itemMargin) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(itemMargin);
	}

	public String getMarginVal(String accountId, String auctionId,
			String marginType) {
		// TODO Auto-generated method stub
		double count = 0;
		Session session = getSession();
		String sql = "select sum(convert(float,margin_val)) from pmh.dbo.auction_margin_info where " +
				"margin_type=:marginType and account_id=:accountId and auction_id=:auctionId";
		Object object = session.createSQLQuery(sql)
			.setString("marginType", marginType).setString("accountId", accountId)
			.setString("auctionId", auctionId).uniqueResult();
		if(object != null){
			count = Double.parseDouble(session.createSQLQuery(sql)
					.setString("marginType", marginType).setString("accountId", accountId)
					.setString("auctionId", auctionId).uniqueResult().toString());
		}
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ItemMargin> getItemMargin(String accountId, String auctionId,
			String marginType) {
		// TODO Auto-generated method stub
		Object[] objs = {accountId,auctionId,marginType};
		return getHibernateTemplate().findByNamedParam("from ItemMargin itemMargin  where " +
				"itemMargin.accountId=:accountId and itemMargin.auctionId=:auctionId " +
				"and itemMargin.marginType=:marginType",new String[]{"accountId","auctionId","marginType"},objs);
	
	}

	public void removeItemMargin(ItemMargin itemMargin) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(itemMargin);
	}

	public String getMarginValPayed(String accountId, String auctionId) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String sql = "select sum(cast(margin_val as decimal(10,0))) from pmh.dbo.auction_margin_info where " +
				"(margin_type=1 or margin_type=2) and account_id=:accountId and auction_id=:auctionId";
		Object object = session.createSQLQuery(sql)
			.setString("accountId", accountId)
			.setString("auctionId", auctionId).uniqueResult();
		if(object != null){
			count = Long.parseLong(session.createSQLQuery(sql)
					.setString("accountId", accountId)
					.setString("auctionId", auctionId).uniqueResult().toString());
		}
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ItemMargin> getItemMarginInFinance(String accountId, String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {accountId,auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemMargin itemMargin  where " +
				"itemMargin.accountId=:accountId and itemMargin.auctionId=:auctionId " +
				"and (itemMargin.marginType=1 or itemMargin.marginType=2) ",new String[]{"accountId","auctionId"},objs);
	
	}

	@SuppressWarnings("unchecked")
	public List<ItemMarginDto> getItemMarginInPayment(String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemMarginDto itemMarginDto  where " +
				"itemMarginDto.auctionId=:auctionId " +
				"and (itemMarginDto.marginType=1 or itemMarginDto.marginType=2 or itemMarginDto.marginType=3) order by itemMarginDto.accountId",new String[]{"auctionId"},objs);
	}
	
	

	
}