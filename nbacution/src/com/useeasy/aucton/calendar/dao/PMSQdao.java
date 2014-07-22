package com.useeasy.aucton.calendar.dao;

import java.util.Date;
import java.util.List;

import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.aucton.calendar.bean.PMTSQ;
import com.useeasy.aucton.calendar.bean.PMTing;

/*
 * 拍卖厅业务
 */
public interface PMSQdao {
	  public void save(PMTSQ pmt);
	    public void delete(PMTSQ pmt);
	    public void update (PMTSQ pmt);
	    public PMTSQ get(Integer id);
	    public List<PMTSQ> getList(int page, int firstPage, int maxPage,String wherejpql, Object[] queryParams, String orderBy);
	    public Long getCount(String day);
	    public Long getCount(String wherejpql, Object[] queryParams) ;
	    public List<AuctionInfo> guajiePmhList(int page, int firstPage, int maxPage,
	    		String wherejpql, Object[] queryParams, String orderBy);
}
