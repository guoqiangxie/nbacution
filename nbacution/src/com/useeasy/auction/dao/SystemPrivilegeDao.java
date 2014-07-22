package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.SystemPrivilege;

public interface SystemPrivilegeDao {
	public void delete(SystemPrivilege privilege);
	public void save(SystemPrivilege privilege) ;
	public void batchSave(List<SystemPrivilege> privileges);
	public void update(SystemPrivilege privilege) ;
	public List<SystemPrivilege> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy) ;
	public List getcount(String wherejpql, Object[] queryParams);
	
	
	
	
	
}
