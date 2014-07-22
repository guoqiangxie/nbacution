package com.useeasy.auction.notice.dao;
 

import java.util.List;

import com.useeasy.auction.notice.bean.AuctionNotice;





public interface AuctionNoticeDao {
	
	public void save(  AuctionNotice notice);
	public void del(  AuctionNotice notice);
	public   AuctionNotice get(long id);
	public void update(AuctionNotice notice); 
	public List<AuctionNotice> getList(int page,int firstPage,int maxPage,String wheresql,Object [] queryParams,String orderBy);
    public Long getCount(String wherejpql, Object[] queryParams);
}

