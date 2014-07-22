package com.useeasy.auction.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ItemDetailInfo;
import com.useeasy.auction.dao.IItemDetailInfoDAO;
public class ItemDetailInfoHibernateDAO extends HibernateDaoSupport implements IItemDetailInfoDAO {

	
	public void saveItemDetailInfo(ItemDetailInfo itemDetailInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(itemDetailInfo);
	}

	@SuppressWarnings({ "rawtypes" })
	public ItemDetailInfo getItemDetailInfo(String itemId) {
		// TODO Auto-generated method stub
		Object[] objs = {itemId};
		List list = getHibernateTemplate().findByNamedParam("from ItemDetailInfo itemDetailInfo  " +
				"where itemDetailInfo.deleteFlag=0 and itemDetailInfo.itemId=:itemId",new String[]{"itemId"},objs);
		if(list == null || list.size() == 0){
			return null;
		}else {
			return (ItemDetailInfo) list.get(0);
		}
	}

	
	
}