package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.PayRecordInfo;
import com.useeasy.auction.dao.IPayRecordInfoDAO;
import com.useeasy.auction.service.IPayRecordInfoService;

public class PayRecordInfoServiceImp implements IPayRecordInfoService {

	private IPayRecordInfoDAO dao;
	
	public IPayRecordInfoDAO getDao() {
		return dao;
	}

	public void setDao(IPayRecordInfoDAO dao) {
		this.dao = dao;
	}

	public void savePayRecordInfo(PayRecordInfo payRecordInfo) {
		// TODO Auto-generated method stub
		dao.savePayRecordInfo(payRecordInfo);
	}

	public List<PayRecordInfo> getCheckedPayRecordList(String auctionId,
			String accountId, String payType) {
		// TODO Auto-generated method stub
		return dao.getCheckedPayRecordList(auctionId, accountId, payType);
	}

	public PayRecordInfo getPayRecordInfoByOrderId(String orderId) {
		// TODO Auto-generated method stub
		return dao.getPayRecordInfoByOrderId(orderId);
	}

	
}
