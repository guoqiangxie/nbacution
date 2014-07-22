package com.useeasy.auction.action;

import java.util.Date;

import org.apache.commons.lang.RandomStringUtils;
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
import com.useeasy.auction.util.mail.MailSender;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class RegisterManageAction extends ActionSupport{
	
	static final Logger logger = LoggerFactory.getLogger(RegisterManageAction.class);
	
	private IAccountInfoService iAccountInfo;
	private IGuestInfoService iGuestInfo;
	private IUploadImgInfoService iUploadImgInfo;
	
	public String register(){logger.info("11111___________");
		return "register";
	}

	public String checkAccount(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String usAccountFlag = ServletActionContext.getRequest().getParameter("usAccountFlag");
		if(usAccountFlag == null)
			return "sessionDestory";
		
		if(iAccountInfo.isNotExistAccountName(usAccountFlag)){  
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
		}else {
			ServletActionContext.getRequest().setAttribute("checkFlag", "0");
		}
		return "checkAccount";
	}
	
	public String doRegister(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String usAccountPass = ServletActionContext.getRequest().getParameter("usAccountPass");
		//String usConfirmPass = ServletActionContext.getRequest().getParameter("usConfirmPass");
		String userName = ServletActionContext.getRequest().getParameter("userName");
		String identityCard = ServletActionContext.getRequest().getParameter("identityCard");
		String userPhone = ServletActionContext.getRequest().getParameter("userPhone");
		String userTel = ServletActionContext.getRequest().getParameter("userTel");
		String userEmail = ServletActionContext.getRequest().getParameter("userEmail");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		String cardType = ServletActionContext.getRequest().getParameter("cardType");
		String validateCode = (String) ActionContext.getContext().getSession()
			.get(Constants.VALIDATE_REGISTER_CODE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
			return "register"; 
		}
		
		if(iAccountInfo.isNotExistAccountName(usAccount)){
			if(iAccountInfo.isExistAccountIdentityCard(identityCard)){
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");
				return "register";
			}
		
			AuctionGuest auctionGuest = new AuctionGuest();
			if(cardType!=null){
				if(cardType.equals("2")|cardType.equals("3")|cardType.equals("3")){
					auctionGuest.setCardType(cardType);
				} 
				
			}else{
				auctionGuest.setCardType("1");
			}
			auctionGuest.setId(null);
			auctionGuest.setCreateTime(new Date());
			auctionGuest.setUpdateTime(new Date());
			auctionGuest.setDeleteFlag("0");
			auctionGuest.setGuestName(userName);
			auctionGuest.setGuestIdentityCard(identityCard);
			auctionGuest.setGuestPhone(userPhone);
			auctionGuest.setGuestTel(userTel);
			auctionGuest.setGuestEmail(userEmail);
			iGuestInfo.saveGuestInfo(auctionGuest);
			
			String randStr = RandomStringUtils.random(8, true, true);
			
			AuctionAccount auctionAccount = new AuctionAccount();
			auctionAccount.setId(null);
			auctionAccount.setCreateTime(new Date());
			auctionAccount.setUpdateTime(new Date());
			auctionAccount.setDeleteFlag("0");
			auctionAccount.setAccountName(usAccount);
			auctionAccount.setAccountPass(Tools.StingToMD5(usAccountPass));
			auctionAccount.setAccountStatus("1");
			auctionAccount.setAccountType("3");
			auctionAccount.setAccountRelationId("" + auctionGuest.getId());
			auctionAccount.setAccountRegisterCode(randStr);
			iAccountInfo.saveAuctionAccount(auctionAccount);
			
			String customPicVal = ServletActionContext.getRequest().getParameter("customPicVal");
			if(customPicVal == null || ("".equals(customPicVal))){
				/*ServletActionContext.getRequest().setAttribute("checkFlag", "2");
				return "register";*/ 
			}else{
				UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo(customPicVal);
				if(uploadImgInfo != null){
					uploadImgInfo.setRelationId("" + auctionGuest.getId());
					iUploadImgInfo.saveUploadImgInfo(uploadImgInfo);
				}
			}
//			MailSender.sendMessage(auctionGuest.getGuestEmail(), 
//					auctionGuest.getGuestName(), "registerManage_validateMail?accountFlag="
//					+ auctionAccount.getId() + "&validateCode=" + randStr);
			return "registerSuc";
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "3");
			return "register";
		}
	}
	
	public String validateMail(){logger.info("11111___________");
		String accountFlag = ServletActionContext.getRequest().getParameter("accountFlag");
		String validateCode = ServletActionContext.getRequest().getParameter("validateCode");
		
		if(accountFlag != null && validateCode != null){
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfo(accountFlag);
			if(auctionAccount == null){
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");
				return "validateErr";
			}
			if(!("3").equals(auctionAccount.getAccountType())){
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");
				return "validateErr";
			}
			if(("0").equals(auctionAccount.getAccountStatus())){
				auctionAccount.setAccountStatus("1");
				iAccountInfo.saveAuctionAccount(auctionAccount);
				return "validateSuc";
			}else if(("1").equals(auctionAccount.getAccountStatus())){
				ServletActionContext.getRequest().setAttribute("checkFlag", "2");
				return "validateErr";
			}else if(("2").equals(auctionAccount.getAccountStatus())){
				ServletActionContext.getRequest().setAttribute("checkFlag", "3");
				return "validateErr";
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");
				return "validateErr";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
			return "validateErr";
		}
	}
	
	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}

	public void setiGuestInfo(IGuestInfoService iGuestInfo) {
		this.iGuestInfo = iGuestInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}
	
	
	
}
