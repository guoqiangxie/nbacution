package com.useeasy.auction.action;

import java.io.IOException;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.intenetView.bean.IntenetView;
import com.useeasy.auction.intenetView.dao.IntenetetViewDao;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

@SuppressWarnings("serial")
public class BiddingViewAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
    
	private IAuctionInfoService iAuctionInfo;
	private IntenetetViewDao intenetetViewDao;
	public String checkViewer(){
		/*String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkViewer";
		}*/
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkViewer";
		}
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| "0".equals(auctionInfo.getPublishFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkViewer";
		}
		
		if("1".equals(auctionInfo.getAuctionOnlineUser())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "3");  //人数满
			return "checkViewer";
		}
		
		if(("0").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "1");
		}else if(("1").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "2");
		}else {
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
		}
		return "checkViewer";
	}
	
	public String viewerWait(){
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
		
		if("1".equals(auctionInfo.getAuctionOnlineUser())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "3");  //人数满
			return "checkViewer";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		
		return "viewerWait";
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
	
	public String viewer(){
		/*String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "0");
			return "checkViewer";
		}*/
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| "0".equals(auctionInfo.getPublishFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus())){
			return "sessionDestory";
		}
		
		if("1".equals(auctionInfo.getAuctionOnlineUser())){
			ServletActionContext.getRequest().setAttribute("bidderFlag", "3");  //人数满
			return "checkViewer";
		}
		
		if(("0").equals(auctionInfo.getAuctionStatus())){
			ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
			return "viewerWait";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount == null){
			
			return "sessionDestory";
		}
		IntenetView view = intenetetViewDao.findBy(auctionAccount.getAccountName() ,auctionFlag);
	   if(auctionAccount.getPmManager()==null ){
		  // if(!auctionAccount.getPmManager().equals("1")){
	  
		if(view ==null){
			
			//进入申请
			try {
				ServletActionContext.getResponse().sendRedirect("inteneterAction_addUI?pmhId="+auctionFlag);
			} catch (IOException e) {
				 
				e.printStackTrace();
			}
			
			return null;
		} else{
			if(!view.getViewSta().equals("1")){
				//进入申请
				try {
					ServletActionContext.getResponse().sendRedirect("inteneterAction_addUI?pmhId="+auctionFlag);
				} catch (IOException e) {
					 
					e.printStackTrace();
				}
				
				return null;
			}
		}
		  // }
	   }
		
		
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("auctionName", auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("videoNum", auctionInfo.getAuctionNum());
		ServletActionContext.getRequest().setAttribute("xmlNum", auctionInfo.getXmlNumFlag());
		ServletActionContext.getRequest().setAttribute("viewerNum", RandomStringUtils.random(6, true, true));
		
		return "viewer";
	}

	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public IntenetetViewDao getIntenetetViewDao() {
		return intenetetViewDao;
	}

	public void setIntenetetViewDao(IntenetetViewDao intenetetViewDao) {
		this.intenetetViewDao = intenetetViewDao;
	}

}
