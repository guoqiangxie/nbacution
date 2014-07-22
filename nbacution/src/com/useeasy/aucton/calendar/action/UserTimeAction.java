package com.useeasy.aucton.calendar.action;

import java.io.PrintWriter;
import java.util.List;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.aucton.calendar.bean.UserTime;
import com.useeasy.aucton.calendar.dao.UserTimedao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

/*
 * 拍卖厅使用时间段
 */
public class UserTimeAction {

 private UserTimedao utdao;
 private UserTime utime;
 
 /*
  * 新加拍卖厅时间UI
  */
	
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
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		 	return "addUI";
	}
	
	 /*
	    * 新加拍卖时间厅
	    */
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
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
	  
		utdao.save(utime);
		try {
			ServletActionContext.getResponse().sendRedirect("utAction_getList");
		} catch (Exception e) {
		 
			e.printStackTrace();
		}
		return null;
	}
	
	 /*
	    * 修改拍卖厅时间UI
	    */
	public String updateUI(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null){
			UserTime time = utdao.get(Integer.valueOf(id.trim()));
			ServletActionContext.getRequest().setAttribute("time", time);
		}
		 
		return "updateUI";
	}
	
	public String getList(){
		List <UserTime> list = utdao.getList(-1, -1, -1, null, null, "");
		ServletActionContext.getRequest().setAttribute("list",list);

		return "getList";
	}
	
	 /*
	    * 修改拍卖厅时间
	    */
	
	public String update(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		 
		utdao.update(utime);
		try {
			ServletActionContext.getResponse().sendRedirect("utAction_getList");
		} catch (Exception e) {
		 
			e.printStackTrace();
		}
		return null;
	}
	
	public String delete(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null){
			UserTime utime = utdao.get(Integer.valueOf(id.trim()));
			 
			if(utime!=null){
				 utdao.delete(utime);
			}
		}
		PrintWriter out;
		try {
			out = ServletActionContext.getResponse().getWriter();
			out.print("yes");
			out.flush();
			out.close();
		} catch ( Exception e) {
			 
			e.printStackTrace();
		}
	
		return null;
	}
 
 
 
 
 
public UserTimedao getUtdao() {
	return utdao;
}

public void setUtdao(UserTimedao utdao) {
	this.utdao = utdao;
}

public UserTime getUtime() {
	return utime;
}

public void setUtime(UserTime utime) {
	this.utime = utime;
}
 
 
 
 
}
