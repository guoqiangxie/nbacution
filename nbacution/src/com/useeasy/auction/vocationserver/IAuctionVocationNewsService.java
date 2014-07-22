package com.useeasy.auction.vocationserver;

import java.util.List;

import com.useeasy.auction.vocationbean.AuctionVocationNews;

 

public interface  IAuctionVocationNewsService {
	  boolean addvocationnews(AuctionVocationNews aun);
	    boolean deletevocationnews(AuctionVocationNews aun);
	    boolean updatevocationnews(AuctionVocationNews aun);
	    List queryshow(AuctionVocationNews aun);
	    List queryall(Integer firstResult,Integer maxResult,Integer PageNo);
	    List queryid(long  id);
	    AuctionVocationNews get(long id);
	    List  indexqueryall(Integer firstResult,Integer maxResult,Integer PageNo);
	    public List queryvocationcont();
	   
}
