package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.PayRecordInfo;
import com.useeasy.auction.dao.IPayRecordInfoDAO;

public class PayRecordInfoHibernateDAO extends HibernateDaoSupport implements
		IPayRecordInfoDAO {

	public void savePayRecordInfo(PayRecordInfo payRecordInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(payRecordInfo);
	}

	@SuppressWarnings("unchecked")
	public List<PayRecordInfo> getCheckedPayRecordList(String auctionId,
			String accountId, String payType) {
		// TODO Auto-generated method stub
		List<PayRecordInfo> list = null;
		Session session = getSession();
		String sql = "from PayRecordInfo a where a.deleteFlag=0 and a.accountId=:accountId " +
				"and a.auctionId=:auctionId and a.payType=:payType and a.payStatus=0 ";
		list = session.createQuery(sql).setString("accountId", accountId)
		.setString("auctionId", auctionId).setString("payType", payType).list();
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public PayRecordInfo getPayRecordInfoByOrderId(String orderId) {
		// TODO Auto-generated method stub
		List<PayRecordInfo> list = null;
		Session session = getSession();
		String hql = "from PayRecordInfo p " +
			"where p.deleteFlag=0 and p.orderId=:orderId ";
		list = session.createQuery(hql).setString("orderId", orderId).list();	
		session.close();
		if(list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	
	
}
