package com.useeasy.auction.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IItemGoodsService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class GuestFinanceAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(GuestFinanceAction.class);
    
	private IApplicationService iApplication;
	private IAuctionInfoService iAuctionInfo;
	private IItemMarginService iItemMargin;
	private IItemGoodsService iItemGoods;
	
	private BasePage page;
	private String currentPage;
	
	private List<ApplicationInfo> applyInfoFinance_list;
	private List<ItemMargin> marginFinance_list;
	private List<ItemGoods> goodsFinance_list;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iApplication.getApplicationCountInFinance(accountId, null));
		page = new BasePage(count, currentPage, url);
		applyInfoFinance_list = iApplication.getApplicationListInFinance(accountId, null ,page);
	
		return "index";
	}

	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| ("0").equals(applicationInfo.getApplyStatus()) ){
			return "sessionDestory";
		}
		
		marginFinance_list = iItemMargin.getItemMarginInFinance(accountId, auctionFlag);
		goodsFinance_list = iItemGoods.getItemGoodsInFinance(accountId, auctionFlag);
		
		return "detail";
	}
	
	public String payDetail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| ("0").equals(applicationInfo.getApplyStatus()) ){
			return "sessionDestory";
		}
		
		marginFinance_list = iItemMargin.getItemMarginInFinance(accountId, auctionFlag);
		goodsFinance_list = iItemGoods.getItemGoodsInFinance(accountId, auctionFlag);
		
		return "payDetail";
	}
	
	public List<ApplicationInfo> getApplyInfoFinance_list() {
		return applyInfoFinance_list;
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public String getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}

	public BasePage getPage() {
		return page;
	}

	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}

	public void setiItemMargin(IItemMarginService iItemMargin) {
		this.iItemMargin = iItemMargin;
	}

	public void setiItemGoods(IItemGoodsService iItemGoods) {
		this.iItemGoods = iItemGoods;
	}

	public List<ItemMargin> getMarginFinance_list() {
		return marginFinance_list;
	}

	public List<ItemGoods> getGoodsFinance_list() {
		return goodsFinance_list;
	}
	
}
