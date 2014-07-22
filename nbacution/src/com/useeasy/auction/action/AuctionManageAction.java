package com.useeasy.auction.action;

import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionTeamType;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IAuctionTeamTypeService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class AuctionManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
	
	private IAuctionInfoService iAuctionInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAuctionTeamTypeService iAuctionTeamType;
	private IItemInfoService iItemInfo;
	
	private AuctionInfo auctionInfo;
	private AuctionTeamType auctionTeamType;
	
	public String index(){//session._listener.auctionAccount.accountTyp
		 
		String auctionAccountType=((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getAccountType();
		
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		if(auctionAccountType.equals("4")){//如果是工商监管
			return "businessManager";
		}
		String company_id = "" + sessionContainer.getAuctionCompany().getId() ;
		
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if( currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iAuctionInfo.getAuctionInfoDtoCount(company_id, ("1"), ("5"), ("2")));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<AuctionInfoDto> auctionInfoDtoList = iAuctionInfo.getAuctionInfoDtoList(company_id, ("1"), ("5"), ("2"), basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		if( auctionInfoDtoList != null && auctionInfoDtoList.size() > 0){
			for(int i = 0; i < auctionInfoDtoList.size(); i++){
				AuctionInfoDto auctionInfoDto = auctionInfoDtoList.get(i);
				if(auctionInfoDto != null){
				String imgType = auctionInfoDto.getAuctionPicType();  //img type
				if(imgType!=null&&!"".equals(imgType)){
				if( "1".equals(imgType) ){  
				     if(auctionInfoDto.getAuctionCompanyId()!=null){
				    		UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", auctionInfoDto.getAuctionCompanyId());
							  if(uploadImgInfo!=null){
								  if(uploadImgInfo.getUploadUrl()!=null){
								   auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
								  }
							  }
				     }
				
				}else if( "3".equals(imgType) ){  
				  if( auctionInfoDto.getId() != null){
					    UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("2", "" + auctionInfoDto.getId());
						if(uploadImgInfo!=null){
						  if(uploadImgInfo.getUploadUrl()!=null){	
					        auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						  }
						}
				  }	
					
				}
			}
			} }
		}
		ServletActionContext.getRequest().setAttribute("auctionInfoList", auctionInfoDtoList);
		
		return "index";
	}

	public String add(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		Random random = new Random();
		String randomStr = Tools.dateToString(new Date(), "yyyyMMddhhmmssSSS");
		String randomVal = randomStr.substring(randomStr.length()-5,randomStr.length()) + 
			String.valueOf(random.nextInt(10)) + String.valueOf(random.nextInt(10)) + 
			String.valueOf(random.nextInt(10));
		ServletActionContext.getRequest().setAttribute("randomVal", randomVal);
		
		UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", "" + company_id);
		if(uploadImgInfo == null)
			ServletActionContext.getRequest().setAttribute("companyPicUrl", "/uploadFile/image/base/nopic.jpg");
		else
			ServletActionContext.getRequest().setAttribute("companyPicUrl", uploadImgInfo.getUploadUrl());
		
		return "add";
	}
	
	public String save(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		auctionInfo.setId(null);
		auctionInfo.setCreateTime(new Date());
		auctionInfo.setUpdateTime(new Date());
		auctionInfo.setDeleteFlag("0");
		auctionInfo.setAuctionStatus("0");
		auctionInfo.setAuctionCompanyId(company_id);
		auctionInfo.setAuctionCountTime("3");
		auctionInfo.setAuctionStartTime(Tools.stringToDate(auctionInfo.getAuctionStartTimeVal(),"yyyy-MM-dd hh:mm"));
		auctionInfo.setXmlFlag("0");
		auctionInfo.setSortFlag("0");
		auctionInfo.setPublishFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		String picFlag = auctionInfo.getAuctionPicType();
		if("1".equals(picFlag)){
			auctionInfo.setAuctionPicVal(null);
			iAuctionInfo.saveAuctionInfo(auctionInfo);
		}else if("2".equals(picFlag)){
		}else if("3".equals(picFlag)){
			String picVal = ServletActionContext.getRequest().getParameter("customPicVal");
			auctionInfo.setAuctionPicVal(picVal);
			iAuctionInfo.saveAuctionInfo(auctionInfo);
			
			UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo(picVal);
			uploadImgInfo.setRelationId("" + auctionInfo.getId());
			iUploadImgInfo.saveUploadImgInfo(uploadImgInfo);
		}
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
		return "default";
	}
	
	public String edit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
			|| !("0").equals(auctionInfo.getAuctionStatus())
			|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
			
		UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", "" + company_id);
		if(uploadImgInfo == null)
			ServletActionContext.getRequest().setAttribute("companyPicUrl", "/uploadFile/image/base/nopic.jpg");
		else
			ServletActionContext.getRequest().setAttribute("companyPicUrl", uploadImgInfo.getUploadUrl());
		
		auctionInfo.setAuctionStartTimeVal(Tools.dateToString(auctionInfo.getAuctionStartTime(), "yyyy-MM-dd hh:mm"));
		return "edit";
	}
	
	public String modify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
	
		AuctionInfo auctionInfo_s = iAuctionInfo.getAuctionInfo("" + auctionInfo.getId());
		if(auctionInfo_s == null 
			|| !("0").equals(auctionInfo_s.getAuctionStatus())
			|| !(company_id).equals(auctionInfo_s.getAuctionCompanyId())){
			return "error";
		}
		
		UploadImgInfo uploadImgInfo_o = iUploadImgInfo
			.getUploadImgInfo("2", "" + auctionInfo_s.getId());

		auctionInfo.setUpdateTime(new Date());
		auctionInfo.setAuctionStartTime(Tools.stringToDate(auctionInfo.getAuctionStartTimeVal(),"yyyy-MM-dd hh:mm"));
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		String picFlag = auctionInfo.getAuctionPicType();
		if("1".equals(picFlag)){
			auctionInfo.setAuctionPicVal(null);
			iAuctionInfo.saveAuctionInfo(auctionInfo);
			if(uploadImgInfo_o != null)
				iUploadImgInfo.removeUploadImgInfo(uploadImgInfo_o);
				//delete file in disk;
		}else if("2".equals(picFlag)){
			String auctionPicVal = ServletActionContext.getRequest().getParameter("auctionPicVal");
			auctionInfo.setAuctionPicVal(auctionPicVal);
			iAuctionInfo.saveAuctionInfo(auctionInfo);
			if(uploadImgInfo_o != null)
				iUploadImgInfo.removeUploadImgInfo(uploadImgInfo_o);
				//delete file in disk;
		}else if("3".equals(picFlag)){
			String picVal = ServletActionContext.getRequest().getParameter("customPicVal");
			if(picVal == null){
				return "error";
			}else{
				if(("").equals(picVal)){
				}else{
					UploadImgInfo uploadImgInfo_n = iUploadImgInfo.getUploadImgInfo(picVal);
					uploadImgInfo_n.setRelationId("" + auctionInfo.getId());
					iUploadImgInfo.saveUploadImgInfo(uploadImgInfo_n);
					if(uploadImgInfo_o != null)
						iUploadImgInfo.removeUploadImgInfo(uploadImgInfo_o);
						//delete file in disk;
					auctionInfo.setAuctionPicVal(picVal);
					iAuctionInfo.saveAuctionInfo(auctionInfo);
				}
			}
		}
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
		return "default";
	}
	
	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
			
		UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", "" + company_id);
		if(uploadImgInfo == null)
			ServletActionContext.getRequest().setAttribute("companyPicUrl", "/uploadFile/image/base/nopic.jpg");
		else
			ServletActionContext.getRequest().setAttribute("companyPicUrl", uploadImgInfo.getUploadUrl());
		
		List<AuctionTeamType> auctionTeamTypeList = iAuctionTeamType.getAuctionTeamType(auctionFlag);
		ServletActionContext.getRequest().setAttribute("auctionTeamTypeList", auctionTeamTypeList);
		
		auctionInfo.setAuctionStartTimeVal(Tools.dateToString(auctionInfo.getAuctionStartTime(), "yyyy-MM-dd hh:mm"));
		return "detail";
	}
	
	public String delete(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		auctionInfo.setUpdateTime(new Date());
		auctionInfo.setXmlFlag("0");
		auctionInfo.setSortFlag("0");
		auctionInfo.setPublishFlag("0");
		auctionInfo.setDeleteFlag("1");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
		return "default";
	}
	
	public String teamTypeIndex(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		List<AuctionTeamType> auctionTeamTypeList = iAuctionTeamType.getAuctionTeamType(auctionFlag);
		ServletActionContext.getRequest().setAttribute("auctionTeamTypeList", auctionTeamTypeList);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "teamTypeIndex";
	}
	
	public String addTeamType(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "teamTypeAdd";
	}
	
	public String saveTeamType(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		auctionTeamType.setId(null);
		auctionTeamType.setCreateTime(new Date());
		auctionTeamType.setAuctionId(auctionFlag);
		iAuctionTeamType.saveTeamType(auctionTeamType);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "teamTypeSaved";
	}
	
	public String removeTeamType(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxes_flag");
		if(boxesFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		String[] box_val = boxesFlag.split(",");
		
		for(int i = 0; i < box_val.length; i++){
			AuctionTeamType auctionTeamType = iAuctionTeamType.getTeamType(box_val[i]);
			if(auctionTeamType != null && (auctionFlag).equals(auctionTeamType.getAuctionId())){
				iAuctionTeamType.removeTeamType(auctionTeamType);
			}else{
				continue;
			}
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "teamTypeSaved";
	}
	
	public String publish(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				|| "1".equals(auctionInfo.getPublishFlag()) 
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		auctionInfo.setUpdateTime(new Date());
		auctionInfo.setPublishFlag("1");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
		return "default";
	}
	
	public String showStatus(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				|| "0".equals(auctionInfo.getPublishFlag()) 
				|| ("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		List<Object[]> list = iAuctionInfo.getAuctionAliveStatus(auctionFlag);
		ServletActionContext.getRequest().setAttribute("aliveStatusList", list);
		
		return "showStatus";
	}
	
	
	//...
	public String analyze(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null 
				|| "0".equals(auctionInfo.getPublishFlag()) 
				|| !("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "auctionManage_index?currentPage=1");
			return "default";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		
		String itemAll = iItemInfo.getItemCountInAnalyze(auctionFlag, "1");
		String itemDeal = iItemInfo.getItemCountInAnalyze(auctionFlag, "2");
		String itemDealInAlive = iItemInfo.getItemCountInAnalyze(auctionFlag, "6");
		String itemDealInNet = iItemInfo.getItemCountInAnalyze(auctionFlag, "7");
		String itemPass = iItemInfo.getItemCountInAnalyze(auctionFlag, "3");
		String itemChe = iItemInfo.getItemCountInAnalyze(auctionFlag, "4");
		String itemHuan = iItemInfo.getItemCountInAnalyze(auctionFlag, "5");
		String dealRate = Tools.getMoneyFormat(("" + Double.parseDouble(itemDeal)/Double.parseDouble(itemAll)*100));
		String dealRateInAlive = Tools.getMoneyFormat(("" + Double.parseDouble(itemDealInAlive)/Double.parseDouble(itemAll)*100));
		String dealRateInNet = Tools.getMoneyFormat(("" + Double.parseDouble(itemDealInNet)/Double.parseDouble(itemAll)*100));
		String passRate = Tools.getMoneyFormat(("" + Double.parseDouble(itemPass)/Double.parseDouble(itemAll)*100));
		String cheRate = Tools.getMoneyFormat(("" + Double.parseDouble(itemChe)/Double.parseDouble(itemAll)*100));
		String huanRate = Tools.getMoneyFormat(("" + Double.parseDouble(itemHuan)/Double.parseDouble(itemAll)*100));
		String itemPriceAll = iItemInfo.getItemPriceCountInAnalyze(auctionFlag, "1");
		String itemPriceAlive = iItemInfo.getItemPriceCountInAnalyze(auctionFlag, "2");
		String itemPriceNet = iItemInfo.getItemPriceCountInAnalyze(auctionFlag, "3");
		String pricedItemAlive =  iItemInfo.getPricedItemCountInAnalyze(auctionFlag, "2");
		String pricedItemNet =  iItemInfo.getPricedItemCountInAnalyze(auctionFlag, "3");
		String dealedItemCurrentPriceAll =  iItemInfo.getDealedItemCurrentPriceInAnalyze(auctionFlag, "1");
		String dealedItemCurrentPriceAlive =  iItemInfo.getDealedItemCurrentPriceInAnalyze(auctionFlag, "2");
		String dealedItemCurrentPriceNet =  iItemInfo.getDealedItemCurrentPriceInAnalyze(auctionFlag, "3");
		String dealedItemPriceAll =  iItemInfo.getDealedItemPriceInAnalyze(auctionFlag, "1");
		String dealedItemPriceAlive =  iItemInfo.getDealedItemPriceInAnalyze(auctionFlag, "2");
		String dealedItemPriceNet =  iItemInfo.getDealedItemPriceInAnalyze(auctionFlag, "3");
		String rateIncrease = Tools.getMoneyFormat("" + ((Double.parseDouble(dealedItemCurrentPriceAll)
				-Double.parseDouble(dealedItemPriceAll))/Double.parseDouble(dealedItemPriceAll)*100));

		ServletActionContext.getRequest().setAttribute("itemAll", itemAll);
		ServletActionContext.getRequest().setAttribute("itemDeal", itemDeal);
		ServletActionContext.getRequest().setAttribute("itemDealInAlive", itemDealInAlive);
		ServletActionContext.getRequest().setAttribute("itemDealInNet", itemDealInNet);
		ServletActionContext.getRequest().setAttribute("itemPass", itemPass);
		ServletActionContext.getRequest().setAttribute("itemChe", itemChe);
		ServletActionContext.getRequest().setAttribute("itemHuan", itemHuan);
		ServletActionContext.getRequest().setAttribute("dealRate", dealRate);
		ServletActionContext.getRequest().setAttribute("dealRateInAlive", dealRateInAlive);
		ServletActionContext.getRequest().setAttribute("dealRateInNet", dealRateInNet);
		ServletActionContext.getRequest().setAttribute("passRate", passRate);
		ServletActionContext.getRequest().setAttribute("cheRate", cheRate);
		ServletActionContext.getRequest().setAttribute("huanRate", huanRate);
		ServletActionContext.getRequest().setAttribute("itemPriceAll", itemPriceAll);
		ServletActionContext.getRequest().setAttribute("itemPriceAlive", itemPriceAlive);
		ServletActionContext.getRequest().setAttribute("itemPriceNet", itemPriceNet);
		ServletActionContext.getRequest().setAttribute("pricedItemAlive", pricedItemAlive);
		ServletActionContext.getRequest().setAttribute("pricedItemNet", pricedItemNet);
		ServletActionContext.getRequest().setAttribute("dealedItemCurrentPriceAll", dealedItemCurrentPriceAll);
		ServletActionContext.getRequest().setAttribute("dealedItemCurrentPriceAlive", dealedItemCurrentPriceAlive);
		ServletActionContext.getRequest().setAttribute("dealedItemCurrentPriceNet", dealedItemCurrentPriceNet);
		ServletActionContext.getRequest().setAttribute("dealedItemPriceAll", dealedItemPriceAll);
		ServletActionContext.getRequest().setAttribute("dealedItemPriceAlive", dealedItemPriceAlive);
		ServletActionContext.getRequest().setAttribute("dealedItemPriceNet", dealedItemPriceNet);
		ServletActionContext.getRequest().setAttribute("rateIncrease", rateIncrease);
		
		return "analyze";
	}
	
	public String fileResource(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "fileResource";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public AuctionInfo getAuctionInfo() {
		return auctionInfo;
	}

	public void setAuctionInfo(AuctionInfo auctionInfo) {
		this.auctionInfo = auctionInfo;
	}

	public void setiAuctionTeamType(IAuctionTeamTypeService iAuctionTeamType) {
		this.iAuctionTeamType = iAuctionTeamType;
	}

	public AuctionTeamType getAuctionTeamType() {
		return auctionTeamType;
	}

	public void setAuctionTeamType(AuctionTeamType auctionTeamType) {
		this.auctionTeamType = auctionTeamType;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}
	
	
}
