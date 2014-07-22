package com.useeasy.auction.canvass_business_orders.dao;

import java.util.List;

import com.useeasy.auction.canvass_business_orders.bean.BusinessBean;
 

public interface BusinessDao {
	public void save(  BusinessBean cbo);
	public void del(  BusinessBean cbo);
	public   BusinessBean get(Integer id);
	public void update(BusinessBean cbo); 
	public List<BusinessBean> getList(int page,int firstPage,int maxPage,String wheresql,Object [] queryParams,String orderBy);
    public Long getCount(String wherejpql, Object[] queryParams);

}
