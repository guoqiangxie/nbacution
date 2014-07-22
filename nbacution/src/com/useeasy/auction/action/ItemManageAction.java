package com.useeasy.auction.action;

import java.io.File;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AfterBB;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionTeamType;
import com.useeasy.auction.bean.BeforBB;
import com.useeasy.auction.bean.ImportPersonInfo;
import com.useeasy.auction.bean.ItemDetailInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.ItemPriceRecord;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dto.ItemInfoDto;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IAuctionTeamTypeService;
import com.useeasy.auction.service.IItemDetailInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.auction.service.ImportPersonService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;


@SuppressWarnings("serial")
public class ItemManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
    
	private IAuctionInfoService iAuctionInfo;
	private IItemInfoService iItemInfo;
	private IAuctionTeamTypeService iAuctionTeamType;
	private IItemDetailInfoService  iItemDetailInfo;
	private IUploadImgInfoService iUploadImgInfo;	
	private ItemInfo itemInfo;
	private ItemDetailInfo itemDetailInfo;
	private ImportPersonService importPersonService;
	private BeforBB befor;
	private AfterBB  after;
	 
	
	public String afterPmhbb(){
		String auctionFlag=  ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		 ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		return "afterPmhbb";
	}
	public String index(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String forward = "";
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<ItemInfoDto> itemInfoDtoList = iItemInfo.getItemInfoDtoList(auctionFlag);
		//itemInfo_list = iItemInfo.getItemList(auctionFlag);
		ServletActionContext.getRequest().setAttribute("itemInfoDtoList", itemInfoDtoList);
		
		if(("0").equals(auctionInfo.getAuctionStatus())
				//&& ("0").equals(auctionInfo.getPublishFlag())   //...
				){
			ServletActionContext.getRequest().setAttribute("sortFlag", auctionInfo.getSortFlag());
			forward = "editIndex";
		}else{
			forward = "detailIndex";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return forward;
	}

	public String add(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<AuctionTeamType> auctionTeamTypeList = iAuctionTeamType.getAuctionTeamType(auctionFlag);
		ServletActionContext.getRequest().setAttribute("auctionTeamTypeList", auctionTeamTypeList);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "add";
	}
	
	public String save(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String recommendFlag = ServletActionContext.getRequest().getParameter("recommendFlag");
		if(recommendFlag == null){
			itemInfo.setRecommendFlag(null);
		}else{
			itemInfo.setRecommendFlag("1");
			List<ItemInfo> itemInfo_list_recommend = iItemInfo.getItemInfoByRecommend(auctionFlag);
			if(itemInfo_list_recommend != null && itemInfo_list_recommend.size() != 0){
				for(int i = 0; i < itemInfo_list_recommend.size(); i++){
					ItemInfo itemInfo_s = itemInfo_list_recommend.get(i);
					itemInfo_s.setRecommendFlag(null);
					iItemInfo.saveItemInfo(itemInfo_s);
				}
			}
		}
		
		String proxyPriceFlag = ServletActionContext.getRequest().getParameter("proxyPriceFlag");
		if(proxyPriceFlag == null){
			itemInfo.setProxyPriceFlag(null);
		}else{
			itemInfo.setProxyPriceFlag("1");
		}
		
		if(itemInfo.getValuationMethod() == null){
			itemInfo.setValuationMethod("0");
		}
		
		String delegatestate = ServletActionContext.getRequest().getParameter("delegatestate");
		if("1".equals(delegatestate)){
			itemInfo.setItemStatus("7");
		}else if("2".equals(delegatestate)){
			itemInfo.setItemStatus("8");
		}else{
			itemInfo.setItemStatus("0");
		}
		
		if("".equals(itemInfo.getItemPrice())){
			itemInfo.setItemPrice("0");
		}
		
		itemInfo.setId(null);
		itemInfo.setCreateTime(new Date());
		itemInfo.setUpdateTime(new Date());
		itemInfo.setDeleteFlag("0");
		itemInfo.setCompanyId(company_id);
		itemInfo.setAuctionId(auctionFlag);
		
		itemInfo.setItemCurrentPrice("0");
		itemInfo.setItemPriceRange("500");
		itemInfo.setItemPriceRangeType("1");
		itemInfo.setItemPriceRangeMode("0");
		itemInfo.setPauseFlag("0");
		
		iItemInfo.saveItemInfo(itemInfo);
		
		itemDetailInfo.setId(null);
		itemDetailInfo.setCreateTime(new Date());
		itemDetailInfo.setUpdateTime(new Date());
		itemDetailInfo.setDeleteFlag("0");
		itemDetailInfo.setItemId("" + itemInfo.getId());
		iItemDetailInfo.saveItemDetailInfo(itemDetailInfo);
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String edit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<AuctionTeamType> auctionTeamTypeList = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("auctionTeamTypeList", auctionTeamTypeList);
		
		itemDetailInfo = iItemDetailInfo.getItemDetailInfo(itemFlag);
		
		return "edit";
	}
	
	public String modify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String recommendFlag = ServletActionContext.getRequest().getParameter("recommendFlag");
		if(recommendFlag == null){
			itemInfo.setRecommendFlag(null);
		}else{
			if(!("1").equals(itemInfo.getRecommendFlag())){
				itemInfo.setRecommendFlag("1");
				List<ItemInfo> itemInfo_list_recommend = iItemInfo.getItemInfoByRecommend(itemInfo.getAuctionId());
				if(itemInfo_list_recommend != null && itemInfo_list_recommend.size() != 0){
					for(int i = 0; i < itemInfo_list_recommend.size(); i++){
						ItemInfo itemInfo_s = itemInfo_list_recommend.get(i);
						itemInfo_s.setRecommendFlag(null);
						iItemInfo.saveItemInfo(itemInfo_s);
					}
				}
			}
			
		}
		
		String proxyPriceFlag = ServletActionContext.getRequest().getParameter("proxyPriceFlag");
		if(proxyPriceFlag == null){
			itemInfo.setProxyPriceFlag(null);
		}else{
			itemInfo.setProxyPriceFlag("1");
		}
		
		if(itemInfo.getValuationMethod() == null){
			itemInfo.setValuationMethod("0");
		}
		
		String delegatestate = ServletActionContext.getRequest().getParameter("delegatestate");
		if("1".equals(delegatestate)){
			itemInfo.setItemStatus("7");
		}else if("2".equals(delegatestate)){
			itemInfo.setItemStatus("8");
		}else{
			itemInfo.setItemStatus("0");  //...
		}
		
		if("".equals(itemInfo.getItemPrice())){
			itemInfo.setItemPrice("0");
		}
		
		itemInfo.setUpdateTime(new Date());
		iItemInfo.saveItemInfo(itemInfo);
		
		itemDetailInfo.setUpdateTime(new Date());
		iItemDetailInfo.saveItemDetailInfo(itemDetailInfo);
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", itemInfo.getAuctionId());
		
		return "saved";
	}
	
	public String detail(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| (("0").equals(auctionInfo.getPublishFlag()) 
						&& ("0").equals(auctionInfo.getAuctionStatus()))
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<AuctionTeamType> auctionTeamTypeList = iAuctionTeamType.getAuctionTeamType("" + auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("auctionTeamTypeList", auctionTeamTypeList);
		
		List<UploadImgInfo> itemPicInfoList = iUploadImgInfo.getUploadImgInfoByItem("" + itemInfo.getId());
		ServletActionContext.getRequest().setAttribute("itemPicInfoList", itemPicInfoList);
		
		itemDetailInfo = iItemDetailInfo.getItemDetailInfo(itemFlag);
		
		return "detail";
	}
	
	public String delete(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		itemInfo.setDeleteFlag("1");
		iItemInfo.saveItemInfo(itemInfo);
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", itemInfo.getAuctionId());
		
		return "saved";
	}
	
	public String autoSort(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		List<ItemInfo> itemInfo_list = iItemInfo.getItemList(auctionFlag);
		if(itemInfo_list != null && itemInfo_list.size() != 0){
			for(int i = 0; i < itemInfo_list.size(); i++){
				ItemInfo itemInfo = itemInfo_list.get(i);
				itemInfo.setItemNumber("" + (i+1));
				if(i == 0)
					itemInfo.setCurrentFlag("1");
				iItemInfo.saveItemInfo(itemInfo);
			}
		}else{
			return "error";
		}
		
		auctionInfo.setSortFlag("1");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String remove(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setDeleteFlag("1");
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String openResult(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setPublishFlag("1");
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		return "saved";
	}
	
	public String closeResult(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setPublishFlag("0");
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String batchMargin(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String marginFlag = ServletActionContext.getRequest().getParameter("marginFlag");
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setMargin(marginFlag);
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String batchPriceRange(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String priceRangeFlag = ServletActionContext.getRequest().getParameter("priceRangeFlag");
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setItemPriceRange(priceRangeFlag);
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String batchCommission(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String commissionTypeFlag = ServletActionContext.getRequest().getParameter("commissionTypeFlag");
		String commissionValFlag = ServletActionContext.getRequest().getParameter("commissionValFlag");
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String[] box_val = boxesFlag.split(",");
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && ("0").equals(itemInfo.getDeleteFlag())
					 && (company_id).equals(itemInfo.getCompanyId())){
				itemInfo.setItemCommissionType(commissionTypeFlag);
				if("1".equals(commissionTypeFlag) || "2".equals(commissionTypeFlag)){
					itemInfo.setItemCommissionValue(commissionValFlag);
				}else {
					itemInfo.setItemCommissionValue("");
				}
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}

		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String batchEdit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxesFlag");
		String sortValFlag = ServletActionContext.getRequest().getParameter("sortValFlag");
		String viewOrderValFlag = ServletActionContext.getRequest().getParameter("viewOrderValFlag");
		String itemNameValFlag = ServletActionContext.getRequest().getParameter("itemNameValFlag");
		String marginValFlag = ServletActionContext.getRequest().getParameter("marginValFlag");
		String itemPriceValFlag = ServletActionContext.getRequest().getParameter("itemPriceValFlag");
		String itemPriceRangeValFlag = ServletActionContext.getRequest().getParameter("itemPriceRangeValFlag");
		
		
		String[] box_val = boxesFlag.split(",");
		String[] sortVal_val = sortValFlag.split(",");
		String[] viewOrderVal_val = viewOrderValFlag.split(",");
		String[] itemNameVal_val = itemNameValFlag.split(",");
		String[] marginVal_val = marginValFlag.split(",");
		String[] itemPriceVal_val = itemPriceValFlag.split(",");
		String[] itemPriceRangeVal_val = itemPriceRangeValFlag.split(",");
		
		for(int i = 0; i < box_val.length; i++){
			ItemInfo itemInfo = iItemInfo.getItemInfo(box_val[i]);
			if(itemInfo != null && itemInfo.getCompanyId().equals(company_id)
					 && itemInfo.getDeleteFlag().equals("0")){
				itemInfo.setItemNumber(sortVal_val[i]);
				itemInfo.setViewOrder(viewOrderVal_val[i]);
				itemInfo.setItemName(itemNameVal_val[i]);
				itemInfo.setMargin(marginVal_val[i]);
				itemInfo.setItemPrice(itemPriceVal_val[i]);
				itemInfo.setItemPriceRange(itemPriceRangeVal_val[i]);
				iItemInfo.saveItemInfo(itemInfo);
			}else{
				continue;
			}
		}
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "saved";
	}
	
	public String importItems(){//拍品导入前的页面
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "importItems";
	}
	public String importPerson(){//人员导入前的页面
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "importPerson";
	}
	public String uploadExcelPersonSuccess(){//读取EXCEL并保至数据库
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		String excelPathFlag_val = ServletActionContext.getRequest().getParameter("excelPathFlag");
		String real_path = ServletActionContext.getRequest().getSession().getServletContext().getRealPath("/");
		String physicsPath = real_path + excelPathFlag_val.substring(1,excelPathFlag_val.length());
		String table_var = ""; 
		String error_mess = "";
		String excelFlag = "";
		int rowNum = 0 ;
		try {
			String[] sheeName = {"Sheet1" };
			Workbook book = Workbook.getWorkbook(new File(physicsPath));
			Sheet currentSheet  =  book.getSheet(sheeName[0]);
			table_var = sheeName[0];
			
			if(currentSheet != null){
				rowNum= currentSheet.getRows(); 
				for(int i=1;i<rowNum;i++){
					ImportPersonInfo personInfo=new ImportPersonInfo();
					personInfo.setuName(currentSheet.getCell(0, i).getContents());
					personInfo.setuSex(currentSheet.getCell(1, i).getContents());
					personInfo.setTel(currentSheet.getCell(2, i).getContents());
					personInfo.setAddress(currentSheet.getCell(3, i).getContents());
					personInfo.setBid(currentSheet.getCell(4, i).getContents());
					personInfo.setPmh_id(auctionFlag);
					importPersonService.sava(personInfo);//把读取到的EXCEL内容保存到数据库
				 	}
				 
		 	}
		} catch (BiffException e) {
			 
			e.printStackTrace();
		} catch (IOException e) {
			 
			e.printStackTrace();
		}
		ServletActionContext.getRequest().setAttribute("error_mess", "文件导入成功！ 共有" + rowNum + "导入！");
		ServletActionContext.getRequest().setAttribute("excelFlag", "3");
		return "importPerson";
	}
	public String uploadExcelSuccess(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		String excelPathFlag_val = ServletActionContext.getRequest().getParameter("excelPathFlag");
		String real_path = ServletActionContext.getRequest().getSession().getServletContext().getRealPath("/");
		
		String physicsPath = real_path + excelPathFlag_val.substring(1,excelPathFlag_val.length());
		String[] sheeName = {"房地产","机动车","物资设备","股权","民品","文物艺术品","其他"};
		
		Map<String, ItemInfo> item_list = new HashMap<String, ItemInfo>();
		Map<String, ItemDetailInfo> itemDetail_list = new HashMap<String, ItemDetailInfo>();
		String table_var = ""; 
		String error_mess = "";
		String excelFlag = "";
		try {
			Workbook book = Workbook.getWorkbook(new File(physicsPath));
			for (int i = 0; i < sheeName.length; i++) {
				if("2".equals(excelFlag)){
					break;
				}
				Sheet currentSheet  =  book.getSheet(sheeName[i]);
				table_var = sheeName[i];
				if(currentSheet != null){
					int rowNum = currentSheet.getRows(); 
					//int colNum = currentSheet.getColumns();  
					if(rowNum > 8){
						for (int row = 8; row < rowNum-1; row++) {
							ItemInfo itemInfo = new ItemInfo();
							ItemDetailInfo itemDetailInfo = new ItemDetailInfo();
							if(currentSheet.getCell(0,row).getContents() == null || ("").equals(currentSheet.getCell(0,row).getContents())){
								continue;
							}
							String index_val = currentSheet.getCell(1,row).getContents();
							if(!Tools.checkRegen("^[1-9]{1,1}[0-9]{0,5}$", index_val)){
								error_mess = table_var + "表第" + (row+1) + "行的   '序号'  不匹配";
								excelFlag = "2";
								break;
							}
							itemInfo.setItemNumber(index_val);
							String order_val = currentSheet.getCell(2,row).getContents();
							if(!Tools.checkRegen("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*()+-【】《》（）—/]{1,20}$", order_val)){
								error_mess = table_var + "表第" + (row+1) + "行的   '显示编号'  不匹配";
								excelFlag = "2";
								break;
							}
							itemInfo.setViewOrder(order_val);
							String name_val = currentSheet.getCell(3,row).getContents();
							/*if(!Tools.checkRegen("^[\u4e00-\u9fa5a-zA-Z0-9，。、：“”.*() 【】《》（）—/]{1,300}$", name_val)){
								error_mess = table_var + "表第" + (row+1) + "行的   '拍品名称'  不匹配";
								excelFlag = "2";
								break;
							}*/
							itemInfo.setItemName(name_val);
							String number_val = currentSheet.getCell(4,row).getContents();
							if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", number_val)){
								error_mess = table_var + "表第" + (row+1) + "行的   '数量'  不匹配";
								excelFlag = "2";
								break;
							}
							itemInfo.setCountNumber(number_val);
							String unit_val = currentSheet.getCell(5,row).getContents();
							if("件".equals(unit_val)){
								itemInfo.setCountUnit("1");
							}else if("台".equals(unit_val)){
								itemInfo.setCountUnit("2");
							}else if("个".equals(unit_val)){
								itemInfo.setCountUnit("3");
							}else if("批".equals(unit_val)){
								itemInfo.setCountUnit("4");
							}else if("组".equals(unit_val)){
								itemInfo.setCountUnit("5");
							}else if("平方米".equals(unit_val)){
								itemInfo.setCountUnit("6");
							}else if("吨".equals(unit_val)){
								itemInfo.setCountUnit("7");
							}else if("千克".equals(unit_val)){
								itemInfo.setCountUnit("8");
							}else if("股".equals(unit_val)){
								itemInfo.setCountUnit("9");
							}else if("辆".equals(unit_val)){
								itemInfo.setCountUnit("10");
							}else if("其他".equals(unit_val)){
								itemInfo.setCountUnit("11");
								String qt_val = currentSheet.getCell(6,row).getContents();
								if(!Tools.checkRegen("^[\u4e00-\u9fa5a-zA-Z0-9]{1,20}$", qt_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '（单位）其他'  不匹配";
									excelFlag = "2";
									break;
								}
								itemInfo.setCountContent(qt_val);
							}else{
								error_mess = table_var + "表第" + (row+1) + "行的   '单位'  不匹配";
								excelFlag = "2";
								break;
							}
							String valuationMethod_val = currentSheet.getCell(7,row).getContents();
							if("总价".equals(valuationMethod_val)){
								itemInfo.setValuationMethod("1");
							}
							else if("单价".equals(valuationMethod_val)){
								itemInfo.setValuationMethod("2");
							}else{
								error_mess = table_var + "表第" + (row+1) + "行的   '拍卖方式'  不匹配";
								excelFlag = "2";
								break;
							}
							String referencePriceFir_val = currentSheet.getCell(8,row).getContents();
							if(!"".equals(referencePriceFir_val)){
								//if(!Tools.checkRegen("^[1-9]{1,1}[0-9]{0,10}$", referencePriceFir_val)){
								if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", referencePriceFir_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '参考价1'  不匹配";
									excelFlag = "2";
									break;
								}
							}
							itemInfo.setItemReferencePriceFir(referencePriceFir_val);
							String referencePriceSec_val = currentSheet.getCell(9,row).getContents();
							if(!"".equals(referencePriceSec_val)){
								//if(!Tools.checkRegen("^[1-9]{1,1}[0-9]{0,10}$", referencePriceSec_val)){
								if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", referencePriceSec_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '参考价2'  不匹配";
									excelFlag = "2";
									break;
								}
							}
							itemInfo.setItemReferencePriceSec(referencePriceSec_val);
							String price_val = currentSheet.getCell(10,row).getContents();
							if(!"".equals(price_val)){
								if(!Tools.checkRegen("^(0|[1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", price_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '起拍价'  不匹配";
									excelFlag = "2";
									break;
								}
							}
							itemInfo.setItemPrice(price_val);
							
							String com_type_val = currentSheet.getCell(11,row).getContents();
							String com_val_val = currentSheet.getCell(12,row).getContents();
							if("固定比率".equals(com_type_val)){
								itemInfo.setItemCommissionType("1");
								if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", com_val_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '佣金'  不匹配";
									excelFlag = "2";
									break;
								}
								itemInfo.setItemCommissionValue(com_val_val);
							}else if("定额佣金".equals(com_type_val)){
								itemInfo.setItemCommissionType("2");
								if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", com_val_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '佣金'  不匹配";
									excelFlag = "2";
									break;
								}
								itemInfo.setItemCommissionValue(com_val_val);
							}else if("执行司法规定".equals(com_type_val)){
								itemInfo.setItemCommissionType("3");
								itemInfo.setItemCommissionValue("");
							}else{
								error_mess = table_var + "表第" + (row+1) + "行的   '佣金方式'  不匹配";
								excelFlag = "2";
								break;
							}
							String margin_val = currentSheet.getCell(13,row).getContents();
							if(!Tools.checkRegen("^[1-9]{1,1}[0-9]{0,10}$", margin_val)){
								error_mess = table_var + "表第" + (row+1) + "行的   '保证金'  不匹配";
								excelFlag = "2";
								break;
							}
							itemInfo.setMargin(margin_val);
							String marginFlag_val = currentSheet.getCell(14,row).getContents();
							if("是".equals(marginFlag_val)){
								itemInfo.setMarginFlag("1");
							}else if("否".equals(marginFlag_val)){
								itemInfo.setMarginFlag("2");
							}else{
								error_mess = table_var + "表第" + (row+1) + "行的   '保证金限制'  不匹配";
								excelFlag = "2";
								break;
							}
							String basePrice_val = currentSheet.getCell(15,row).getContents();
							if(!"".equals(basePrice_val)){
								//if(!Tools.checkRegen("^[1-9]{1,1}[0-9]{0,10}$", basePrice_val)){
								if(!Tools.checkRegen("^([1-9]{1,1}[0-9]{0,10}|[0-9]{1,10}[.][0-9]{1,10})$", basePrice_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '底价'  不匹配";
									excelFlag = "2";
									break;
								}
							}
							itemInfo.setItemBasePrice(basePrice_val);
							
							String publishFlag_val = currentSheet.getCell(16,row).getContents();
							if("是".equals(publishFlag_val)){
								itemInfo.setPublishFlag("1");
							}else if("否".equals(publishFlag_val)){
								itemInfo.setPublishFlag("0");
							}else{
								error_mess = table_var + "表第" + (row+1) + "行的   '拍卖结果公开'  不匹配";
								excelFlag = "2";
								break;
							}
							
							String delegateFlag_val = currentSheet.getCell(17,row).getContents();
							//if(!"".equals(delegateFlag_val)){
								if("撤销拍卖".equals(delegateFlag_val)){
									itemInfo.setItemStatus("7");
								}else if("暂缓拍卖".equals(delegateFlag_val)){
									itemInfo.setItemStatus("8");
								}else if("无".equals(delegateFlag_val) || "".equals(delegateFlag_val)){
									itemInfo.setItemStatus("0");
								}else{
									error_mess = table_var + "表第" + (row+1) + "行的   '委托状态变更'  不匹配";
									excelFlag = "2";
									break;
								}
							//}
							
							String contentFlag_val = currentSheet.getCell(18,row).getContents();
							/*if(!"".equals(contentFlag_val)){
								if(!Tools.checkRegen("^[\u4e00-\u9fa5a-zA-Z0-9，。、：；【】《》（）—/. \n]{1,2500}$", contentFlag_val)){
									error_mess = table_var + "表第" + (row+1) + "行的   '拍品描述'  不匹配";
									excelFlag = "2";
									break;
								}
							}*/
							itemInfo.setItemDescription(contentFlag_val);
							
							//String globeEx = "^[\u4e00-\u9fa5a-zA-Z0-9:()、.”“-]{1,100}$";
							if(i == 0){
								itemInfo.setItemType("1");
								itemDetailInfo.setLb2(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setTdsyqly(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setJzmj(currentSheet.getCell(21,row).getContents());
								itemDetailInfo.setJtzk(currentSheet.getCell(22,row).getContents());
							}else if(i == 1){
								itemInfo.setItemType("2");
								itemDetailInfo.setCphm(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setCjhVIN(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setSyxz(currentSheet.getCell(21,row).getContents());
								itemDetailInfo.setBxlc(currentSheet.getCell(22,row).getContents());
								itemDetailInfo.setDjqyrq(currentSheet.getCell(23,row).getContents());
								itemDetailInfo.setPzszsf(currentSheet.getCell(24,row).getContents());
								itemDetailInfo.setPzszcs(currentSheet.getCell(25,row).getContents());
								itemDetailInfo.setPzlx(currentSheet.getCell(26,row).getContents());
								itemDetailInfo.setPmsfhpz(currentSheet.getCell(27,row).getContents());
								itemDetailInfo.setNjdqny(currentSheet.getCell(28,row).getContents());
								itemDetailInfo.setBxdqny(currentSheet.getCell(29,row).getContents());
								itemDetailInfo.setTxfdqny(currentSheet.getCell(30,row).getContents());
								itemDetailInfo.setCldjz(currentSheet.getCell(31,row).getContents());
								itemDetailInfo.setYchgz(currentSheet.getCell(32,row).getContents());
								itemDetailInfo.setXsz(currentSheet.getCell(33,row).getContents());
								itemDetailInfo.setDk(currentSheet.getCell(34,row).getContents());
								itemDetailInfo.setGzsz(currentSheet.getCell(35,row).getContents());
								itemDetailInfo.setCcs(currentSheet.getCell(36,row).getContents());
								itemDetailInfo.setHbbz(currentSheet.getCell(37,row).getContents());
							}else if(i == 2){
								itemInfo.setItemType("3");
								itemDetailInfo.setLb3(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setDw(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setSl2(currentSheet.getCell(21,row).getContents());
							}else if(i == 3){
								itemInfo.setItemType("4");
								itemDetailInfo.setLb3(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setDw(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setSl2(currentSheet.getCell(21,row).getContents());
							}else if(i == 4){
								itemInfo.setItemType("5");
								itemDetailInfo.setLb3(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setDw(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setSl2(currentSheet.getCell(21,row).getContents());
							}else if(i == 5){
								itemInfo.setItemType("6");
								itemDetailInfo.setLb1(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setZz(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setNd(currentSheet.getCell(21,row).getContents());
								itemDetailInfo.setCc(currentSheet.getCell(22,row).getContents());
								itemDetailInfo.setSl1(currentSheet.getCell(23,row).getContents());
								itemDetailInfo.setKs(currentSheet.getCell(24,row).getContents());
							}else if(i == 6){
								itemInfo.setItemType("7");
								itemDetailInfo.setLb3(currentSheet.getCell(19,row).getContents());
								itemDetailInfo.setDw(currentSheet.getCell(20,row).getContents());
								itemDetailInfo.setSl2(currentSheet.getCell(21,row).getContents());
							}else {
							}
							item_list.put(sheeName[i] + row, itemInfo);
							itemDetail_list.put(sheeName[i] + row, itemDetailInfo); 
						}
					}
				}
			}
		} catch (BiffException e) {
			excelFlag = "1";
			ServletActionContext.getRequest().setAttribute("excelFlag", excelFlag);
			return "importItems";
			//e.printStackTrace();
		} catch (IOException e) {
			excelFlag = "1";
			ServletActionContext.getRequest().setAttribute("excelFlag", excelFlag);
			return "importItems";
			//e.printStackTrace();
		}   
		if("2".equals(excelFlag)){
			ServletActionContext.getRequest().setAttribute("excelFlag", excelFlag);
			ServletActionContext.getRequest().setAttribute("error_mess", error_mess);
			return "importItems";
		}
		String key;
		Iterator<String> it = item_list.keySet().iterator();
		while (it.hasNext()){
			key = (String)it.next();
			ItemInfo itemInfo = item_list.get(key);
			itemInfo.setCreateTime(new Date());
			itemInfo.setUpdateTime(new Date());
			itemInfo.setDeleteFlag("0");
			itemInfo.setAuctionId(auctionFlag);
			itemInfo.setCompanyId(company_id);
			/*if("1".equals(itemInfo.getValuationMethod())){
				itemInfo.setCountNumber("1");
			}*/
			if("".equals(itemInfo.getItemPrice())){
				itemInfo.setItemPrice("0");
			}
			itemInfo.setTeamId("0");
			if("".equals(itemInfo.getItemStatus())){
				itemInfo.setItemStatus("0");
			}
			itemInfo.setRecommendFlag("0");
			itemInfo.setItemCurrentPrice("0");
			itemInfo.setItemPriceRange("500");
			itemInfo.setItemPriceRangeType("1");
			itemInfo.setItemPriceRangeMode("0");
			itemInfo.setPauseFlag("0");
			iItemInfo.saveItemInfo(itemInfo);
			
			ItemDetailInfo itemDetailInfo = itemDetail_list.get(key);
			itemDetailInfo.setCreateTime(new Date());
			itemDetailInfo.setDeleteFlag("0");
			itemDetailInfo.setItemId("" + itemInfo.getId());
			iItemDetailInfo.saveItemDetailInfo(itemDetailInfo);
		}
		
		auctionInfo.setSortFlag("0");
		auctionInfo.setXmlFlag("0");
		iAuctionInfo.saveAuctionInfo(auctionInfo);
		
		ServletActionContext.getRequest().setAttribute("error_mess", "文件导入成功！共有" + item_list.size() + "导入！");
		ServletActionContext.getRequest().setAttribute("excelFlag", "3");
		
		return "importItems";
	
	}
	
	public String uploadExcelFailure(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("excelFlag", "1");
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "importItems";
	}
	
	public String uploadPicAll(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		} 
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		return "uploadPicAll";
	}
	
	public String picManage(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<UploadImgInfo> itemPicInfoList = iUploadImgInfo.getUploadImgInfoByItem("" + itemInfo.getId());
		ServletActionContext.getRequest().setAttribute("itemPicInfoList", itemPicInfoList);
		
		ServletActionContext.getRequest().setAttribute("itemFlag", "" + itemInfo.getId());
		ServletActionContext.getRequest().setAttribute("auctionFlag", itemInfo.getAuctionId());
		
		return "picManage";
	}
	
	public String removePic(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "error";
		}
		
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		String boxesFlag = ServletActionContext.getRequest().getParameter("boxes_flag");
		String[] box_val = boxesFlag.split(",");
		
		for(int i = 0; i < box_val.length; i++){
			UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo(box_val[i]);
			if(uploadImgInfo != null){
				UploadImgInfo uploadImgInfoThumb = iUploadImgInfo.getUploadImgByUploadTypeAndRelationId("" + uploadImgInfo.getId(),"6");
				if(uploadImgInfoThumb != null){
					iUploadImgInfo.removeUploadImgInfo(uploadImgInfoThumb);
				}
				iUploadImgInfo.removeUploadImgInfo(uploadImgInfo);
			}else{
				continue;
			}
		}
		
		ServletActionContext.getRequest().setAttribute("itemFlag", "" + itemInfo.getId());
		ServletActionContext.getRequest().setAttribute("auctionFlag", itemInfo.getAuctionId());
		
		return "picRemoved";
	}
	
	public String uploadPic(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("itemFlag", "" + itemInfo.getId());
		
		return "uploadPic";
	}
	
	public String showPrice(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if(itemFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		ItemInfo itemInfo = iItemInfo.getItemInfo(itemFlag);
		if(itemInfo == null || ("1").equals(itemInfo.getDeleteFlag())
				|| !itemInfo.getCompanyId().equals(company_id)){
			return "error";
		}
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(itemInfo.getAuctionId()); 
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				//|| "1".equals(auctionInfo.getPublishFlag()) //...
				|| ("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		List<ItemPriceRecord> list = iItemInfo.getItemPrice(itemFlag);
		ServletActionContext.getRequest().setAttribute("itemPriceList", list);
		
		return "showPrice";
	}
	
	public String showResult(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		String bidNum = ServletActionContext.getRequest().getParameter("bidNum");
		if(auctionFlag == null || searchType == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| !("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		ServletActionContext.getRequest().setAttribute("searchType", searchType);
		ServletActionContext.getRequest().setAttribute("bidNum", bidNum);
		
		if("".equals(bidNum)){
			bidNum = null;
		}
		
		List<ItemInfo> itemInfoResult_list = iItemInfo.getItemResultList(auctionFlag, searchType , bidNum);
		ServletActionContext.getRequest().setAttribute("itemInfoResult_list", itemInfoResult_list);
		
		return "showResult"; 
	}
	
	
	public String exportPerson(){   
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		 
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		//如果拍卖ID号为空，帐号被删除了,为了能让安检局也有看到的
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag()) ){
				return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		ServletActionContext.getResponse().setContentType("application/vnd.ms-excel");
		ServletActionContext.getResponse().addHeader("Content-Disposition","attachment;filename="+Tools.dateToString(new Date(),"yyyyMMddHHmmss")+".xls");
		
		try {
			WritableWorkbook wbook = Workbook.createWorkbook(ServletActionContext.getResponse().getOutputStream());
			//建立excel文件 
			WritableSheet wsheet = wbook.createSheet("sheet", 0); //工作表名称 
			//title
			//姓名	性别	电话	住址	牌号

			wsheet.addCell(new Label(0,0,"姓名"));
			wsheet.addCell(new Label(1,0,"性别"));
			wsheet.addCell(new Label(2,0,"电话"));
			wsheet.addCell(new Label(3,0,"住址"));
			wsheet.addCell(new Label(3,0,"牌号"));
			//content
			String auctionNum = auctionInfo.getAuctionNum();
			List<ImportPersonInfo> person_list = importPersonService.getPersonResult(auctionFlag);
			ImportPersonInfo importPersonInfo=null;
			if(person_list.size() > 0){
				for (int i = 0; i < person_list.size(); i++){
					importPersonInfo  = person_list.get(i) ;
					 
							wsheet.addCell(new Label(0,i+1,importPersonInfo.getuName()));
							wsheet.addCell(new Label(1,i+1,importPersonInfo.getuSex()));
							wsheet.addCell(new Label(2,i+1,importPersonInfo.getTel()));
							wsheet.addCell(new Label(3,i+1,importPersonInfo.getAddress()));
							wsheet.addCell(new Label(3,i+1,importPersonInfo.getBid()));
				 }
			}
		 	wbook.write();
			wbook.close();
		} catch(Exception e){
			logger.info("导出xls异常");
			e.printStackTrace();
		}
		 
		return null;
	}
	
	
	public String exportExcel(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| !("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		
		ServletActionContext.getResponse().setContentType("application/vnd.ms-excel");
		ServletActionContext.getResponse().addHeader("Content-Disposition","attachment;filename="+Tools.dateToString(new Date(),"yyyyMMddHHmmss")+".xls");
		
		try {
			WritableWorkbook wbook = Workbook.createWorkbook(ServletActionContext.getResponse().getOutputStream());
			//建立excel文件 
			WritableSheet wsheet = wbook.createSheet("sheet", 0); //工作表名称 
			//title
			wsheet.addCell(new Label(0,0,"成交牌号"));
			wsheet.addCell(new Label(1,0,"拍品显示编号"));
			wsheet.addCell(new Label(2,0,"拍品成交确认书编号"));
			wsheet.addCell(new Label(3,0,"竞买人成交金额合计"));
			//content
			String auctionNum = auctionInfo.getAuctionNum();
			List<Object> itemInfoBidNum_list = iItemInfo.getBidNumResultList(auctionFlag);
			if(itemInfoBidNum_list.size() > 0){
				for (int i = 0; i < itemInfoBidNum_list.size(); i++){
					String bidNum = itemInfoBidNum_list.get(i).toString();
					if(bidNum != null){
						List<ItemInfo> itemInfoResult_list = iItemInfo.getItemResultList(auctionFlag, "1" , bidNum);
						if(itemInfoResult_list.size() > 0){
							String cellBidNum = "";  //cell one
							String cellViewOrder = "";  //cell two
							String cellAuctionViewNum = "";  //cell three
							String cellDealPriceAll = "0";  //cell four
							for (int j = 0; j < itemInfoResult_list.size(); j++){
								cellBidNum = itemInfoResult_list.get(j).getPriceBidNum();
								cellViewOrder = cellViewOrder + itemInfoResult_list.get(j).getViewOrder() + "，";
								cellAuctionViewNum = cellAuctionViewNum + (auctionNum + "-" + itemInfoResult_list.get(j).getViewOrder()) + "，";
								cellDealPriceAll = "" + (Double.parseDouble(cellDealPriceAll) + Double.parseDouble(itemInfoResult_list.get(j).getItemCurrentPrice()));  
							}
							wsheet.addCell(new Label(0,i+1,cellBidNum));
							wsheet.addCell(new Label(1,i+1,cellViewOrder));
							wsheet.addCell(new Label(2,i+1,cellAuctionViewNum));
							wsheet.addCell(new Label(3,i+1,cellDealPriceAll));
						}
					}
				}
			}
			/*if(rgArr!=null && rgArr.length>0){
				for(int i=0;i<rgArr.length;i++){
					RegisterGoodForm rg = rgArr[i];
					wsheet.addCell(new Label(0,i+1,""+(i+1)));
					wsheet.addCell(new Label(1,i+1,rg.getOnumber()));
					wsheet.addCell(new Label(2,i+1,rg.getOcname()));
					wsheet.addCell(new Label(3,i+1,rg.getOcurrentrate()));
					wsheet.addCell(new Label(4,i+1,rg.getUserName()));
					wsheet.addCell(new Label(5,i+1,rg.getBidNum()));
					String yjfs = rg.getCcname();
					if("1".equals(rg.getOcommissiontype())){
						yjfs += rg.getOcommission()+"%";
					}else if("2".equals(rg.getOcommissiontype())){
						yjfs += rg.getOcommission()+"元";
					}
					wsheet.addCell(new Label(7,i+1,yjfs));
					wsheet.addCell(new Label(8,i+1,rg.getOstate()));
				}
			}*/
		
			wbook.write();
			wbook.close();
		} catch(Exception e){
			logger.info("导出xls异常");
			e.printStackTrace();
		}
		return null;
	}
	
	
	//拍卖开始前报备跳转
	public String beforPmbb(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "error";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| !("0").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "error";
		}
		 
		ServletActionContext.getRequest().setAttribute("auctionFlag", auctionFlag);
		ServletActionContext.getRequest().setAttribute("auctionInfo", auctionInfo);
		return "beforPmbb";
	}
	//保存拍卖会前报备
	public String saveBefor(){
		iAuctionInfo.saveBeforBB(befor);
		return "auctionManage_index";
	}
	
	//保存拍卖会后报备
	public String saveAfter(){
		iAuctionInfo.saveAfter(after);
		try {
			ServletActionContext.getResponse().getWriter().print("<script>alert('保存成功');</script>");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "auctionManage_index";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}

	public void setiAuctionTeamType(IAuctionTeamTypeService iAuctionTeamType) {
		this.iAuctionTeamType = iAuctionTeamType;
	}

	public ItemInfo getItemInfo() {
		return itemInfo;
	}

	public void setItemInfo(ItemInfo itemInfo) {
		this.itemInfo = itemInfo;
	}

	public ItemDetailInfo getItemDetailInfo() {
		return itemDetailInfo;
	}

	public void setItemDetailInfo(ItemDetailInfo itemDetailInfo) {
		this.itemDetailInfo = itemDetailInfo;
	}

	public void setiItemDetailInfo(IItemDetailInfoService iItemDetailInfo) {
		this.iItemDetailInfo = iItemDetailInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public ImportPersonService getImportPersonService() {
		return importPersonService;
	}

	public void setImportPersonService(ImportPersonService importPersonService) {
		this.importPersonService = importPersonService;
	}
	public BeforBB getBefor() {
		return befor;
	}
	public void setBefor(BeforBB befor) {
		this.befor = befor;
	}
	public AfterBB getAfter() {
		return after;
	}
	public void setAfter(AfterBB after) {
		this.after = after;
	}
	
	
	
}
