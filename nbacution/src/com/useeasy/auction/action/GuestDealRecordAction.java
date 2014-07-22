package com.useeasy.auction.action;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemGoods;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.PayRecordInfo;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IAuctionSettlementInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IDealRecordInfoService;
import com.useeasy.auction.service.IItemGoodsService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.auction.service.IPayRecordInfoService;
import com.useeasy.auction.util.ebank.PayBean;
import com.useeasy.auction.util.ebank.PayMent;
import com.useeasy.auction.util.ebank.PaySearchBean;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class GuestDealRecordAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(GuestDealRecordAction.class);
	
	private BasePage page;
	private String currentPage;
	
	private IDealRecordInfoService iDealRecordInfo;
	private IAuctionInfoService iAuctionInfo;
	private IApplicationService iApplication;
	private IItemMarginService iItemMargin;
	private IItemGoodsService iItemGoods;
	private ICompanyInfoService iCompanyInfo;
	private IPayRecordInfoService iPayRecordInfo;
	private IAuctionSettlementInfoService iAuctionSettlementInfo;
	
	private List<Object> auction_list;
	private List<Object> item_list;
	
	public String auctionList(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iDealRecordInfo.getDealRecordCountInAuction(account_id));
		page = new BasePage(count, currentPage, url);
		auction_list = iDealRecordInfo.getDealRecordListInAuction(account_id, page);
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
				|| !("2").equals(auctionInfo.getAuctionStatus()) ){
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
		
		List<PayRecordInfo> goodList = iPayRecordInfo.getCheckedPayRecordList("" + auctionInfo.getId(), account_id, "4");
		if (goodList != null && goodList.size() != 0){
			String goodOrders = "";
			for(int i = 0; i < goodList.size(); i++){
				PayRecordInfo payRecordInfo = (PayRecordInfo) goodList.get(i);
				goodOrders = goodOrders + payRecordInfo.getOrderId() + "|";
			}
			String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
			List<PaySearchBean> queryList = PayMent.batchorderquery(companyLiscence, goodOrders);
			for(int j = 0; j < queryList.size(); j++){
				PaySearchBean paySearchBean = (PaySearchBean)queryList.get(j);
				if(paySearchBean.getTranState().equals("1")){
					PayRecordInfo payRecordInfo = iPayRecordInfo.getPayRecordInfoByOrderId(paySearchBean.getOrder());
					payRecordInfo.setPayStatus("1");
					iPayRecordInfo.savePayRecordInfo(payRecordInfo);
					
					ItemGoods itemGoods = new ItemGoods();
					itemGoods.setId(null);
					itemGoods.setCreateTime(new Date());
					itemGoods.setAccountId(applicationInfo.getAccountId());
					itemGoods.setAuctionId(applicationInfo.getAuctionId());
					itemGoods.setCompanyId(applicationInfo.getCompanyId());
					itemGoods.setGoodsType("2");
					itemGoods.setGoodsVal(payRecordInfo.getPayMoney());
					itemGoods.setOrderId(payRecordInfo.getOrderId());
					iItemGoods.saveItemGoods(itemGoods);
				}else{  //否则都是未支付
					//AuctionPay pi = iPayInfo.getPayInfoByOrderId(paySearchBean.getOrder());
					//iPayInfo.deletePayInfo(pi);
				}
			}
		}
		
		item_list = iDealRecordInfo.getDealRecordListInItem(account_id, auctionFlag);
		double totalPrice = 0d;
		for(int i = 0; i < item_list.size(); i++){
			ItemInfo itemInfo = (ItemInfo)item_list.get(i);
			if(itemInfo.getCountValue() != null 
					&& Double.parseDouble(itemInfo.getCountValue()) > 0){
				totalPrice = totalPrice + Double.parseDouble(itemInfo.getCountValue());
			}
		}
		
		double payPrice = 0d;
		String aliveMargin = iItemMargin.getMarginVal(account_id, auctionFlag, "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",Tools.getMoneyFormat("" + aliveMargin));
		String webMargin = iItemMargin.getMarginVal(account_id, auctionFlag, "2");
		ServletActionContext.getRequest().setAttribute("webMargin",Tools.getMoneyFormat("" + webMargin));
		
		String aliveGoods = iItemGoods.getGoodsVal(account_id, auctionFlag, "1");
		ServletActionContext.getRequest().setAttribute("aliveGoods",Tools.getMoneyFormat("" + aliveGoods));
		String webGoods= iItemGoods.getGoodsVal(account_id, auctionFlag, "2");
		ServletActionContext.getRequest().setAttribute("webGoods",Tools.getMoneyFormat("" + webGoods));
		
		if("1".equals(auctionInfo.getAuctionWebPayGoods())){//允许抵扣
			payPrice = totalPrice - (Double.parseDouble(aliveMargin) + Double.parseDouble(webMargin))
						- (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}else {
			payPrice = totalPrice - (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}
		
		ServletActionContext.getRequest().setAttribute("totalPrice", Tools.getMoneyFormat("" + totalPrice));
		ServletActionContext.getRequest().setAttribute("payPrice", Tools.getMoneyFormat("" + payPrice));
		ServletActionContext.getRequest().setAttribute("isSettlement", iAuctionSettlementInfo.getIsSettlement(auctionFlag, account_id));
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		
		Calendar   cal=Calendar.getInstance();
		cal.setTime(new   Date());
		int year=cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		int hours = cal.get(Calendar.HOUR);
		int minutes = cal.get(Calendar.MINUTE); 
		int seconds = cal.get(Calendar.SECOND);
		
		String monthVal = ((month < 10) ? "0" : "") + month;
		String dayVal = ((day < 10) ? "0" : "") + day;
		String hoursVal = ((hours < 10) ? "0" : "") + hours;
		String minutesVal = ((minutes < 10) ? "0" : "") + minutes;
		String secondsVal = ((seconds < 10) ? "0" : "") + seconds; 
		
		String orderId = year + monthVal + dayVal + hoursVal + minutesVal + secondsVal;
		String orderDate = year + monthVal + dayVal;
		String orderTime = hoursVal + minutesVal + secondsVal;
		ServletActionContext.getRequest().setAttribute("orderId", orderId);
		ServletActionContext.getRequest().setAttribute("orderDate", orderDate);
		ServletActionContext.getRequest().setAttribute("orderTime", orderTime);
		
		return "itemList";
	}
	
	public String itemListPay(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus()) ){
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
		
		List<PayRecordInfo> goodList = iPayRecordInfo.getCheckedPayRecordList("" + auctionInfo.getId(), account_id, "4");
		if (goodList != null && goodList.size() != 0){
			String goodOrders = "";
			for(int i = 0; i < goodList.size(); i++){
				PayRecordInfo payRecordInfo = (PayRecordInfo) goodList.get(i);
				goodOrders = goodOrders + payRecordInfo.getOrderId() + "|";
			}
			String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
			List<PaySearchBean> queryList = PayMent.batchorderquery(companyLiscence, goodOrders);
			for(int j = 0; j < queryList.size(); j++){
				PaySearchBean paySearchBean = (PaySearchBean)queryList.get(j);
				if(paySearchBean.getTranState().equals("1")){
					PayRecordInfo payRecordInfo = iPayRecordInfo.getPayRecordInfoByOrderId(paySearchBean.getOrder());
					payRecordInfo.setPayStatus("1");
					iPayRecordInfo.savePayRecordInfo(payRecordInfo);
					
					ItemGoods itemGoods = new ItemGoods();
					itemGoods.setId(null);
					itemGoods.setCreateTime(new Date());
					itemGoods.setAccountId(applicationInfo.getAccountId());
					itemGoods.setAuctionId(applicationInfo.getAuctionId());
					itemGoods.setCompanyId(applicationInfo.getCompanyId());
					itemGoods.setGoodsType("2");
					itemGoods.setGoodsVal(payRecordInfo.getPayMoney());
					itemGoods.setOrderId(payRecordInfo.getOrderId());
					iItemGoods.saveItemGoods(itemGoods);
				}else{  //否则都是未支付
					//AuctionPay pi = iPayInfo.getPayInfoByOrderId(paySearchBean.getOrder());
					//iPayInfo.deletePayInfo(pi);
				}
			}
		}
		
		item_list = iDealRecordInfo.getDealRecordListInItem(account_id, auctionFlag);
		double totalPrice = 0d;
		for(int i = 0; i < item_list.size(); i++){
			ItemInfo itemInfo = (ItemInfo)item_list.get(i);
			if(itemInfo.getCountValue() != null 
					&& Double.parseDouble(itemInfo.getCountValue()) > 0){
				totalPrice = totalPrice + Double.parseDouble(itemInfo.getCountValue());
			}
		}
		
		double payPrice = 0d;
		String aliveMargin = iItemMargin.getMarginVal(account_id, auctionFlag, "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",Tools.getMoneyFormat("" + aliveMargin));
		String webMargin = iItemMargin.getMarginVal(account_id, auctionFlag, "2");
		ServletActionContext.getRequest().setAttribute("webMargin",Tools.getMoneyFormat("" + webMargin));
		
		String aliveGoods = iItemGoods.getGoodsVal(account_id, auctionFlag, "1");
		ServletActionContext.getRequest().setAttribute("aliveGoods",Tools.getMoneyFormat("" + aliveGoods));
		String webGoods= iItemGoods.getGoodsVal(account_id, auctionFlag, "2");
		ServletActionContext.getRequest().setAttribute("webGoods",Tools.getMoneyFormat("" + webGoods));
		
		if("1".equals(auctionInfo.getAuctionWebPayGoods())){//允许抵扣
			payPrice = totalPrice - (Double.parseDouble(aliveMargin) + Double.parseDouble(webMargin))
						- (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}else {
			payPrice = totalPrice - (Double.parseDouble(aliveGoods) + Double.parseDouble(webGoods));
		}
		
		ServletActionContext.getRequest().setAttribute("totalPrice", Tools.getMoneyFormat("" + totalPrice));
		ServletActionContext.getRequest().setAttribute("payPrice", Tools.getMoneyFormat("" + payPrice));
		ServletActionContext.getRequest().setAttribute("isSettlement", iAuctionSettlementInfo.getIsSettlement(auctionFlag, account_id));
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		
		Calendar   cal=Calendar.getInstance();
		cal.setTime(new   Date());
		int year=cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		int hours = cal.get(Calendar.HOUR);
		int minutes = cal.get(Calendar.MINUTE); 
		int seconds = cal.get(Calendar.SECOND);
		
		String monthVal = ((month < 10) ? "0" : "") + month;
		String dayVal = ((day < 10) ? "0" : "") + day;
		String hoursVal = ((hours < 10) ? "0" : "") + hours;
		String minutesVal = ((minutes < 10) ? "0" : "") + minutes;
		String secondsVal = ((seconds < 10) ? "0" : "") + seconds; 
		
		String orderId = year + monthVal + dayVal + hoursVal + minutesVal + secondsVal;
		String orderDate = year + monthVal + dayVal;
		String orderTime = hoursVal + minutesVal + secondsVal;
		ServletActionContext.getRequest().setAttribute("orderId", orderId);
		ServletActionContext.getRequest().setAttribute("orderDate", orderDate);
		ServletActionContext.getRequest().setAttribute("orderTime", orderTime);
		
		return "itemListPay";
	}
	
	public String doWebGoods(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		String orderId = ServletActionContext.getRequest().getParameter("orderId");
		String orderDate = ServletActionContext.getRequest().getParameter("orderDate");
		String orderTime = ServletActionContext.getRequest().getParameter("orderTime");
		if(orderId == null || orderDate == null || orderTime == null)
			return "sessionDestory";
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus()) ){
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
		
		String goodsVal = ServletActionContext.getRequest().getParameter("goodsVal");
		if(goodsVal == null || "-1".equals(goodsVal)){
			return "sessionDestory";
		}else{
			PayRecordInfo payRecordInfo = iPayRecordInfo.getPayRecordInfoByOrderId(orderId);
			if(payRecordInfo != null){//重复提交
				ServletActionContext.getRequest().setAttribute("auctionFlag", auctionInfo.getId());
				return "error";
			}
			String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
			
			PayBean payBean = new PayBean();
			payBean.setMerID(companyLiscence);
			payBean.setOrderid(orderId);
			payBean.setOrderDate(orderDate);
			payBean.setOrderTime(orderTime);
			//payBean.setAmount("2");
			payBean.setAmount(goodsVal);
			payBean.setOrderContent("");
			payBean.setOrderMono("");
			payBean.setNotifyType("0");
			payBean.setMerURL("");
			payBean.setGoodsURL(Constants.EBANK_RETURN_URL + ServletActionContext.getRequest().getContextPath() +"/guestDealRecord_itemList?auctionFlag=" + auctionInfo.getId());
			logger.info("urlrulrulrur_______________________" + payBean.getGoodsURL());
			payBean.setJumpSeconds("");
			payBean.setPayBatchNo("");
			payBean.setProxyMerName("");
			payBean.setProxyMerType("");
			payBean.setProxyMerCredentials("");
			
			String formUrl = PayMent.merchant(payBean);
			logger.info("url:____" + formUrl);
			
			payRecordInfo = new PayRecordInfo();
			payRecordInfo.setId(null);
			payRecordInfo.setCreateTime(new Date());
			payRecordInfo.setUpdateTime(new Date());
			payRecordInfo.setDeleteFlag("0");
			payRecordInfo.setAccountId(account_id);
			payRecordInfo.setAuctionId("" + auctionInfo.getId());
			payRecordInfo.setCompanyId(auctionInfo.getAuctionCompanyId());
			payRecordInfo.setOrderId(orderId);
			payRecordInfo.setOrderTime(new Date());
			payRecordInfo.setPayMoney(goodsVal);
			payRecordInfo.setMerchantId(companyLiscence);
			payRecordInfo.setPayStatus("0");
			payRecordInfo.setPayType("4");
			iPayRecordInfo.savePayRecordInfo(payRecordInfo);
			
			logger.info("订单号：________" + orderId);
			
			ServletActionContext.getRequest().setAttribute("formUrl", formUrl);
			ServletActionContext.getRequest().setAttribute("payBean", payBean);
			return "bankUrl";// 支付链接
		}
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

	public void setiDealRecordInfo(IDealRecordInfoService iDealRecordInfo) {
		this.iDealRecordInfo = iDealRecordInfo;
	}

	public List<Object> getAuction_list() {
		return auction_list;
	}

	public List<Object> getItem_list() {
		return item_list;
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
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

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiPayRecordInfo(IPayRecordInfoService iPayRecordInfo) {
		this.iPayRecordInfo = iPayRecordInfo;
	}

	public void setiAuctionSettlementInfo(
			IAuctionSettlementInfoService iAuctionSettlementInfo) {
		this.iAuctionSettlementInfo = iAuctionSettlementInfo;
	}
	
	
}
