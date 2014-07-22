package com.useeasy.aucton.calendar.dao;

import java.util.List;

import com.useeasy.aucton.calendar.bean.PMTing;

 

public interface PMTingdao {
	  public void save(PMTing pmt);
	    public void delete(PMTing pmt);
	    public void update (PMTing pmt);
	    public PMTing get(Integer id);
	    public List<PMTing> getList(int page, int firstPage, int maxPage,
				String wherejpql, Object[] queryParams, String orderBy);
}
