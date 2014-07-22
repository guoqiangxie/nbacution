package com.useeasy.auction.pmhinfo.pmhinfoserver;

import java.util.Date;
import java.util.List;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;

public interface AuctionIndexService {
	List query(String Auctionid, int page,
			int pagesize);
	List query_all(Integer firstResult,Integer maxResult,Integer PageNo);
	 //List query_all(int  id);
	ItemInfo query_all(long id );
	List querytype(String type,Integer firstResult,Integer maxResult,Integer PageNo);
	public  List getCount();
	public List gettypeont(String type);
	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(
			String relationId, String uploadType);
}
