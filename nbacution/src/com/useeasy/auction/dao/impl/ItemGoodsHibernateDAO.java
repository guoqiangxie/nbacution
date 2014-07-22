package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemGoodsDto;
import com.useeasy.auction.dao.IItemGoodsDAO;

public class ItemGoodsHibernateDAO extends HibernateDaoSupport implements IItemGoodsDAO {

	public void saveItemGoods(ItemGoods itemGoods) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(itemGoods);
	}

	public String getGoodsVal(String accountId, String auctionId,
			String goodsType) {
		// TODO Auto-generated method stub
		double count = 0;
		Session session = getSession();
		String sql = "select sum(convert(float,goods_val)) from pmh.dbo.auction_goods_info where " +
				"goods_type=:goodsType and account_id=:accountId and auction_id=:auctionId";
		Object object = session.createSQLQuery(sql)
			.setString("goodsType", goodsType).setString("accountId", accountId)
			.setString("auctionId", auctionId).uniqueResult();
		if(object != null){
			count = Double.parseDouble(session.createSQLQuery(sql)
					.setString("goodsType", goodsType).setString("accountId", accountId)
					.setString("auctionId", auctionId).uniqueResult().toString());
		}
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<ItemGoods> getItemGoodsInFinance(String accountId, String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {accountId,auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemGoods itemGoods  where " +
				"itemGoods.accountId=:accountId and itemGoods.auctionId=:auctionId " +
				"and (itemGoods.goodsType=1 or itemGoods.goodsType=2) ",new String[]{"accountId","auctionId"},objs);
	
	}

	@SuppressWarnings("unchecked")
	public List<ItemGoodsDto> getItemGoodsInPayment(String auctionId) {
		// TODO Auto-generated method stub
		Object[] objs = {auctionId};
		return getHibernateTemplate().findByNamedParam("from ItemGoodsDto itemGoodsDto  where " +
				"itemGoodsDto.auctionId=:auctionId  " +
				"and (itemGoodsDto.goodsType=1 or itemGoodsDto.goodsType=2) order by itemGoodsDto.accountId",new String[]{"auctionId"},objs);
	}
}