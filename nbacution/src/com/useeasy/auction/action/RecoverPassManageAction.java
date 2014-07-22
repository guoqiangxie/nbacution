package com.useeasy.auction.action;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionGuest;
import com.useeasy.auction.bean.PassRecover;
import com.useeasy.auction.service.IAccountInfoService;
import com.useeasy.auction.service.IGuestInfoService;
import com.useeasy.auction.service.IPassRecoverService;
import com.useeasy.auction.util.mail.MailSender;
import com.useeasy.auction.util.sms.SmsSender;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class RecoverPassManageAction extends ActionSupport{
	
	static final Logger logger = LoggerFactory.getLogger(RecoverPassManageAction.class);
	   
	private IAccountInfoService iAccountInfo;
	private IGuestInfoService iGuestInfo;
	private IPassRecoverService iPassRecover;
	
	public String phone(){logger.info("11111___________");
		return "phone";
	}
	
	public String getPhonePass(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}								
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		if(usAccount == null || validatecode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_PHONE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "phone"; 
		}
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			String count = iPassRecover.getPassRecoverCountToday(usAccount,"1");
			if(Long.valueOf(count) >= 3){
				ServletActionContext.getRequest().setAttribute("checkFlag", "3");  
				return "phone";
			}
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "phone";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "phone";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				AuctionGuest auctionGuest = iGuestInfo.getGuestInfo(auctionAccount.getAccountRelationId());
				
				String randStr = RandomStringUtils.random(6, true, true).toLowerCase();
				
				PassRecover passRecover = new PassRecover();
				passRecover.setId(null);
				passRecover.setAccountName(usAccount);
				passRecover.setCreateTime(new Date());
				passRecover.setAccountPassType("1");
				passRecover.setAccountPassTemp(randStr);
				iPassRecover.savePassRecover(passRecover);
				
				StringBuffer mms = new StringBuffer(); 
				mms.append("网络拍卖信息系统随机短信密码：");
				mms.append(randStr); 
				mms.append(" ，此密码为短信登陆密码。"); 
				try {
					SmsSender.SendSms(auctionGuest.getGuestPhone(),mms.toString());
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ServletActionContext.getRequest().setAttribute("checkFlag", "6");  
				return "phone";
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "phone";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
	}
	
	public String doPhoneSubmit(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}								
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		String passcode = ServletActionContext.getRequest().getParameter("passcode");
		
		if(usAccount == null || validatecode == null || passcode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_PHONE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "phone"; 
		}
		
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "phone";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "phone";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				PassRecover passRecover = iPassRecover.getPassRecoverTodayOrdered(usAccount, "1");
				if(passRecover == null){
					ServletActionContext.getRequest().setAttribute("checkFlag", "7");  
					return "phone";
				}else{
					if(!passcode.equals(passRecover.getAccountPassTemp())){
						ServletActionContext.getRequest().setAttribute("checkFlag", "7"); 
						return "phone";
					}else{
						ServletActionContext.getRequest().setAttribute("usAccount", usAccount); 
						ServletActionContext.getRequest().setAttribute("validatecode", validatecode); 
						return "phoneLogin";
					}
				}
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "phone";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
	}
	
	public String phoneModifySubmit(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String accountNewPass = ServletActionContext.getRequest().getParameter("accountNewPass");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		
		if(usAccount == null || accountNewPass == null || validatecode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_PHONE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "phone"; 
		}
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "phone";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "phone";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				auctionAccount.setAccountPass(Tools.StingToMD5(accountNewPass));
				auctionAccount.setUpdateTime(new Date());
				iAccountInfo.saveAuctionAccount(auctionAccount);
				ServletActionContext.getRequest().setAttribute("checkFlag", "8");
				return "phone";
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "phone";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "phone";
		}
	}
	
	public String email(){logger.info("11111___________");
		return "email";
	}
	
	public String getEmailPass(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}								
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		if(usAccount == null || validatecode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_EMAIL);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "email"; 
		}
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			String count = iPassRecover.getPassRecoverCountToday(usAccount,"2");
			if(Long.valueOf(count) >= 3){
				ServletActionContext.getRequest().setAttribute("checkFlag", "3");  
				return "email";
			}
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "email";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "email";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				AuctionGuest auctionGuest = iGuestInfo.getGuestInfo(auctionAccount.getAccountRelationId());
				
				String randStr = RandomStringUtils.random(6, true, true).toLowerCase();
				
				PassRecover passRecover = new PassRecover();
				passRecover.setId(null);
				passRecover.setAccountName(usAccount);
				passRecover.setCreateTime(new Date());
				passRecover.setAccountPassType("2");
				passRecover.setAccountPassTemp(randStr);
				iPassRecover.savePassRecover(passRecover);
				
				MailSender.sendPassMessage(auctionGuest.getGuestEmail(), 
						auctionGuest.getGuestName(),randStr);
				ServletActionContext.getRequest().setAttribute("checkFlag", "6");  
				return "email";
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "email";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
	}
	
	public String doEmailSubmit(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}								
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		String passcode = ServletActionContext.getRequest().getParameter("passcode");
		
		if(usAccount == null || validatecode == null || passcode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_EMAIL);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "email"; 
		}
		
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "email";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "email";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				PassRecover passRecover = iPassRecover.getPassRecoverTodayOrdered(usAccount, "2");
				if(passRecover == null){
					ServletActionContext.getRequest().setAttribute("checkFlag", "7");  
					return "email";
				}else{
					if(!passcode.equals(passRecover.getAccountPassTemp())){
						ServletActionContext.getRequest().setAttribute("checkFlag", "7"); 
						return "email";
					}else{
						ServletActionContext.getRequest().setAttribute("usAccount", usAccount); 
						ServletActionContext.getRequest().setAttribute("validatecode", validatecode); 
						return "emailLogin";
					}
				}
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "email";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
	}
	
	public String emailModifySubmit(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String accountNewPass = ServletActionContext.getRequest().getParameter("accountNewPass");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		
		if(usAccount == null || accountNewPass == null || validatecode == null){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_RECOVER_CODE_EMAIL);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2");  
			return "email"; 
		}
		
		if(!iAccountInfo.isNotExistAccountName(usAccount)){  
			AuctionAccount auctionAccount = iAccountInfo.getAccountInfoByAccountName(usAccount);
			if ("0".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");  
				return "email";
			}else if ("2".equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				return "email";
			}else if ("1".equals(auctionAccount.getAccountStatus())){  
				auctionAccount.setAccountPass(Tools.StingToMD5(accountNewPass));
				auctionAccount.setUpdateTime(new Date());
				iAccountInfo.saveAuctionAccount(auctionAccount);
				ServletActionContext.getRequest().setAttribute("checkFlag", "8");
				return "email";
			}else{
				ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
				return "email";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");  
			return "email";
		}
	}
	
	
	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}

	public void setiGuestInfo(IGuestInfoService iGuestInfo) {
		this.iGuestInfo = iGuestInfo;
	}

	public void setiPassRecover(IPassRecoverService iPassRecover) {
		this.iPassRecover = iPassRecover;
	}
	
	
	
	
}
