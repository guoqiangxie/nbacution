package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.AuctionSettlementInfo;
import com.useeasy.auction.dao.IAuctionSettlementInfoDAO;

public class AuctionSettlementInfoHibernateDAO extends HibernateDaoSupport
		implements IAuctionSettlementInfoDAO {
	
	@SuppressWarnings("unchecked")
	public AuctionSettlementInfo getIsSettlement(String auctionId, String accountId) {
		Session session = getSession();
		String hql = "from AuctionSettlementInfo t where t.auctionId = :auctionId and t.accountId = :accountId";
		List<AuctionSettlementInfo> list = session.createQuery(hql).setString("auctionId", auctionId).setString("accountId", accountId).list();
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	public void saveSettlement(AuctionSettlementInfo auctionSettlementInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionSettlementInfo);
	}

}
