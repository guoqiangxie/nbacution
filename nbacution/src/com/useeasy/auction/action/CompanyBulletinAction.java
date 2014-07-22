package com.useeasy.auction.action;

import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionBulletin;
import com.useeasy.auction.service.IBulletinInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;

@SuppressWarnings("serial")
public class CompanyBulletinAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(CompanyBulletinAction.class);
	
	private IBulletinInfoService iBulletinInfo;
	
	private AuctionBulletin auctionBulletin;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iBulletinInfo.getBulletinCount(company_id));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<AuctionBulletin> auctionBulletinList = iBulletinInfo.getBulletinList(company_id, basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		ServletActionContext.getRequest().setAttribute("auctionBulletinList", auctionBulletinList);
		
		return "index";
	}

	public String add(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "add";
	}
	
	public String save(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		auctionBulletin.setId(null);
		auctionBulletin.setCreateTime(new Date());
		auctionBulletin.setUpdateTime(new Date());
		auctionBulletin.setDeleteFlag("0");
		auctionBulletin.setCompanyId(company_id);
		
		iBulletinInfo.saveAuctionBulletin(auctionBulletin);
		return "saved";
	}
	
	public String edit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String bulletinFlag = ServletActionContext.getRequest().getParameter("bulletinFlag");
		if( bulletinFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		auctionBulletin = iBulletinInfo.getAuctionBulletin(bulletinFlag);
		if(auctionBulletin == null || ("1").equals(auctionBulletin.getDeleteFlag())
				|| !(company_id).equals(auctionBulletin.getCompanyId())){
			return "sessionDestory";
		}
		
		return "edit";
	}
	
	public String modify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		if(auctionBulletin == null || ("1").equals(auctionBulletin.getDeleteFlag())
				|| !(company_id).equals(auctionBulletin.getCompanyId())){
			return "sessionDestory";
		}
		auctionBulletin.setUpdateTime(new Date());
		
		iBulletinInfo.saveAuctionBulletin(auctionBulletin);
		return "saved";
	}
	
	public String delete(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String bulletinFlag = ServletActionContext.getRequest().getParameter("bulletinFlag");
		if( bulletinFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		auctionBulletin = iBulletinInfo.getAuctionBulletin(bulletinFlag);
		if(auctionBulletin == null || ("1").equals(auctionBulletin.getDeleteFlag())
				|| !(company_id).equals(auctionBulletin.getCompanyId())){
			return "sessionDestory";
		}
		
		auctionBulletin.setUpdateTime(new Date());
		auctionBulletin.setDeleteFlag("1");
		iBulletinInfo.saveAuctionBulletin(auctionBulletin);
		
		return "saved";
	}
	
	

	public void setiBulletinInfo(IBulletinInfoService iBulletinInfo) {
		this.iBulletinInfo = iBulletinInfo;
	}

	public AuctionBulletin getAuctionBulletin() {
		return auctionBulletin;
	}

	public void setAuctionBulletin(AuctionBulletin auctionBulletin) {
		this.auctionBulletin = auctionBulletin;
	}

	
	
	
	
}
