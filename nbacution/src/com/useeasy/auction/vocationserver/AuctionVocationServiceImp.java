package com.useeasy.auction.vocationserver;

import java.util.List;

import com.useeasy.auction.vocationbean.AuctionVocationNews;
import com.useeasy.auction.vocationdao.AuctionVocationDao;


 
public class AuctionVocationServiceImp implements IAuctionVocationNewsService{
      private  AuctionVocationDao indexvocationDao ;
	public AuctionVocationDao getIndexvocationDao() {
		return indexvocationDao;
	}

	public void setIndexvocationDao(AuctionVocationDao indexvocationDao) {
		this.indexvocationDao = indexvocationDao;
	}

	public boolean addvocationnews(AuctionVocationNews aun) {
	      
		return indexvocationDao.addvocationnews(aun);
	}



	public List queryall(Integer firstResult,Integer maxResult,Integer PageNo) {
		// TODO Auto-generated method stub
		return indexvocationDao.queryall(firstResult, maxResult,PageNo);
	}

	public List queryid(long id) {
		// TODO Auto-generated method stub
		return indexvocationDao.queryid(id);
	}

	public List queryshow(AuctionVocationNews aun) {
		// TODO Auto-generated method stub
		return indexvocationDao.queryshow(aun);
	}

	public boolean updatevocationnews(AuctionVocationNews aun) {
		// TODO Auto-generated method stub
		return indexvocationDao.updatevocationnews(aun);
	}

	public boolean deletevocationnews(AuctionVocationNews aun) {
		// TODO Auto-generated method stub
		return indexvocationDao.deletevocationnews(aun);
	}

	public AuctionVocationNews get(long id) {
		// TODO Auto-generated method stub
		return indexvocationDao.get(id);
	}
	public List indexqueryall(Integer firstResult,Integer maxResult,Integer PageNo) {
		// TODO Auto-generated method stub
		return indexvocationDao.indexqueryall( firstResult,maxResult, PageNo);
	}

	public List queryvocationcont() {
		// TODO Auto-generated method stub
		return indexvocationDao.queryvocationcont();
	}

}
