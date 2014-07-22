package com.useeasy.aucton.calendar.dao;

import java.util.List;

import com.useeasy.aucton.calendar.bean.UserTime;

public interface UserTimedao {
    public void save(UserTime ut);
    public void delete(UserTime ut);
    public void update (UserTime ut);
    public UserTime get(Integer ut);
    public List<UserTime> getList(int page, int firstPage, int maxPage,
			String wherejpql, Object[] queryParams, String orderBy);
}
