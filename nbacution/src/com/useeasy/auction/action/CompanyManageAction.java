package com.useeasy.auction.action;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.service.IAccountInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class CompanyManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(CompanyManageAction.class);
	
	private ICompanyInfoService iCompanyInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAccountInfoService iAccountInfo;
	
	private AuctionCompany auctionCompany;
	
	public String edit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		auctionCompany = iCompanyInfo.getCompanyInfo(company_id);
		if(auctionCompany == null)
			return "sessionDestory";
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(company_id, "1");
		if(uploadImgInfo != null){
			ServletActionContext.getRequest().setAttribute("imgId", "" + uploadImgInfo.getId());
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		}
		return "edit";
	}
	
	public String modify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String customPicVal = ServletActionContext.getRequest().getParameter("customPicVal");
		if(customPicVal == null)
			return "sessionDestory";
		
		iCompanyInfo.saveCompanyInfo(auctionCompany);
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		if(!("").equals(customPicVal)){
			UploadImgInfo uploadImgInfo = iUploadImgInfo
				.getUploadImgByUploadTypeAndRelationId(company_id, "1");
			if(uploadImgInfo != null)
				iUploadImgInfo.removeUploadImgInfo(uploadImgInfo);
			UploadImgInfo uploadImgInfo_s = iUploadImgInfo.getUploadImgInfo(customPicVal);
			if(uploadImgInfo_s != null){
				uploadImgInfo_s.setRelationId(company_id);
				iUploadImgInfo.saveUploadImgInfo(uploadImgInfo_s);
			}
		}
		return "saved";
	}
	
	public String passEdit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "passEdit";
	}
		
	public String passModify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		AuctionAccount auctionAccount = sessionContainer.getAuctionAccount();
		String accountPass = ServletActionContext.getRequest().getParameter("accountPass");
		String accountConfirmPass = ServletActionContext.getRequest().getParameter("accountConfirmPass");
		
		if(accountPass == null || accountConfirmPass == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "3");  
			return "passEdit";
		}
		if(!Tools.StingToMD5(accountPass).equals(auctionAccount.getAccountPass())){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
			return "passEdit";
		}
		auctionAccount.setAccountPass(Tools.StingToMD5(accountConfirmPass));
		iAccountInfo.saveAuctionAccount(auctionAccount);
		ServletActionContext.getRequest().setAttribute("checkFlag", "2");
		return "passEdit";
	}
	
	public AuctionCompany getAuctionCompany() {
		return auctionCompany;
	}

	public void setAuctionCompany(AuctionCompany auctionCompany) {
		this.auctionCompany = auctionCompany;
	}

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}
	
}
