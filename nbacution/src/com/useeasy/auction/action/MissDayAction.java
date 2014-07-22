package com.useeasy.auction.action;

import com.opensymphony.xwork2.ActionContext;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.MissDayBean;
import com.useeasy.auction.dao.MissDayDao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

public class MissDayAction {
	public MissDayDao dao;
	public MissDayBean missBean;
   public String missDay(){
	    SessionContainer manager=(SessionContainer) ActionContext.getContext()
		.getSession().get(Constants.SESEION_LISTENER);
	    if(manager==null){
			 return "error";
		}
		AuctionAccount auction=manager.getAuctionAccount();
		 
		if(auction==null){
			 return "error";
		}
		String managerName=auction.getAccountName();
		 
		if( managerName.equalsIgnoreCase("useeasyqwe123")){
	       MissDayBean m=dao.get();
	      if(m==null||m.getFlag().equalsIgnoreCase("1")){
		       System.out.println(missBean.getMissDay());
			  dao.add(missBean);
		  }
	     
	   } else{
		   return "error";
	   }
	   return "sucess";
   }
public MissDayDao getDao() {
	return dao;
}
public void setDao(MissDayDao dao) {
	this.dao = dao;
}
public MissDayBean getMissBean() {
	return missBean;
}
public void setMissBean(MissDayBean missBean) {
	this.missBean = missBean;
}
 
   
}
