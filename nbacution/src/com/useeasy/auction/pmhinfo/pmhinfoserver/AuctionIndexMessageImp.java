package com.useeasy.auction.pmhinfo.pmhinfoserver;

import java.util.Date;

import java.util.List;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.pmhinfo.pmhinfodao.AuctionIndexMessageHibernateDao;


public class AuctionIndexMessageImp implements AuctionIndexService{
     private AuctionIndexMessageHibernateDao indexmDao;
     
	public AuctionIndexMessageHibernateDao getIndexmDao() {
		return indexmDao;
	}

	public void setIndexmDao(AuctionIndexMessageHibernateDao indexmDao) {
		this.indexmDao = indexmDao;
	}

	public List query(String Auctionid, int page,
			int pagesize) {
		
		return indexmDao.query(Auctionid,page,pagesize);
	}

	public List query_all(Integer firstResult,Integer maxResult,Integer PageNo) {
		// TODO Auto-generated method stub
		return indexmDao.query_all( firstResult, maxResult, PageNo);
	}

	public ItemInfo query_all(long id ) {
		// TODO Auto-generated method stub
		return indexmDao.query_all(id);
	}

	public List querytype(String type,Integer firstResult,Integer maxResult,Integer PageNo) {
		// TODO Auto-generated method stub
		return indexmDao.querytype(type, firstResult, maxResult, PageNo);
	}

	public  List getCount(){
		return indexmDao.getCount();
	}

	public List gettypeont(String type) {
		// TODO Auto-generated method stub
		return indexmDao.gettypeont(type);
	}

	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(
			String relationId, String uploadType){
		indexmDao.getUploadImgByUploadTypeAndRelationId(relationId, uploadType);
		return null;
	}

}
