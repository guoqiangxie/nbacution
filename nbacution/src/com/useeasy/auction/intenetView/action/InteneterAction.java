package com.useeasy.auction.intenetView.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.intenetView.bean.IntenetView;
import com.useeasy.auction.intenetView.dao.IntenetetViewDao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

public class InteneterAction extends ActionSupport {
   
	private static final long serialVersionUID = 1L;
	private IntenetetViewDao intenetetViewDao;
       public String addUI(){
    	   if(((SessionContainer) ActionContext.getContext()
   				.getSession().get(Constants.SESEION_LISTENER))==null){
   			return "sessionDestory";
   		}
   		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
   				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
   		if(auctionAccount ==null){
   			return "sessionDestory";
   		}
   		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")|auctionAccount.getAccountType().equals("3")){
   			
   		}else{
   			return "sessionDestory";	
   		}
	      String pmhId= ServletActionContext.getRequest().getParameter("pmhId");
	      ServletActionContext.getRequest().setAttribute("pmhId", pmhId);
	    return "addUI";
   }
   public String add(){
	   if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")|auctionAccount.getAccountType().equals("3")){
			
		}else{
			return "sessionDestory";	
		}
	   String pmhId = ServletActionContext.getRequest().getParameter("pmhId");
	   
	   if(pmhId!=null&&!"".equals(pmhId) ){
		  
	   IntenetView view = new IntenetView();
		 
		 
		 
	   String account = auctionAccount.getAccountName();
	   String pass = auctionAccount.getAccountPass();
	   if(intenetetViewDao.findBy(account , pmhId)!=null){
		    ServletActionContext.getRequest().setAttribute("flag", 0);
			 return "suc";
	   }
       view.setAccountName(account);
       view.setAccountPass(pass);
         
        view.setPmh_id(pmhId);
        intenetetViewDao.add(view);
        //
    
		
	   }else{
		   return "sessionDestory";
	   }
	   
	  
	ServletActionContext.getRequest().setAttribute("flag", 1);
		  return "suc";
	    
   }
   
   public String getList(){
	   AuctionAccount auctionAccount= ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if( auctionAccount==null){
			 return "sessionDestory";
		}
	   String pmhId= ServletActionContext.getRequest().getParameter("pmhId");
	   if(pmhId!=null&&!"".equals(pmhId)){
	      List<IntenetView> list = intenetetViewDao.getViewList(pmhId);
	      ServletActionContext.getRequest().setAttribute("list", list);
	  
	   } else{
		   return "sessionDestory";
	   }
	   return "listView";
   }
       
	public IntenetetViewDao getIntenetetViewDao() {
		return intenetetViewDao;
	}
	public void setIntenetetViewDao(IntenetetViewDao intenetetViewDao) {
		this.intenetetViewDao = intenetetViewDao;
	}
       
	public String updateViewSta(){
		  String pmhId = ServletActionContext.getRequest().getParameter("pmhId");
		   
		   if(pmhId!=null&&!"".equals(pmhId) ){
			  
		   IntenetView view =null;
		   if(((SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER))==null){
				return "sessionDestory";
			}
			AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
			if(auctionAccount ==null){
				return "sessionDestory";
			}
			if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
				
			}else{
				return "sessionDestory";	
			}
		   String account = ServletActionContext.getRequest().getParameter("account");
		   String pass = auctionAccount.getAccountPass();
		   view = intenetetViewDao.findBy(account, pmhId);
		   if(view!=null){
			    view.setViewSta("1");
			    intenetetViewDao.update(view);
			    try {
					PrintWriter out = ServletActionContext.getResponse().getWriter();
					out.print("yes");
					out.flush();
					out.close();
					
					
				} catch (IOException e) {
					 
					e.printStackTrace();
				}
		   }
		 
		
	}
		   return null;
}
}
