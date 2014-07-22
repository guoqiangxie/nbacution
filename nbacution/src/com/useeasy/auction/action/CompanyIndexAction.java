package com.useeasy.auction.action;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;

import com.useeasy.auction.bean.AuctionBulletin;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IBulletinInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.util.BasePage;

@SuppressWarnings("serial")
public class CompanyIndexAction extends ActionSupport {
	 
	static final Logger logger = LoggerFactory.getLogger(CompanyIndexAction.class);
	
	private IAuctionInfoService iAuctionInfo;
	private ICompanyInfoService iCompanyInfo;
	private IBulletinInfoService iBulletinInfo;
	private IItemInfoService iItemInfo;
	private IUploadImgInfoService iUploadImgInfo;
	
	public String index(){logger.info("11111___________");
		String companyId = ServletActionContext.getRequest().getParameter("companyId");
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		if(companyId == null || searchType == null){
			return "sessionDestory";
		}
		
		String typeFlag = "1";
		if(("1").equals(searchType)){
			typeFlag = "1";
		}else if(("2").equals(searchType)){
			typeFlag = "11";
		}else if(("3").equals(searchType)){
			typeFlag = "12";
		}else{
			typeFlag = "1";
		}
		
		AuctionCompany auctionCompany = iCompanyInfo.getCompanyInfo(companyId);
		if(auctionCompany == null || ("1").equals(auctionCompany.getDeleteFlag())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionCompany", auctionCompany);
		
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + 
					"?companyId=" + companyId + "&searchType=" + searchType + "&";
		long count = Long.valueOf(iAuctionInfo.getAuctionInfoDtoCount(companyId, typeFlag, "5", "1"));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<AuctionInfoDto> AuctionInfoDtoList = iAuctionInfo.getAuctionInfoDtoList(companyId, typeFlag, "5", "1", basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		if(AuctionInfoDtoList != null && AuctionInfoDtoList.size() > 0){
			for(int i = 0; i < AuctionInfoDtoList.size(); i++){
				AuctionInfoDto auctionInfoDto = AuctionInfoDtoList.get(i);
				if(auctionInfoDto!=null){
			    if (iCompanyInfo!=null&&auctionInfoDto!=null&&iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName()!=null){		
			 	auctionInfoDto.setCompanyName(
						iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName());
			   
				String imgType = auctionInfoDto.getAuctionPicType();  //img type
				if(imgType!=null){
				if( "1".equals(imgType) ){  
					if(iUploadImgInfo!=null&&auctionInfoDto.getAuctionCompanyId()!=null){
						
					  UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", auctionInfoDto.getAuctionCompanyId());
					  if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
					     auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
					  }
					}
				}else if( "3".equals(imgType) ){  
					if(iUploadImgInfo!=null&&auctionInfoDto!=null&&auctionInfoDto.getId()!=null){
						UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("2", "" + auctionInfoDto.getId());
						if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
							auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						}
					 }
					
				}
				}
			  }
			}
			 }		
		}
		ServletActionContext.getRequest().setAttribute("auctionInfoList", AuctionInfoDtoList);
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<AuctionBulletin> auctionBulletinListTop = iBulletinInfo.getBulletinTopList(companyId);
		ServletActionContext.getRequest().setAttribute("auctionBulletinListTop", auctionBulletinListTop);
		
		List<Object[]> itemInfoListTop = iItemInfo.getItemInfoListTop(companyId);
		if( itemInfoListTop != null && itemInfoListTop.size() > 0){
			for(int j = 0; j < itemInfoListTop.size(); j++){
				Object[] object = itemInfoListTop.get(j);
				int length = object.length;
				String itemFlag = object[0].toString();  //item id
				List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
				if( uploadImgInfoList == null ){
					object[length-1] = "0";
					object[length-2] = "";
				}else{
					if( uploadImgInfoList.size() == 0 ){
						object[length-1] = "0";
						object[length-2] = "";
					}else if( uploadImgInfoList.size() == 1 ){
						object[length-1] = "0";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}else if( uploadImgInfoList.size() > 1 ){
						object[length-1] = "1";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("itemInfoListTop", itemInfoListTop);
		 
		return "index";
	}
	
	public String about(){logger.info("11111___________");
		String companyId = ServletActionContext.getRequest().getParameter("companyId");
		if(companyId == null){
			return "sessionDestory";
		}
		
		AuctionCompany auctionCompany = iCompanyInfo.getCompanyInfo(companyId);
		if(auctionCompany == null || ("1").equals(auctionCompany.getDeleteFlag())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionCompany", auctionCompany);
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<AuctionBulletin> auctionBulletinListTop = iBulletinInfo.getBulletinTopList(companyId);
		ServletActionContext.getRequest().setAttribute("auctionBulletinListTop", auctionBulletinListTop);
		
		List<Object[]> itemInfoListTop = iItemInfo.getItemInfoListTop(companyId);
		if( itemInfoListTop != null && itemInfoListTop.size() > 0){
			for(int j = 0; j < itemInfoListTop.size(); j++){
				Object[] object = itemInfoListTop.get(j);
				int length = object.length;
				String itemFlag = object[0].toString();  //item id
				List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
				if( uploadImgInfoList == null ){
					object[length-1] = "0";
					object[length-2] = "";
				}else{
					if( uploadImgInfoList.size() == 0 ){
						object[length-1] = "0";
						object[length-2] = "";
					}else if( uploadImgInfoList.size() == 1 ){
						object[length-1] = "0";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}else if( uploadImgInfoList.size() > 1 ){
						object[length-1] = "1";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("itemInfoListTop", itemInfoListTop);
		
		return "about";
	}
	
	public String connection(){logger.info("11111___________");
		String companyId = ServletActionContext.getRequest().getParameter("companyId");
		if(companyId == null){
			return "sessionDestory";
		}
		
		AuctionCompany auctionCompany = iCompanyInfo.getCompanyInfo(companyId);
		if(auctionCompany == null || ("1").equals(auctionCompany.getDeleteFlag())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionCompany", auctionCompany);
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<AuctionBulletin> auctionBulletinListTop = iBulletinInfo.getBulletinTopList(companyId);
		ServletActionContext.getRequest().setAttribute("auctionBulletinListTop", auctionBulletinListTop);
		
		List<Object[]> itemInfoListTop = iItemInfo.getItemInfoListTop(companyId);
		if( itemInfoListTop != null && itemInfoListTop.size() > 0){
			for(int j = 0; j < itemInfoListTop.size(); j++){
				Object[] object = itemInfoListTop.get(j);
				int length = object.length;
				String itemFlag = object[0].toString();  //item id
				List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
				if( uploadImgInfoList == null ){
					object[length-1] = "0";
					object[length-2] = "";
				}else{
					if( uploadImgInfoList.size() == 0 ){
						object[length-1] = "0";
						object[length-2] = "";
					}else if( uploadImgInfoList.size() == 1 ){
						object[length-1] = "0";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}else if( uploadImgInfoList.size() > 1 ){
						object[length-1] = "1";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("itemInfoListTop", itemInfoListTop);
		
		return "connection";
	}
	
	public String bulletin(){logger.info("11111___________");
		String companyId = ServletActionContext.getRequest().getParameter("companyId");
		if(companyId == null){
			return "sessionDestory";
		}
		
		AuctionCompany auctionCompany = iCompanyInfo.getCompanyInfo(companyId);
		if(auctionCompany == null || ("1").equals(auctionCompany.getDeleteFlag())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionCompany", auctionCompany);
		
		String currentPage = ServletActionContext.getRequest().getParameter("pageNo");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		 Pattern pattern = Pattern.compile("<.+?>", Pattern.DOTALL); 
         Matcher matchercurrentPage = pattern.matcher(currentPage); 
         String currentPagestring = matchercurrentPage.replaceAll(""); 
         
         
		ServletActionContext.getRequest().setAttribute("currentPage", currentPagestring);
		String url = ServletActionContext.getActionMapping().getName() + "?companyId=" + companyId + "&";
		long count = Long.valueOf(iBulletinInfo.getBulletinCount(companyId));
		BasePage basePage = new BasePage(count, currentPagestring, url);
		List<AuctionBulletin> auctionBulletinList = iBulletinInfo.getBulletinList(companyId, basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		ServletActionContext.getRequest().setAttribute("auctionBulletinList", auctionBulletinList);
		
		
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<AuctionBulletin> auctionBulletinListTop = iBulletinInfo.getBulletinTopList(companyId);
		ServletActionContext.getRequest().setAttribute("auctionBulletinListTop", auctionBulletinListTop);
		
		List<Object[]> itemInfoListTop = iItemInfo.getItemInfoListTop(companyId);
		if( itemInfoListTop != null && itemInfoListTop.size() > 0){
			for(int j = 0; j < itemInfoListTop.size(); j++){
				Object[] object = itemInfoListTop.get(j);
				int length = object.length;
				String itemFlag = object[0].toString();  //item id
				List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
				if( uploadImgInfoList == null ){
					object[length-1] = "0";
					object[length-2] = "";
				}else{
					if( uploadImgInfoList.size() == 0 ){
						object[length-1] = "0";
						object[length-2] = "";
					}else if( uploadImgInfoList.size() == 1 ){
						object[length-1] = "0";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}else if( uploadImgInfoList.size() > 1 ){
						object[length-1] = "1";
						object[length-2] = uploadImgInfoList.get(0).getUploadUrl();
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("itemInfoListTop", itemInfoListTop);
			
		return "bulletin";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}

	public void setiBulletinInfo(IBulletinInfoService iBulletinInfo) {
		this.iBulletinInfo = iBulletinInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

}
