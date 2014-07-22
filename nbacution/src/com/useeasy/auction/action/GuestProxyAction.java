package com.useeasy.auction.action;

import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemProxyPrice;
import com.useeasy.auction.dto.ProxyItemInfoDto;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IItemProxyPriceService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class GuestProxyAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(GuestProxyAction.class);
    
	private IApplicationService iApplication;
	private IAuctionInfoService iAuctionInfo;
	private IItemProxyPriceService iItemProxyPrice;
	private IItemInfoService iItemInfo;
	
	private BasePage page;
	private String currentPage;
	
	private List<ApplicationInfo> applyInfoProxy_list;
	private List<ProxyItemInfoDto> proxyItemInfoDto_list;
	
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String url = "";
		long count = 0;
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		if(searchType == null){
			return "error";
		}
		if(("1").equals(searchType)){
			url = ServletActionContext.getActionMapping().getName() + "?searchType=1&";
			count = Long.valueOf(iApplication.getApplicationCountInProxy(accountId, "1"));
			page = new BasePage(count, currentPage, url);
			applyInfoProxy_list = iApplication.getApplicationListInProxy(accountId, "1" ,page);
		}else if (("2").equals(searchType)){
			url = ServletActionContext.getActionMapping().getName() + "?searchType=2&";
			count = Long.valueOf(iApplication.getApplicationCountInProxy(accountId, "2"));
			page = new BasePage(count, currentPage, url);
			applyInfoProxy_list = iApplication.getApplicationListInProxy(accountId, "2" ,page);
		}else if(("3").equals(searchType)){
			url = ServletActionContext.getActionMapping().getName() + "?searchType=3&";
			count = Long.valueOf(iApplication.getApplicationCountInProxy(accountId, "3"));
			page = new BasePage(count, currentPage, url);
			applyInfoProxy_list = iApplication.getApplicationListInProxy(accountId, "3" ,page);
		}else{
			return "error";
		}
		
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
			return "error";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "error";
		}
		if(("0").equals(auctionInfo.getAuctionStatus())){
			return "error";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "error";
		}
		
		proxyItemInfoDto_list = iItemProxyPrice.getProxyItemInfoDtos(accountId, auctionFlag, "2");
		
		return "detail";
	}

	public String handle(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "error";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "error";
		}
		if(!("0").equals(auctionInfo.getAuctionStatus())){
			return "error";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag",auctionFlag);
		
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		if(searchType == null){
			return "error";
		}
		if(("1").equals(searchType)){
			proxyItemInfoDto_list = iItemProxyPrice.getProxyItemInfoDtos(accountId, auctionFlag, "1");
		}else if(("2").equals(searchType)){
			proxyItemInfoDto_list = iItemProxyPrice.getProxyItemInfoDtos(accountId, auctionFlag, "2");
		}else{
			return "error";
		}
		
		return "handle";
	}
	
	public String setProxy(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "error";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "error";
		}
		if(!("0").equals(auctionInfo.getAuctionStatus())){
			return "error";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "error";
		}
		
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !(applicationInfo.getAuctionId()).equals(itemInfo.getAuctionId())){
			return "error";
		}
		String proxyValue = ServletActionContext.getRequest().getParameter("proxyValue");
		if(proxyValue == null){
			return "error";
		}
		ItemProxyPrice itemProxyPrice = new ItemProxyPrice();
		itemProxyPrice.setId(null);
		itemProxyPrice.setCreateTime(new Date());
		itemProxyPrice.setAccountId(accountId);
		itemProxyPrice.setAuctionId(auctionFlag);
		itemProxyPrice.setCompanyId(auctionInfo.getAuctionCompanyId());
		itemProxyPrice.setItemId(itemFlag);
		itemProxyPrice.setProxyPrice(proxyValue);
		iItemProxyPrice.saveItemProxyPrice(itemProxyPrice);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag",auctionFlag);
		
		return "handled";
	}
	
	public String modifyProxy(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "error";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "error";
		}
		if(!("0").equals(auctionInfo.getAuctionStatus())){
			return "error";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "error";
		}
		
		String proxyPriceFlag = ServletActionContext.getRequest().getParameter("proxyPriceFlag");
		if(proxyPriceFlag == null){
			return "error";
		}
		String proxyValue = ServletActionContext.getRequest().getParameter("proxyValue");
		if(proxyValue == null){
			return "error";
		}
		
		ItemProxyPrice itemProxyPrice = iItemProxyPrice.getItemProxyPrice(proxyPriceFlag);
		itemProxyPrice.setProxyPrice(proxyValue);
		iItemProxyPrice.saveItemProxyPrice(itemProxyPrice);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag",auctionFlag);
		
		return "handled";
	}
	
	public String cancelProxy(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String accountId = "" + sessionContainer.getAuctionAccount().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null || !Tools.checkRegen("^[1-9][0-9]{0,6}$", auctionFlag)){
			return "error";
		}
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) ){
			return "error";
		}
		if(!("0").equals(auctionInfo.getAuctionStatus())){
			return "error";
		}
		
		ApplicationInfo applicationInfo = iApplication.getApplicationByAccountAndAuctionId(accountId, auctionFlag);
		if(applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag())
				|| !("2").equals(applicationInfo.getApplyStatus()) ){
			return "error";
		}
		
		String proxyPriceFlag = ServletActionContext.getRequest().getParameter("proxyPriceFlag");
		if(proxyPriceFlag == null){
			return "error";
		}
		ItemProxyPrice itemProxyPrice = iItemProxyPrice.getItemProxyPrice(proxyPriceFlag);
		iItemProxyPrice.removeItemProxyPrice(itemProxyPrice);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag",auctionFlag);
		
		return "handled";
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

	public List<ApplicationInfo> getApplyInfoProxy_list() {
		return applyInfoProxy_list;
	}

	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}

	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiItemProxyPrice(IItemProxyPriceService iItemProxyPrice) {
		this.iItemProxyPrice = iItemProxyPrice;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}

	public List<ProxyItemInfoDto> getProxyItemInfoDto_list() {
		return proxyItemInfoDto_list;
	}

	

	
}
