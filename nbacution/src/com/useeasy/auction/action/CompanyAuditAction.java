package com.useeasy.auction.action;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.ApplicationInfo;
import com.useeasy.auction.bean.AuctionGuest;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionTeamType;
import com.useeasy.auction.bean.ItemMargin;
import com.useeasy.auction.bean.ItemProxyPrice;
import com.useeasy.auction.bean.QulificationInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dto.ProxyItemInfoDto;
import com.useeasy.auction.service.IApplicationService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IAuctionTeamTypeService;
import com.useeasy.auction.service.IGuestInfoService;
import com.useeasy.auction.service.IItemMarginService;
import com.useeasy.auction.service.IItemProxyPriceService;
import com.useeasy.auction.service.IQulificationService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class CompanyAuditAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(CompanyAuditAction.class);
	
	private IAuctionInfoService iAuctionInfo;
	private IApplicationService iApplication;
	private IQulificationService iQulification;
	private IGuestInfoService iGuestInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAuctionTeamTypeService iAuctionTeamType;
	private IItemMarginService iItemMargin;
	private IItemProxyPriceService iItemProxyPrice;
	
	private List<ApplicationInfo> applyInfo_list;
	private List<AuctionTeamType> auctionTeamType_list;
	
	private AuctionGuest auctionGuest;
	
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
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
										
		applyInfo_list = iApplication.getApplicationListByCompanyAndAuctionId(company_id, 
				("" + auctionInfo.getId()));
		
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		ServletActionContext.getRequest().setAttribute("auctionStatus", auctionInfo.getAuctionStatus());
		
		return "index";
	}
	
	public String check(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("0").equals(applicationInfo.getApplyStatus())){
			return "checked";
		}
		if(iQulification.checkQulification(applicationInfo.getAccountId())){
			applicationInfo.setApplyStatus("1");
			iApplication.saveApplication(applicationInfo);
			return "checked";
		}
		
		auctionGuest = iGuestInfo.getGuestInfo(applicationInfo.getGuestId());
		
		//ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		ServletActionContext.getRequest().setAttribute("applyFlag",applyFlag);
		ServletActionContext.getRequest().setAttribute("accountName", applicationInfo.getAccountName());
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(applicationInfo.getGuestId(), "3");
		if(uploadImgInfo != null)
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		
		return "check";
	}
	
	public String doCheck(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if(applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("0").equals(applicationInfo.getApplyStatus())){
			return "checked";
		}
		if(iQulification.checkQulification(applicationInfo.getAccountId())){
			applicationInfo.setApplyStatus("1");
			iApplication.saveApplication(applicationInfo);
			return "checked";
		}
		
		String customPicVal = ServletActionContext.getRequest().getParameter("customPicVal");
		if(!"".equals(customPicVal)){
			UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo(customPicVal);
			if(uploadImgInfo != null){
				uploadImgInfo.setRelationId("" + auctionGuest.getId());
				iUploadImgInfo.saveUploadImgInfo(uploadImgInfo);
			}
		}
		
		QulificationInfo qulificationInfo = new QulificationInfo();
		qulificationInfo.setId(null);
		qulificationInfo.setAccountId(applicationInfo.getAccountId());
		qulificationInfo.setQualifyCompany(company_id);
		iQulification.saveQulification(qulificationInfo);
		
		applicationInfo.setApplyStatus("1");
		iApplication.saveApplication(applicationInfo);
		return "checked";
	}
	
	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(("0").equals(applicationInfo.getApplyStatus()) 
				|| !("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		auctionGuest = iGuestInfo.getGuestInfo(applicationInfo.getGuestId());
		
		ServletActionContext.getRequest().setAttribute("applyFlag",applyFlag);
		ServletActionContext.getRequest().setAttribute("accountName", applicationInfo.getAccountName());
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(applicationInfo.getGuestId(), "3");
		if(uploadImgInfo != null)
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		
		auctionTeamType_list = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",aliveMargin);
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
		
		ServletActionContext.getRequest().setAttribute("bidNum",applicationInfo.getBidNum());
		if(applicationInfo.getTeamAuthority() == null){
			ServletActionContext.getRequest().setAttribute("teamAuthority","");
		}else{
			String[] teamFlag = applicationInfo.getTeamAuthority().split(",");
			ServletActionContext.getRequest().setAttribute("teamAuthority",teamFlag);
		}
		
		ServletActionContext.getRequest().setAttribute("applyContent",applicationInfo.getApplyContent());
		ServletActionContext.getRequest().setAttribute("auctionStatus", auctionInfo.getAuctionStatus());
		
		return "detail";
	}
	
	public String authority(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("1").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		/*if(iQulification.checkQulification(applicationInfo.getAccountId())){
			applicationInfo.setApplyStatus("1");
			iApplication.saveApplication(applicationInfo);
			return "checked";
		}*/
		
		auctionGuest = iGuestInfo.getGuestInfo(applicationInfo.getGuestId());
		
		ServletActionContext.getRequest().setAttribute("applyFlag",applyFlag);
		ServletActionContext.getRequest().setAttribute("accountName", applicationInfo.getAccountName());
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(applicationInfo.getGuestId(), "3");
		if(uploadImgInfo != null)
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		
		auctionTeamType_list = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
		
		ServletActionContext.getRequest().setAttribute("applyContent",applicationInfo.getApplyContent());
		ServletActionContext.getRequest().setAttribute("auctionStatus", auctionInfo.getAuctionStatus());
		
		return "authority";
	}
	
	public String doAuthority(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if( !("1").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		String bidNumFlag = ServletActionContext.getRequest().getParameter("bidNum");
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String marginFlag = ServletActionContext.getRequest().getParameter("margin");
		
		if(bidNumFlag == null || ("").equals(bidNumFlag)){
			return "checked";
		}else{
			applicationInfo.setBidNum(bidNumFlag);
		}
		if(boxesFlag == null || ("").equals(boxesFlag)){
			applicationInfo.setTeamAuthority("0");
		}else{
			applicationInfo.setTeamAuthority("0," + boxesFlag);
		
		}
		applicationInfo.setCheckTime(new Date());
		applicationInfo.setApplyStatus("2");
		String guestNum = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + RandomStringUtils.random(6, true, true);
		applicationInfo.setGuestNumFlag(guestNum);
		iApplication.saveApplication(applicationInfo);
		
		if(marginFlag == null || ("0").equals(marginFlag)){
		}
		else{
			ItemMargin itemMargin = new ItemMargin();
			itemMargin.setId(null);
			itemMargin.setCreateTime(new Date());
			itemMargin.setAccountId(applicationInfo.getAccountId());
			itemMargin.setAuctionId(applicationInfo.getAuctionId());
			itemMargin.setCompanyId(applicationInfo.getCompanyId());
			itemMargin.setMarginType("1");
			itemMargin.setMarginVal(marginFlag);
			iItemMargin.saveItemMargin(itemMargin);
		}
		return "checked";
	}
	
	public String reAuthority(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("2").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		auctionGuest = iGuestInfo.getGuestInfo(applicationInfo.getGuestId());
		
		ServletActionContext.getRequest().setAttribute("applyFlag",applyFlag);
		ServletActionContext.getRequest().setAttribute("accountName", applicationInfo.getAccountName());
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(applicationInfo.getGuestId(), "3");
		if(uploadImgInfo != null)
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		
		ServletActionContext.getRequest().setAttribute("applyContent",applicationInfo.getApplyContent());
		
		auctionTeamType_list = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",aliveMargin);
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
		
		ServletActionContext.getRequest().setAttribute("bidNum",applicationInfo.getBidNum());
		if(applicationInfo.getTeamAuthority() == null){
			ServletActionContext.getRequest().setAttribute("teamAuthority","");
		}else{
			String[] teamFlag = applicationInfo.getTeamAuthority().split(",");
			ServletActionContext.getRequest().setAttribute("teamAuthority",teamFlag);
		}
		
		ServletActionContext.getRequest().setAttribute("auctionStatus", auctionInfo.getAuctionStatus());
		
		return "reAuthority";
		
	}
	
	public String doReAuthority(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("2").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		applicationInfo.setBidNum(null);
		applicationInfo.setTeamAuthority(null);
		applicationInfo.setCheckTime(null);
		applicationInfo.setApplyStatus("1");
		applicationInfo.setGuestNumFlag(null);
		iApplication.saveApplication(applicationInfo);
		
		List<ItemMargin> list = iItemMargin.getItemMargin(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		if(list != null && list.size() != 0){
			for(int i = 0; i < list.size(); i++){
				ItemMargin itemMargin = list.get(i);
				iItemMargin.removeItemMargin(itemMargin);
			}
		}
		//.....
		List<ProxyItemInfoDto> proxyList =  iItemProxyPrice.getProxyItemInfoDtos(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		if(proxyList != null && proxyList.size() != 0){
			for(int i = 0; i < proxyList.size(); i++){
				ProxyItemInfoDto proxyItemInfoDto = proxyList.get(i);
				ItemProxyPrice itemProxyPrice = iItemProxyPrice.getItemProxyPrice("" + proxyItemInfoDto.getProxyPriceId());
				iItemProxyPrice.removeItemProxyPrice(itemProxyPrice);
			}
		}
		//.....
		return "checked";
	}
	
	public String margin(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("2").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		auctionGuest = iGuestInfo.getGuestInfo(applicationInfo.getGuestId());
		
		ServletActionContext.getRequest().setAttribute("applyFlag",applyFlag);
		ServletActionContext.getRequest().setAttribute("accountName", applicationInfo.getAccountName());
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(applicationInfo.getGuestId(), "3");
		if(uploadImgInfo != null)
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		
		ServletActionContext.getRequest().setAttribute("applyContent",applicationInfo.getApplyContent());
		
		auctionTeamType_list = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		
		String aliveMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "1");
		ServletActionContext.getRequest().setAttribute("aliveMargin",aliveMargin);
		String webMargin = iItemMargin.getMarginVal(applicationInfo.getAccountId(), applicationInfo.getAuctionId(), "2");
		ServletActionContext.getRequest().setAttribute("webMargin",webMargin);
		
		ServletActionContext.getRequest().setAttribute("bidNum",applicationInfo.getBidNum());
		if(applicationInfo.getTeamAuthority() == null){
			ServletActionContext.getRequest().setAttribute("teamAuthority","");
		}else{
			String[] teamFlag = applicationInfo.getTeamAuthority().split(",");
			ServletActionContext.getRequest().setAttribute("teamAuthority",teamFlag);
		}
		
		return "margin";
	}
	
	public String doMargin(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String applyFlag = ServletActionContext.getRequest().getParameter("applyFlag");
		if( applyFlag == null ){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ApplicationInfo applicationInfo = iApplication.getApply(applyFlag);
		if( applicationInfo == null || ("1").equals(applicationInfo.getDeleteFlag()) ){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(applicationInfo.getAuctionId());
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) 
				|| ("0").equals(auctionInfo.getPublishFlag()) 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId()) ){
			return "sessionDestory";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", ("" + auctionInfo.getId()));
		
		if(!("2").equals(applicationInfo.getApplyStatus()) 
				|| ("2").equals(auctionInfo.getAuctionStatus()) ){
			return "checked";
		}
		
		String marginFlag = ServletActionContext.getRequest().getParameter("margin");
		if(marginFlag == null || ("0").equals(marginFlag)){
		}
		else{
			ItemMargin itemMargin = new ItemMargin();
			itemMargin.setId(null);
			itemMargin.setCreateTime(new Date());
			itemMargin.setAccountId(applicationInfo.getAccountId());
			itemMargin.setAuctionId(applicationInfo.getAuctionId());
			itemMargin.setCompanyId(applicationInfo.getCompanyId());
			itemMargin.setMarginType("1");
			itemMargin.setMarginVal(marginFlag);
			iItemMargin.saveItemMargin(itemMargin);
		}
		
		return "checked";
	}
	
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public List<ApplicationInfo> getApplyInfo_list() {
		return applyInfo_list;
	}

	public void setiApplication(IApplicationService iApplication) {
		this.iApplication = iApplication;
	}

	public AuctionGuest getAuctionGuest() {
		return auctionGuest;
	}

	public void setiQulification(IQulificationService iQulification) {
		this.iQulification = iQulification;
	}

	public void setiGuestInfo(IGuestInfoService iGuestInfo) {
		this.iGuestInfo = iGuestInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public List<AuctionTeamType> getAuctionTeamType_list() {
		return auctionTeamType_list;
	}

	public void setiAuctionTeamType(IAuctionTeamTypeService iAuctionTeamType) {
		this.iAuctionTeamType = iAuctionTeamType;
	}

	public void setiItemMargin(IItemMarginService iItemMargin) {
		this.iItemMargin = iItemMargin;
	}

	public void setiItemProxyPrice(IItemProxyPriceService iItemProxyPrice) {
		this.iItemProxyPrice = iItemProxyPrice;
	}
		
}
