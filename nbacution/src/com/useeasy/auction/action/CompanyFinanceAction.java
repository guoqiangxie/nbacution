package com.useeasy.auction.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionSettlementInfo;
import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IAuctionSettlementInfoService;
import com.useeasy.auction.service.IDealRecordInfoService;
import com.useeasy.auction.service.IItemGoodsService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class CompanyFinanceAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(CompanyFinanceAction.class);
    
	private IAuctionInfoService iAuctionInfo;
	private IApplicationService iApplication;
	private IAuctionSettlementInfoService iAuctionSettlementInfo;
	private IItemMarginService iItemMargin;
	private IItemGoodsService iItemGoods;
	private IDealRecordInfoService iDealRecordInfo;
	
	//private List<ApplicationInfo> companyFinance_list;
	//private List<ItemMargin> marginFinance_list;
	//private List<ItemGoods> goodsFinance_list;
	private List<Object> item_list;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if( auctionFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
	
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		List<ApplicationInfo> companyFinance_list = iApplication.getApplicationListInCompanyFinance(auctionFlag);
		if(companyFinance_list == null || companyFinance_list.size() == 0){
			return "index";
		}
		ServletActionContext.getRequest().setAttribute("companyFinance_list", companyFinance_list);
		List<Object[]> finance_list = new ArrayList<Object[]>();
		for(int i = 0; i < companyFinance_list.size(); i++){
			ApplicationInfo applicationInfo = companyFinance_list.get(i);
			Object[] object = new Object[2];
			object[0] = iAuctionSettlementInfo.getIsSettlement(auctionFlag, applicationInfo.getAccountId());
			String margin_flag = "0";
			String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
			String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
			if(Double.parseDouble(aliveMargin) <= 0 && Double.parseDouble(webMargin) <= 0){  //未交baozhengjin
				margin_flag = "1";
			}
			object[1] = margin_flag;
			finance_list.add(object);
		} 
		ServletActionContext.getRequest().setAttribute("finance_list", finance_list);
		
		return "index";
	}

	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus())
				|| !(applicationInfo.getCompanyId()).equals(company_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("applicationInfo", applicationInfo);
		
		item_list = iDealRecordInfo.getDealRecordListInItem(applicationInfo.getAccountId(), applicationInfo.getAuctionId());
		double totalPrice = 0d;
		for(int i = 0; i < item_list.size(); i++){
			ItemInfo itemInfo = (ItemInfo)item_list.get(i);
			if(itemInfo.getCountValue() != null 
					&& Double.parseDouble(itemInfo.getCountValue()) > 0){
				totalPrice = totalPrice + Double.parseDouble(itemInfo.getCountValue());
			}
		}
		double payPrice = 0d;
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",Tools.getMoneyFormat("" + aliveMargin));
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",Tools.getMoneyFormat("" + webMargin));
		
		String aliveGoods = iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveGoods",Tools.getMoneyFormat("" + aliveGoods));
		String webGoods= iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webGoods",Tools.getMoneyFormat("" + webGoods));
		
		if("1".equals(auctionInfo.getAuctionWebPayGoods())){//允许抵扣
			payPrice = totalPrice - (Double.parseDouble(aliveMargin) + Double.parseDouble(webMargin))
						- (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}else {
			payPrice = totalPrice - (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}
		
		ServletActionContext.getRequest().setAttribute("totalPrice", Tools.getMoneyFormat("" + totalPrice));
		ServletActionContext.getRequest().setAttribute("payPrice", Tools.getMoneyFormat("" + payPrice));
		ServletActionContext.getRequest().setAttribute("isSettlement", iAuctionSettlementInfo.getIsSettlement(applicationInfo.getAuctionId(), applicationInfo.getAccountId()));
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		
		return "detail";
	}
	
	public String settlement(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus())
				|| !(applicationInfo.getCompanyId()).equals(company_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("applyFlag", applyFlag);
		
		int settlementFlag = iAuctionSettlementInfo.getIsSettlement(applicationInfo.getAuctionId(), applicationInfo.getAccountId());
		if(settlementFlag == 1){
			return "settlement";
		}
		
		item_list = iDealRecordInfo.getDealRecordListInItem(applicationInfo.getAccountId(), applicationInfo.getAuctionId());
		double totalPrice = 0d;
		for(int i = 0; i < item_list.size(); i++){
			ItemInfo itemInfo = (ItemInfo)item_list.get(i);
			if(itemInfo.getCountValue() != null 
					&& Double.parseDouble(itemInfo.getCountValue()) > 0){
				totalPrice = totalPrice + Double.parseDouble(itemInfo.getCountValue());
			}
		}
		double payPrice = 0d;
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",Tools.getMoneyFormat("" + aliveMargin));
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",Tools.getMoneyFormat("" + webMargin));
		
		String aliveGoods = iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveGoods",Tools.getMoneyFormat("" + aliveGoods));
		String webGoods= iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webGoods",Tools.getMoneyFormat("" + webGoods));
		
		if("1".equals(auctionInfo.getAuctionWebPayGoods())){//允许抵扣
			payPrice = totalPrice - (Double.parseDouble(aliveMargin) + Double.parseDouble(webMargin))
						- (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}else {
			payPrice = totalPrice - (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}
		
		if(payPrice > 0){
			ItemGoods itemGoods = new ItemGoods();
			itemGoods.setId(null);
			itemGoods.setCreateTime(new Date());
			itemGoods.setAccountId(applicationInfo.getAccountId());
			itemGoods.setAuctionId(applicationInfo.getAuctionId());
			itemGoods.setCompanyId(applicationInfo.getCompanyId());
			itemGoods.setGoodsType("1");
			itemGoods.setGoodsVal("" + payPrice);
			iItemGoods.saveItemGoods(itemGoods);
		}
		
		AuctionSettlementInfo auctionSettlementInfo = new AuctionSettlementInfo();
		auctionSettlementInfo.setId(null);
		auctionSettlementInfo.setCreateTime(new Date());
		auctionSettlementInfo.setSettlementFlag("1");
		auctionSettlementInfo.setAccountId(applicationInfo.getAccountId());
		auctionSettlementInfo.setAuctionId(applicationInfo.getAuctionId());
		auctionSettlementInfo.setAuctionCompanyId(applicationInfo.getCompanyId());
		iAuctionSettlementInfo.saveSettlement(auctionSettlementInfo);
		
		return "settlement";
	}
	
	public String marginBack(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus())
				|| !(applicationInfo.getCompanyId()).equals(company_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("applicationInfo", applicationInfo);
		
		item_list = iDealRecordInfo.getDealRecordListInItem(applicationInfo.getAccountId(), applicationInfo.getAuctionId());
		double totalPrice = 0d;
		for(int i = 0; i < item_list.size(); i++){
			ItemInfo itemInfo = (ItemInfo)item_list.get(i);
			if(itemInfo.getCountValue() != null 
					&& Double.parseDouble(itemInfo.getCountValue()) > 0){
				totalPrice = totalPrice + Double.parseDouble(itemInfo.getCountValue());
			}
		}
		double payPrice = 0d;
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",Tools.getMoneyFormat("" + aliveMargin));
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",Tools.getMoneyFormat("" + webMargin));
		String backMargin= iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "3");
		ServletActionContext.getRequest().setAttribute("backMargin",Tools.getMoneyFormat("" + backMargin));
		
		String aliveGoods = iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveGoods",Tools.getMoneyFormat("" + aliveGoods));
		String webGoods= iItemGoods.getGoodsVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webGoods",Tools.getMoneyFormat("" + webGoods));
		
		if("1".equals(auctionInfo.getAuctionWebPayGoods())){//允许抵扣
			payPrice = totalPrice - (Double.parseDouble(aliveMargin) + Double.parseDouble(webMargin))
						- (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}else {
			payPrice = totalPrice - (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}
		
		ServletActionContext.getRequest().setAttribute("totalPrice", Tools.getMoneyFormat("" + totalPrice));
		ServletActionContext.getRequest().setAttribute("payPrice", Tools.getMoneyFormat("" + payPrice));
		ServletActionContext.getRequest().setAttribute("isSettlement", iAuctionSettlementInfo.getIsSettlement(applicationInfo.getAuctionId(), applicationInfo.getAccountId()));
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		
		return "marginBack";
	}
	
	public String marginDoBack(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		String backMargin = ServletActionContext.getRequest().getParameter("marginVal");
		if(applyFlag == null || backMargin == null){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus())
				|| !(applicationInfo.getCompanyId()).equals(company_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("applyFlag", applyFlag);
		
		ItemMargin itemMargin = new ItemMargin();
		itemMargin.setId(null);
		itemMargin.setCreateTime(new Date());
		itemMargin.setAccountId(applicationInfo.getAccountId());
		itemMargin.setAuctionId(applicationInfo.getAuctionId());
		itemMargin.setCompanyId(applicationInfo.getCompanyId());
		itemMargin.setMarginType("3");
		itemMargin.setMarginVal(backMargin);
		iItemMargin.saveItemMargin(itemMargin);
		
		return "marginBacked";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	


	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}


	public void setiAuctionSettlementInfo(
			IAuctionSettlementInfoService iAuctionSettlementInfo) {
		this.iAuctionSettlementInfo = iAuctionSettlementInfo;
	}

	

	public void setiItemMargin(IItemMarginService iItemMargin) {
		this.iItemMargin = iItemMargin;
	}

	public void setiItemGoods(IItemGoodsService iItemGoods) {
		this.iItemGoods = iItemGoods;
	}

	public void setiDealRecordInfo(IDealRecordInfoService iDealRecordInfo) {
		this.iDealRecordInfo = iDealRecordInfo;
	}

	public List<Object> getItem_list() {
		return item_list;
	}

	

}
