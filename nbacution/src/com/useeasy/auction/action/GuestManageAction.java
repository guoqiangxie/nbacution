package com.useeasy.auction.action;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionGuest;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.service.IAccountInfoService;
import com.useeasy.auction.service.IGuestInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class GuestManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(GuestManageAction.class);
    
	private IGuestInfoService iGuestInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAccountInfoService iAccountInfo;
	
	private AuctionGuest auctionGuest;
	
	public String edit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
	 if( sessionContainer.getAuctionGuest().getId()!=null){
		String guest_id = "" + sessionContainer.getAuctionGuest().getId();
		auctionGuest = iGuestInfo.getGuestInfo(guest_id);
		if(auctionGuest == null){
			return "sessionDestory";
		}
		UploadImgInfo uploadImgInfo = iUploadImgInfo
			.getUploadImgByUploadTypeAndRelationId(guest_id, "3");
		if(uploadImgInfo != null&&uploadImgInfo.getUploadUrl()!=null){
			ServletActionContext.getRequest().setAttribute("imgUrl", uploadImgInfo.getUploadUrl());
		}
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
		iGuestInfo.saveGuestInfo(auctionGuest);
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
	
	public AuctionGuest getAuctionGuest() {
		return auctionGuest;
	}

	public void setAuctionGuest(AuctionGuest auctionGuest) {
		this.auctionGuest = auctionGuest;
	}

	public void setiGuestInfo(IGuestInfoService iGuestInfo) {
		this.iGuestInfo = iGuestInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}
	
}
