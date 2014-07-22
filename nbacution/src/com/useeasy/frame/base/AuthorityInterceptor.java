package com.useeasy.frame.base;

import java.util.List;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class AuthorityInterceptor implements Interceptor{
	
	public void init() {
		
		 
	}
	
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
	@SuppressWarnings({ "rawtypes" })
	public String intercept(ActionInvocation invocation) throws Exception {
//		RegisterDao dao=new RegisterHibernetDaoImp();
//		List<Register> list=dao.findBy(Tools.getMotherboardSN());
//		if(list!=null&&list.size()>0){
//		   Register rg=  list.get(0) ;
//		   
//		}else{
//			
//			return "pmhRegister";
//		}
      	// TODO Auto-generated method stub
		SessionContainer sessionContainer = (SessionContainer) invocation.getInvocationContext()
			.getSession().get(Constants.SESEION_LISTENER);
		
		if(sessionContainer == null){
			return "sessionDestory";
		}else{
			if(sessionContainer.getAuctionAccount() == null || 
					("").equalsIgnoreCase(sessionContainer.getAuctionAccount().getAccountName())){
				return "sessionDestory";
			}else {
				Map appMap =  invocation.getInvocationContext().getApplication();
				if(!appMap.get(sessionContainer.getAuctionAccount().getAccountName())
						.equals(invocation.getInvocationContext().getSession().get(Constants.SESSION_ID))){
					return "sessionDestory";
				}else{
					String auction_url = ServletActionContext.getRequest().getRequestURI();
					auction_url.substring(auction_url.lastIndexOf("/") + 1);
					if(checkAuthority(sessionContainer.getAuctionAccount().getAccountType(),
							auction_url.substring(auction_url.lastIndexOf("/")))){
						return invocation.invoke();
					}else{
						return "sessionDestory";
					}
				}
			}
		}
	}
	
	private boolean checkAuthority(String role_type, String action_val) {
		if("1".equals(role_type)){
			if(action_val.indexOf("adminManage_") != -1 ){
				return true;
			}else{
				return false;
			}
		}else if("2".equals(role_type)){
			if(action_val.indexOf("companyManage_") != -1  
					|| action_val.indexOf("auctionManage_") != -1
					|| action_val.indexOf("itemManage_") != -1 
					|| action_val.indexOf("biddingManage_") != -1
					|| action_val.indexOf("companyAudit_") != -1
					|| action_val.indexOf("biddingView_") != -1
					|| action_val.indexOf("companyFinance_") != -1
					|| action_val.indexOf("companyBulletin_") != -1
					|| action_val.indexOf("companyPayment_") != -1
					|| action_val.indexOf("auctionIndexVocationnews_") !=-1
				){
				return true;
			}else{
				return false;
			}
		}else if("3".equals(role_type)){
			if(action_val.indexOf("guestManage_") != -1 
					|| action_val.indexOf("guestApplication_") != -1
					|| action_val.indexOf("guestProxy_") != -1 
					|| action_val.indexOf("biddingView_") != -1
					|| action_val.indexOf("guestBidRecord_") != -1
					|| action_val.indexOf("guestDealRecord_") != -1
					|| action_val.indexOf("guestFinance_") ==0 
					
				){
				return true;
			}else{
				return false;
			}
		}
		return true;
	}
	
}
