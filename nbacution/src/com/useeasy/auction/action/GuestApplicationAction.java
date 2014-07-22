package com.useeasy.auction.action;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.bean.PayRecordInfo;
import com.useeasy.auction.dto.ProxyItemInfoDto;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.auction.service.IItemProxyPriceService;
import com.useeasy.auction.service.IPayRecordInfoService;
import com.useeasy.auction.service.IQulificationService;
import com.useeasy.auction.util.ebank.PayBean;
import com.useeasy.auction.util.ebank.PayMent;
import com.useeasy.auction.util.ebank.PaySearchBean;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;


@SuppressWarnings("serial")
public class GuestApplicationAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(GuestApplicationAction.class);
	
	private BasePage page;
	private String currentPage;
	
	private IAuctionInfoService iAuctionInfo;
	private IApplicationService iApplication;
	private IQulificationService iQulification;
	private IItemMarginService iItemMargin;
	private IItemProxyPriceService iItemProxyPrice;
	private ICompanyInfoService iCompanyInfo;
	private IPayRecordInfoService iPayRecordInfo;
	
	private List<ApplicationInfo> applyInfo_list;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		String searchType = "1";
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iApplication.getApplicationCount(account_id, searchType));
		page = new BasePage(count, currentPage, url);
		applyInfo_list = iApplication.getApplicationList(account_id, searchType ,page);
		return "index";
	}
	
	public String showApply(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !(applicationInfo.getAccountId()).equals(account_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		List<PayRecordInfo> marginList = iPayRecordInfo.getCheckedPayRecordList("" + auctionInfo.getId(), account_id, "2");
		if (marginList != null && marginList.size() != 0){
			String marginOrders = "";
			for(int i = 0; i < marginList.size(); i++){
				PayRecordInfo payRecordInfo = (PayRecordInfo) marginList.get(i);
				marginOrders = marginOrders + payRecordInfo.getOrderId() + "|";
			}
			String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
			List<PaySearchBean> queryList = PayMent.batchorderquery(companyLiscence, marginOrders);
			for(int j = 0; j < queryList.size(); j++){
				PaySearchBean paySearchBean = (PaySearchBean)queryList.get(j);
				if(paySearchBean.getTranState().equals("1")){
					PayRecordInfo payRecordInfo = iPayRecordInfo.getPayRecordInfoByOrderId(paySearchBean.getOrder());
					payRecordInfo.setPayStatus("1");
					iPayRecordInfo.savePayRecordInfo(payRecordInfo);
					
					ItemMargin itemMargin = new ItemMargin();
					itemMargin.setId(null);
					itemMargin.setCreateTime(new Date());
					itemMargin.setAccountId(applicationInfo.getAccountId());
					itemMargin.setAuctionId(applicationInfo.getAuctionId());
					itemMargin.setCompanyId(applicationInfo.getCompanyId());
					itemMargin.setMarginType("2");
					itemMargin.setMarginVal(payRecordInfo.getPayMoney());
					itemMargin.setOrderId(payRecordInfo.getOrderId());
					iItemMargin.saveItemMargin(itemMargin);
					
					if("2".equals(auctionInfo.getAuctionWebPayCheck()) 
							&& !"2".equals(applicationInfo.getApplyStatus())){  //不审核网络支付
						applicationInfo.setCheckTime(new Date());
						applicationInfo.setBidNum(auctionInfo.getAutoBidNum());
						applicationInfo.setTeamAuthority("0");
						applicationInfo.setApplyStatus("2");
						String guestNum = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + RandomStringUtils.random(6, true, true);
						applicationInfo.setGuestNumFlag(guestNum);
						iApplication.saveApplication(applicationInfo);
						
						auctionInfo.setAutoBidNum("" + (Long.parseLong(auctionInfo.getAutoBidNum())+1));
						iAuctionInfo.saveAuctionInfo(auctionInfo);
					}
				}else{  //否则都是未支付
					//AuctionPay pi = iPayInfo.getPayInfoByOrderId(paySearchBean.getOrder());
					//iPayInfo.deletePayInfo(pi);
				}
			}
		}
		
		ServletActionContext.getRequest().setAttribute("userName", 
				sessionContainer.getAuctionGuest().getGuestName());
		ServletActionContext.getRequest().setAttribute("auctionName", 
				auctionInfo.getAuctionName());
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",aliveMargin);
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
		
		ServletActionContext.getRequest().setAttribute("auctionInfo_flag",auctionInfo);
		ServletActionContext.getRequest().setAttribute("applyInfo_flag",applicationInfo);
		
		ServletActionContext.getRequest().setAttribute("accountFlag", applicationInfo.getAccountId());
		ServletActionContext.getRequest().setAttribute("auctionFlag", applicationInfo.getAuctionId());
		ServletActionContext.getRequest().setAttribute("companyFlag", applicationInfo.getCompanyId());
		
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
		
		return "showApply";
	}
	
	public String checkApply(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String accountFlag = ServletActionContext.getRequest().getParameter("accountFlag");
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(accountFlag == null || auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		if(sessionContainer == null || sessionContainer.getAuctionAccount() == null
				|| !("" + sessionContainer.getAuctionAccount().getId()).equals(accountFlag)){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		if(("2").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");
			return "checkApply";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountFlag, auctionFlag);
		if(applicationInfo != null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "0");
		}
		return "checkApply";
	}
	
	public String apply(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		/*ServletActionContext.getRequest().setAttribute("submitFlag", 
				Tools.dateToString(new Date(), "yyyyMMddhhmmss") + RandomStringUtils.random(6, true, true));*/
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
	
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		if(("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, auctionFlag);
		if(applicationInfo != null){
			return "applyed";
		}
		
		String webPayCheck = "1";  //可以支付
		if( ("1").equals(auctionInfo.getAuctionStatus()) 
				|| ("2").equals(auctionInfo.getAuctionWebPay()) 
				|| !iQulification.checkQulification(account_id) ){
			webPayCheck = "0";
		}else {
			ServletActionContext.getRequest().setAttribute("auctionMarginMax", 
					auctionInfo.getAuctionMarginMax());
			ServletActionContext.getRequest().setAttribute("auctionMarginLevelFir", 
					auctionInfo.getAuctionMarginLevelFir());
			ServletActionContext.getRequest().setAttribute("auctionMarginLevelSec", 
					auctionInfo.getAuctionMarginLevelSec());
			ServletActionContext.getRequest().setAttribute("auctionMarginLevelThi", 
					auctionInfo.getAuctionMarginLevelThi());
			
			String webMargin = iItemMargin.getMarginVal(account_id, auctionFlag, "2");
			ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
			
		}
		
		ServletActionContext.getRequest().setAttribute("userName", 
				sessionContainer.getAuctionGuest().getGuestName());
		ServletActionContext.getRequest().setAttribute("auctionName", 
				auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("webPayCheck", webPayCheck);
		ServletActionContext.getRequest().setAttribute("accountFlag", account_id);
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "apply";
	}
	
	public String doApply(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		//String submitFlag = ServletActionContext.getRequest().getParameter("submitFlag");
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();

	
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		if(("2").equals(auctionInfo.getAuctionStatus())){
			return "applyed";
		}
		
		
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, auctionFlag);
		if(applicationInfo != null){
			return "applyed";
		}else{
			String applyContent = ServletActionContext.getRequest().getParameter("applyContent");
			applicationInfo = new ApplicationInfo();
			
			applicationInfo.setId(null);
			applicationInfo.setCreateTime(new Date());
			applicationInfo.setUpdateTime(new Date());
			applicationInfo.setDeleteFlag("0");
			applicationInfo.setAccountId(account_id);
			applicationInfo.setAuctionId(auctionFlag);
			applicationInfo.setApplyContent(applyContent);
			applicationInfo.setCompanyId(auctionInfo.getAuctionCompanyId());
			
			if(!iQulification.checkQulification(account_id)){  //未验证
				applicationInfo.setApplyStatus("0");
				iApplication.saveApplication(applicationInfo);
				return "applyed";
			}else{
				applicationInfo.setApplyStatus("1");
				iApplication.saveApplication(applicationInfo);
			}
			
			String marginFlag = ServletActionContext.getRequest().getParameter("margin_radio");
			if("2".equals(marginFlag)){  //alive_pay
				return "applyed";
			}else{
				String marginVal = ServletActionContext.getRequest().getParameter("margin_val");
				if(marginVal == null || "-1".equals(marginVal) 
						|| ("1").equals(auctionInfo.getAuctionStatus()) ){
					return "applyed";
				}else{
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
					String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
					
					PayBean payBean = new PayBean();
					payBean.setMerID(companyLiscence);
					payBean.setOrderid(orderId);
					payBean.setOrderDate(orderDate);
					payBean.setOrderTime(orderTime);
					//payBean.setAmount("1");
					payBean.setAmount(marginVal);
					payBean.setOrderContent("");
					payBean.setOrderMono("");
					payBean.setNotifyType("0");
					payBean.setMerURL("");
					payBean.setGoodsURL(Constants.EBANK_RETURN_URL + ServletActionContext.getRequest().getContextPath() +"/guestApplication_showApply?applyFlag=" + applicationInfo.getId());
					logger.info("urlrulrulrur_______________________" + payBean.getGoodsURL());
					payBean.setJumpSeconds("");
					payBean.setPayBatchNo("");
					payBean.setProxyMerName("");
					payBean.setProxyMerType("");
					payBean.setProxyMerCredentials("");
					
					String formUrl = PayMent.merchant(payBean);
					logger.info("url:____" + formUrl);
					
					PayRecordInfo payRecordInfo = new PayRecordInfo();
					payRecordInfo.setId(null);
					payRecordInfo.setCreateTime(new Date());
					payRecordInfo.setUpdateTime(new Date());
					payRecordInfo.setDeleteFlag("0");
					payRecordInfo.setAccountId(account_id);
					payRecordInfo.setAuctionId("" + auctionInfo.getId());
					payRecordInfo.setCompanyId(auctionInfo.getAuctionCompanyId());
					payRecordInfo.setOrderId(orderId);
					payRecordInfo.setOrderTime(new Date());
					payRecordInfo.setPayMoney(marginVal);
					payRecordInfo.setMerchantId(companyLiscence);
					payRecordInfo.setPayStatus("0");
					payRecordInfo.setPayType("2");
					iPayRecordInfo.savePayRecordInfo(payRecordInfo);
					
					logger.info("订单号：________" + orderId);
					
					ServletActionContext.getRequest().setAttribute("formUrl", formUrl);
					ServletActionContext.getRequest().setAttribute("payBean", payBean);
					return "bankUrl";// 支付链接
				}
			}
		}
		
	}
	
	public String checkMarginPay(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, auctionFlag);
		if(applicationInfo == null){
			//return "applyed";
		}else{
			
		}
		return "applyed";
	}
	
	public String cancelApply(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null)
			return "sessionDestory";
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !(applicationInfo.getAccountId()).equals(account_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		if(("2").equals(auctionInfo.getAuctionStatus()) 
				|| ("2").equals(applicationInfo.getApplyStatus()) ){
			return "applyed";
		}
		
		applicationInfo.setDeleteFlag("1");
		iApplication.saveApplication(applicationInfo);
		
		return "applyed";
	}
	
	public String doWebMargin(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null)
			return "sessionDestory";
		String orderId = ServletActionContext.getRequest().getParameter("orderId");
		String orderDate = ServletActionContext.getRequest().getParameter("orderDate");
		String orderTime = ServletActionContext.getRequest().getParameter("orderTime");
		if(orderId == null || orderDate == null || orderTime == null)
			return "sessionDestory";
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
	
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !(applicationInfo.getAccountId()).equals(account_id) ){
			return "sessionDestory";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "sessionDestory";
		}
		
		if(!("0").equals(auctionInfo.getAuctionStatus()) 
				|| ("0").equals(applicationInfo.getApplyStatus()) 
				||  ("2").equals(auctionInfo.getAuctionWebPay()) ){
			return "applyed";
		}
		
		String marginVal = ServletActionContext.getRequest().getParameter("marginVal");
		if(marginVal == null || "-1".equals(marginVal)){
			return "applyed";
		}else{
			PayRecordInfo payRecordInfo = iPayRecordInfo.getPayRecordInfoByOrderId(orderId);
			if(payRecordInfo != null){//重复提交
				ServletActionContext.getRequest().setAttribute("applyFlag", applicationInfo.getId());
				return "error";
			}
			String companyLiscence = iCompanyInfo.getCompanyInfo(auctionInfo.getAuctionCompanyId()).getCompanyLicense();
			
			PayBean payBean = new PayBean();
			payBean.setMerID(companyLiscence);
			payBean.setOrderid(orderId);
			payBean.setOrderDate(orderDate);
			payBean.setOrderTime(orderTime);
			//payBean.setAmount("1");
			payBean.setAmount(marginVal);
			payBean.setOrderContent("");
			payBean.setOrderMono("");
			payBean.setNotifyType("0");
			payBean.setMerURL("");
			payBean.setGoodsURL(Constants.EBANK_RETURN_URL + ServletActionContext.getRequest().getContextPath() +"/guestApplication_showApply?applyFlag=" + applicationInfo.getId());
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
			payRecordInfo.setPayMoney(marginVal);
			payRecordInfo.setMerchantId(companyLiscence);
			payRecordInfo.setPayStatus("0");
			payRecordInfo.setPayType("2");
			iPayRecordInfo.savePayRecordInfo(payRecordInfo);
			
			logger.info("订单号：________" + orderId);
			
			ServletActionContext.getRequest().setAttribute("formUrl", formUrl);
			ServletActionContext.getRequest().setAttribute("payBean", payBean);
			return "bankUrl";// 支付链接
		}
	}
	
	public String checkCustomer(){
		/*String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkCustomer";
		}*/
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkCustomer";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkCustomer";
		}
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String account_id = "" + sessionContainer.getAuctionAccount().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(account_id, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkCustomer";
		}
		
		if(("0").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "1");
		}else if(("1").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "2");
		}else {
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
		}
		return "checkCustomer";
	}
	
	public String customerWait(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) 
				){
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
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		
		return "customerWait";
	}
	
	public String checkAuction(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  //不匹配
			return "checkAuction";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) 
				){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "checkAuction";
		}
		
		if(("1").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  //匹配
			ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		}else {
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
		}
		return "checkAuction";
	}
	
	public String customer(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if( auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) 
				){
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
		
		if(("0").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
			return "customerWait";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("userId", account_id);
		ServletActionContext.getRequest().setAttribute("applyNum", applicationInfo.getGuestNumFlag());
		ServletActionContext.getRequest().setAttribute("xmlNum", auctionInfo.getXmlNumFlag());
		ServletActionContext.getRequest().setAttribute("auctionName", auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("videoNum", auctionInfo.getAuctionNum());
		ServletActionContext.getRequest().setAttribute("userName", sessionContainer.getAuctionGuest().getGuestName());
		ServletActionContext.getRequest().setAttribute("marginVal", iItemMargin.getMarginValPayed(account_id, auctionFlag));
		String proxyVal = "";
		List<ProxyItemInfoDto> list = iItemProxyPrice.getProxyItemInfoDtos(account_id, auctionFlag, "1");
		if(list == null || list.size() == 0){
			proxyVal = "-1#";
		}else {
			for(int i = 0; i < list.size(); i++){
				if(list.get(i).getProxyPrice() == null || ("").equals(list.get(i).getProxyPrice())){
					proxyVal = proxyVal + "-1#";
				}else{
					proxyVal = proxyVal + list.get(i).getProxyPrice() + "#";
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("proxyVal", proxyVal );
		return "customer";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}

	public void setiQulification(IQulificationService iQulification) {
		this.iQulification = iQulification;
	}

	public void setiItemMargin(IItemMarginService iItemMargin) {
		this.iItemMargin = iItemMargin;
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

	public List<ApplicationInfo> getApplyInfo_list() {
		return applyInfo_list;
	}

	public void setiItemProxyPrice(IItemProxyPriceService iItemProxyPrice) {
		this.iItemProxyPrice = iItemProxyPrice;
	}

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiPayRecordInfo(IPayRecordInfoService iPayRecordInfo) {
		this.iPayRecordInfo = iPayRecordInfo;
	}
	
	

}
