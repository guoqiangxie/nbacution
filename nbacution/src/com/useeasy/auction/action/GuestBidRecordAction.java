package com.useeasy.auction.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IBidRecordInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;


@SuppressWarnings("serial")
public class GuestBidRecordAction extends ActionSupport {

	static final Logger logger = LoggerFactory.getLogger(GuestBidRecordAction.class);
	
	private BasePage page;
	private String currentPage;
	
	private IBidRecordInfoService iBidRecordInfo;
	private IAuctionInfoService iAuctionInfo;
	private IApplicationService iApplication;
	private IItemInfoService iItemInfo;
	
	private List<Object> auction_list;
	private List<Object> item_list;
	private List<Object> price_list;
	
	public String auctionList(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iBidRecordInfo.getBidRecordCountInAuction(account_id));
		page = new BasePage(count, currentPage, url);
		auction_list = iBidRecordInfo.getBidRecordListInAuction(account_id, page);
		return "auctionList";
	}

	public String itemList(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| ("0").equals(auctionInfo.getAuctionStatus()) ){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "sessionDestory";
		}
		
		item_list = iBidRecordInfo.getBidRecordListInItem(account_id, auctionFlag);
		return "itemList";
	}
	
	public String priceList(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "sessionDestory";
		}
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if( itemInfo == null || ("1").equals(itemInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| ("0").equals(auctionInfo.getAuctionStatus()) ){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, itemInfo.getAuctionId());
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "sessionDestory";
		}
		
		price_list = iBidRecordInfo.getBidRecordListInPrice(account_id, itemFlag);
		
		return "priceList";
	}
	
	public List<Object> getItem_list() {
		return item_list;
	}

	public void setiBidRecordInfo(IBidRecordInfoService iBidRecordInfo) {
		this.iBidRecordInfo = iBidRecordInfo;
	}

	public List<Object> getAuction_list() {
		return auction_list;
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

	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}

	public List<Object> getPrice_list() {
		return price_list;
	}

	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}
	
	
}
