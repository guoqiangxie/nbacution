package com.useeasy.auction.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionInfoIndexDto;
import com.useeasy.auction.bean.ItemGoodsDto;
import com.useeasy.auction.bean.ItemMarginDto;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IItemGoodsService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;

@SuppressWarnings("serial")
public class CompanyPaymentAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
	
	private IAuctionInfoService iAuctionInfo;
	private IItemMarginService iItemMargin;
	private IItemGoodsService iItemGoods;
	
	private BasePage page;
	private String currentPage;
	
	private List<AuctionInfoIndexDto> auctionInfoByCompany_list;
	private List<ItemMarginDto> marginFinance_list;
	private List<ItemGoodsDto> goodsFinance_list;
	
	private AuctionInfo auctionInfo;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId() ;
		
		String url = ServletActionContext.getActionMapping().getName() + "?";
		
		long count = Long.valueOf(iAuctionInfo.getAuctionCount(company_id, ("1"), ("5"), ("2")));
		page = new BasePage(count, currentPage, url);
		auctionInfoByCompany_list = iAuctionInfo.getAuctionList(company_id, ("1"), ("5"), ("2"), page);
		
		return "index";
	}

	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "sessionDestory";
		}
			
		marginFinance_list = iItemMargin.getItemMarginInPayment(auctionFlag);
		goodsFinance_list = iItemGoods.getItemGoodsInPayment(auctionFlag);
		
		return "detail";
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

	public List<AuctionInfoIndexDto> getAuctionInfoByCompany_list() {
		return auctionInfoByCompany_list;
	}

	
	public AuctionInfo getAuctionInfo() {
		return auctionInfo;
	}

	public void setAuctionInfo(AuctionInfo auctionInfo) {
		this.auctionInfo = auctionInfo;
	}

	public void setiItemMargin(IItemMarginService iItemMargin) {
		this.iItemMargin = iItemMargin;
	}

	public void setiItemGoods(IItemGoodsService iItemGoods) {
		this.iItemGoods = iItemGoods;
	}

	public List<ItemMarginDto> getMarginFinance_list() {
		return marginFinance_list;
	}

	public List<ItemGoodsDto> getGoodsFinance_list() {
		return goodsFinance_list;
	}
	
}
