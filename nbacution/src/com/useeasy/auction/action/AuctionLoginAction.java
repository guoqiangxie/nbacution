package com.useeasy.auction.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.service.IAccountInfoService;
import com.useeasy.auction.service.IAdminInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IGuestInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class AuctionLoginAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
    
	private IAccountInfoService iAccountInfo;
	private IAdminInfoService iAdminInfo;
	private ICompanyInfoService iCompanyInfo;
	private IGuestInfoService iGuestInfo;
	
	
	@SuppressWarnings("rawtypes")
	public String checkLogined(){logger.info("11111___________");
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		if(sessionContainer.getAuctionAccount() == null || 
				("").equalsIgnoreCase(sessionContainer.getAuctionAccount().getAccountName())){
			return "noLogined";
		}else {
			Map appMap =  ActionContext.getContext().getApplication();
			if(!appMap.get(sessionContainer.getAuctionAccount().getAccountName())
					.equals(ServletActionContext.getRequest().getSession().getId())){
				return "noLogined";
			}else{
				return "logined";
			}
		}
	}
	
	public String login(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String usAccountPass = ServletActionContext.getRequest().getParameter("usAccountPass");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		
		if(usAccount == null || usAccountPass == null || validatecode == null){
			return "sessionDestory";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_CODE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1"); 
			return "noLogined"; 
		}
		List<AuctionAccount> list = iAccountInfo.getAccountByNameAndPass(usAccount, Tools.StingToMD5(usAccountPass));
		if(list.size() == 0){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2"); 
			return "noLogined";
		}else if(list.size() == 1){
			AuctionAccount auctionAccount = list.get(0);
			if(("0").equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "3");   
				return "noLogined";
			}else if(("2").equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");   
				return "noLogined";
			}else if(("1").equals(auctionAccount.getAccountStatus())){  
				SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER);
				sessionContainer.setAuctionAccount(auctionAccount);
				if("1".equalsIgnoreCase(auctionAccount.getAccountType())){
					sessionContainer.setAuctionAdmin(iAdminInfo.getAdminInfo(auctionAccount.getAccountRelationId()));
					logger.info("admin logined:" + auctionAccount.getId());
				}else if("2".equalsIgnoreCase(auctionAccount.getAccountType())){  
					sessionContainer.setAuctionCompany(iCompanyInfo.getCompanyInfo(auctionAccount.getAccountRelationId()));
					logger.info("company logined:" + auctionAccount.getId());
				}else if("3".equalsIgnoreCase(auctionAccount.getAccountType())){  
					sessionContainer.setAuctionGuest(iGuestInfo.getGuestInfo(auctionAccount.getAccountRelationId()));
					logger.info("guest logined:" + auctionAccount.getId());
				}else if("4".equalsIgnoreCase(auctionAccount.getAccountType())){  //工商监管
					sessionContainer.setAuctionCompany(iCompanyInfo.getCompanyInfo(auctionAccount.getAccountRelationId()));
					logger.info("company logined:" + auctionAccount.getId());
					ServletActionContext.getRequest().setAttribute("accountType", "4");
				}
				ActionContext.getContext().getApplication().put(sessionContainer
					.getAuctionAccount().getAccountName(), ServletActionContext.getRequest().getSession().getId());
				ServletActionContext.getRequest().setAttribute("checkFlag", "99");
				return "logined"; 
			} else {
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				logger.info("login_error: " + auctionAccount.getId() + " accountStatus is not correct");
				return "noLogined";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "6");
			logger.info("login_error: " + usAccount + " accountName is not unique");
			return "noLogined";
		}
	}

	public String logout(){logger.info("11111___________");
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		sessionContainer.setAuctionAccount(null);
		sessionContainer.setAuctionAdmin(null);
		sessionContainer.setAuctionCompany(null);
		sessionContainer.setAuctionGuest(null);
		return "noLogined";
	}
	
	public String frameLogout(){logger.info("11111___________");
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		sessionContainer.setAuctionAccount(null);
		sessionContainer.setAuctionAdmin(null);
		sessionContainer.setAuctionCompany(null);
		sessionContainer.setAuctionGuest(null);
		return "sessionDestory";
	}
	
	public String specialLogin(){logger.info("11111___________");
		String requestUrl = ServletActionContext.getRequest().getParameter("requestUrl");
		ServletActionContext.getRequest().setAttribute("requestUrl", requestUrl); 
		return "specialLogin";
	}
	
	public String specialDoLogin(){logger.info("11111___________");
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String usAccount = ServletActionContext.getRequest().getParameter("usAccount");
		String usAccountPass = ServletActionContext.getRequest().getParameter("usAccountPass");
		String validatecode = ServletActionContext.getRequest().getParameter("validatecode");
		
		String requestUrl = ServletActionContext.getRequest().getParameter("requestUrl");
		ServletActionContext.getRequest().setAttribute("requestUrl", requestUrl);
		
		if(usAccount == null || usAccountPass == null || validatecode == null || requestUrl == null){
			return "sessionDestory";
		}
		
		String validateCode = (String) ActionContext.getContext().getSession().get(Constants.VALIDATE_SPECIAL_CODE);   
		if(!validatecode.equalsIgnoreCase(validateCode)){
			ServletActionContext.getRequest().setAttribute("checkFlag", "1"); 
			return "specialLogin"; 
		}
		List<AuctionAccount> list = iAccountInfo.getAccountByNameAndPass(usAccount, Tools.StingToMD5(usAccountPass));
		if(list.size() == 0){
			ServletActionContext.getRequest().setAttribute("checkFlag", "2"); 
			return "specialLogin";
		}else if(list.size() == 1){
			AuctionAccount auctionAccount = list.get(0);
			if(("0").equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "3");   
				return "specialLogin";
			}else if(("2").equals(auctionAccount.getAccountStatus())){  
				ServletActionContext.getRequest().setAttribute("checkFlag", "4");   
				return "specialLogin";
			}else if(("1").equals(auctionAccount.getAccountStatus())){  
				SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER);
				sessionContainer.setAuctionAccount(auctionAccount);
				if("1".equalsIgnoreCase(auctionAccount.getAccountType())){
					sessionContainer.setAuctionAdmin(iAdminInfo.getAdminInfo(auctionAccount.getAccountRelationId()));
					logger.info("admin logined:" + auctionAccount.getId());
				}else if("2".equalsIgnoreCase(auctionAccount.getAccountType())){  
					sessionContainer.setAuctionCompany(iCompanyInfo.getCompanyInfo(auctionAccount.getAccountRelationId()));
					logger.info("company logined:" + auctionAccount.getId());
				}else if("3".equalsIgnoreCase(auctionAccount.getAccountType())){  
					sessionContainer.setAuctionGuest(iGuestInfo.getGuestInfo(auctionAccount.getAccountRelationId()));
					logger.info("guest logined:" + auctionAccount.getId());
				}
				ActionContext.getContext().getApplication().put(sessionContainer
					.getAuctionAccount().getAccountName(), ServletActionContext.getRequest().getSession().getId());
				ServletActionContext.getRequest().setAttribute("checkFlag", "99");
				return "specialLogined"; 
			} else {
				ServletActionContext.getRequest().setAttribute("checkFlag", "5");
				logger.info("login_error: " + auctionAccount.getId() + " accountStatus is not correct");
				return "specialLogin";
			}
		}else{
			ServletActionContext.getRequest().setAttribute("checkFlag", "6");
			logger.info("login_error: " + usAccount + " accountName is not unique");
			return "specialLogin";
		}
		
	}
	
	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}

	public void setiAdminInfo(IAdminInfoService iAdminInfo) {
		this.iAdminInfo = iAdminInfo;
	}

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiGuestInfo(IGuestInfoService iGuestInfo) {
		this.iGuestInfo = iGuestInfo;
	}
	
	
	
}
