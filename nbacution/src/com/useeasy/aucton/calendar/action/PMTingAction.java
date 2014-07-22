package com.useeasy.aucton.calendar.action;

 
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.aucton.calendar.bean.PMTing;
import com.useeasy.aucton.calendar.bean.UserTime;
import com.useeasy.aucton.calendar.dao.PMTingdao;
import com.useeasy.aucton.calendar.dao.UserTimedao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

/*
 * 拍卖厅操作
 */
public class PMTingAction {
	private PMTingdao dao;
	private PMTing pmt;
	private UserTimedao  udo;
	private Set<UserTime> ut = new HashSet<UserTime>();
   /*
    * 新加拍卖厅UI
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
		ServletActionContext.getRequest().setAttribute("userTime",udo.getList(-1, -1, -1, null, null, ""));
		return "addUI";
	}
	
	 /*
	    * 新加拍卖厅
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
	    pmt.setUt(ut);
		dao.save(pmt);
		try {
			ServletActionContext.getResponse().sendRedirect("pmtingAction_getList");
		} catch (Exception e) {
		 
			e.printStackTrace();
		}
		return null;
	}
	
	 /*
	    * 修改拍卖厅UI
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
			PMTing pmt = dao.get(Integer.valueOf(id.trim()));
			ServletActionContext.getRequest().setAttribute("pmt", pmt);
		}
		ServletActionContext.getRequest().setAttribute("userTime",udo.getList(-1, -1, -1, null, null, ""));
		return "updateUI";
	}
	
	public String getList(){
		
		List <PMTing> list = dao.getList(-1, -1, -1, null, null, "");
		ServletActionContext.getRequest().setAttribute("list",list);

		return "getList";
	}
	
	 /*
	    * 修改拍卖厅
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
		pmt.setUt(ut);
		dao.update(pmt);
		try {
			ServletActionContext.getResponse().sendRedirect("pmtingAction_getList");
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
			PMTing pmt = dao.get(Integer.valueOf(id.trim()));
			if(pmt!=null){
			   dao.delete(pmt);
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

	
	/*
	 * 拍协换厅的时候查询出厅
	 */
	public String changeTingselect(){
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
			List <PMTing> list = dao.getList(-1, -1, -1, null, null, "");
			ServletActionContext.getRequest().setAttribute("pmtlist",list);
		}else{
			return "sessionDestory";	
		}
		return null;
	}
	
	/*
	 * 换厅的时候厅与时间级联动效果
	 */
	public String timeduan(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null){
			PMTing pmt = dao.get(Integer.valueOf(id.trim()));
			 StringBuffer sff = new StringBuffer();
			 sff.append("<select name='time'  id='time'>");
			   for(UserTime p : pmt.getUt()){
				   sff.append("<option value='").append(p.getId()).append("'>").append(p.getUseTime()).append("</option>");
			   }
			 
			 sff.append("</select'>");
			 PrintWriter out;
				try {
					out = ServletActionContext.getResponse().getWriter();
					out.print(sff.toString());
					out.flush();
					out.close();
				} catch ( Exception e) {
					 
					e.printStackTrace();
				}
		}
		return null;
	}
	public PMTingdao getDao() {
		return dao;
	}

	public void setDao(PMTingdao dao) {
		this.dao = dao;
	}

	public PMTing getPmt() {
		return pmt;
	}

	public void setPmt(PMTing pmt) {
		this.pmt = pmt;
	}

	public UserTimedao getUdo() {
		return udo;
	}

	public void setUdo(UserTimedao udo) {
		this.udo = udo;
	}

	public Set<UserTime> getUt() {
		return ut;
	}

	public void setUt(Set<UserTime> ut) {
		this.ut = ut;
	}
	
	
	
	
}
