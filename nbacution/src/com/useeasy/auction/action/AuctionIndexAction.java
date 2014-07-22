package com.useeasy.auction.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.useeasy.auction.dto.AuctionInfoDtoIndex;
import com.useeasy.auction.dto.CompanyInfoDto;
import com.useeasy.auction.dto.ItemInfoDto;
import com.useeasy.auction.bean.AuctionGuide;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.pmhinfo.pmhinfoserver.AuctionIndexMessageImp;
import com.useeasy.auction.service.IAuctionGuideService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.auction.vocationbean.AuctionVocationNews;
import com.useeasy.auction.vocationserver.AuctionVocationServiceImp;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class AuctionIndexAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionIndexAction.class);
    
	private IAuctionInfoService iAuctionInfo;
	private IItemInfoService iItemInfo;
	private ICompanyInfoService iCompanyInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAuctionGuideService iAuctionGuide;
	private AuctionVocationServiceImp iAuctionvocation;
	private AuctionVocationNews aun;
	private AuctionInfo m;
	  

	public AuctionVocationServiceImp getiAuctionvocation() {
		return iAuctionvocation;
	}

	public void setiAuctionvocation(AuctionVocationServiceImp iAuctionvocation) {
		this.iAuctionvocation = iAuctionvocation;
	}

	public String index(){logger.info("11111___________");
		String searchKind = ServletActionContext.getRequest().getParameter("searchKind");
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		if(searchKind == null || searchType == null)
			return "sessionDestory";
		
		String returnString = "";
		if("1".equals(searchKind)){
			returnString = "index";
		}else if("2".equals(searchKind)){
			returnString = "house";
		}else if("3".equals(searchKind)){
			returnString = "mobile";
		}else if("4".equals(searchKind)){
			returnString = "material";
		}else if("5".equals(searchKind)){
			returnString = "stock";
		}else if("6".equals(searchKind)){
			returnString = "mlpllz";
		}else if("7".equals(searchKind)){
			returnString = "art";
		}else if("8".equals(searchKind)){
			returnString = "other";
		}else if("9".equals(searchKind)){
			returnString = "special";
		}else if("10".equals(searchKind)){
			returnString = "interation";
		}else if("11".equals(searchKind)){
			returnString = "judicial";
		}else if("12".equals(searchKind)){
			returnString = "society";
		}else{
			return "sessionDestory";
		}
		if("1".equals(searchType) || "2".equals(searchType) 
				|| "3".equals(searchType) || "4".equals(searchType)
				|| "5".equals(searchType)){
		}else{
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("searchType",searchType);
		
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + 
					"?searchKind=" + searchKind + "&searchType="+ searchType + "&";
		long count = Long.valueOf(iAuctionInfo.getAuctionInfoDtoCount(null, searchKind, searchType, ("1")));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<AuctionInfoDto> AuctionInfoDtoList = iAuctionInfo.getAuctionInfoDtoList(null, searchKind, searchType, ("1"), basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		if( AuctionInfoDtoList != null && AuctionInfoDtoList.size() > 0){
			for(int i = 0; i < AuctionInfoDtoList.size(); i++){
				AuctionInfoDto auctionInfoDto = AuctionInfoDtoList.get(i);
				if(auctionInfoDto!=null){
			   if(auctionInfoDto.getAuctionCompanyId()!=null){
				 if(iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName()!=null)
					 auctionInfoDto.setCompanyName(
								iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName());
				 if(iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyInterfaceFlag()!=null){
						auctionInfoDto.setCompanyInterfaceFlag(
								iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyInterfaceFlag());
					
				 }
				;}		
				String imgType = auctionInfoDto.getAuctionPicType();  //img type
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
					
					UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("2", "" + auctionInfoDto.getId());
					if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
					   auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
					}
				}
			}
			}
		}
		
		ServletActionContext.getRequest().setAttribute("list_indexvocation", iAuctionvocation.queryshow(aun));
		//ServletActionContext.getRequest().setAttribute("index_mlist", indexmessage.query(m));
		
		
		
		
		ServletActionContext.getRequest().setAttribute("auctionInfoList", AuctionInfoDtoList);
		
		ServletActionContext.getRequest().setAttribute("allCount",
				iAuctionInfo.getAuctionInfoDtoCountInPublish(searchKind, "1"));
		
		ServletActionContext.getRequest().setAttribute("yearCount",
				iAuctionInfo.getAuctionInfoDtoCountInPublish(searchKind, "2"));
		
		ServletActionContext.getRequest().setAttribute("monthCount",
				iAuctionInfo.getAuctionInfoDtoCountInPublish(searchKind, "3"));
		
		ServletActionContext.getRequest().setAttribute("allItem",
				iItemInfo.getItemInfoCountInSearch(null, "1", ""));
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<CompanyInfoDto> companyInfoDtoList = iCompanyInfo.getCompanyInfoDtoList();
		ServletActionContext.getRequest().setAttribute("companyInfoDtoList", companyInfoDtoList);
		
		List<Object[]> itemInfoListRecommend = iItemInfo.getItemInfoListRecommend();
		if( itemInfoListRecommend != null && itemInfoListRecommend.size() > 0){
			for(int j = 0; j < itemInfoListRecommend.size(); j++){
				Object[] object = itemInfoListRecommend.get(j);
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
		ServletActionContext.getRequest().setAttribute("itemInfoListRecommend", itemInfoListRecommend);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String requestUrl = request.getRequestURL() + (request.getQueryString() == null?"":"?"+request.getQueryString());
		String requestUrl_n = "";
		try {
			requestUrl_n = java.net.URLEncoder.encode(requestUrl,"UTF-8");//瀵筓RL杩涜鍔犲瘑濡傛灉鍙傛暟涓湁涓枃鍒欏姞瀵�
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ServletActionContext.getRequest().setAttribute("requestUrl",requestUrl_n);
		
		return returnString;
	}
	
	public String auctionDetail(){logger.info("11111___________");
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if( auctionFlag == null ){
			return "sessionDestory";
		}
		
		AuctionInfoDtoIndex auctionInfoDtoIndex = iAuctionInfo.getAuctionInfoIndexDto(auctionFlag);
		if( auctionInfoDtoIndex == null 
				|| ("0").equals(auctionInfoDtoIndex.getPublishFlag()) ){
			return "sessionDestory";
		}
		auctionInfoDtoIndex.setCompanyName(
				iCompanyInfo.getCompanyInfo(auctionInfoDtoIndex.getAuctionCompanyId()).getCompanyName());
		auctionInfoDtoIndex.setCompanyInterfaceFlag(
				iCompanyInfo.getCompanyInfo(auctionInfoDtoIndex.getAuctionCompanyId()).getCompanyInterfaceFlag());
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoIndex",auctionInfoDtoIndex);
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + "?auctionFlag=" + auctionFlag + "&";
		long count = Long.valueOf(iItemInfo.getItemInfoDtoCount(auctionFlag));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<ItemInfoDto> itemInfoDtoList = iItemInfo.getItemInfoDtoList(auctionFlag, basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		if( itemInfoDtoList != null && itemInfoDtoList.size() > 0){
			for(int j = 0; j < itemInfoDtoList.size(); j++){
				ItemInfoDto itemInfoDto = itemInfoDtoList.get(j);
				String itemFlag = "" + itemInfoDto.getId();  //item id
				List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
				if( uploadImgInfoList == null ){
					if(itemInfoDto.getInterfaceImgUrl() == null ||
							"".equals(itemInfoDto.getInterfaceImgUrl())){
						itemInfoDto.setImgCountFlag("0");
						itemInfoDto.setImgUrl("");
					}else{
						itemInfoDto.setImgCountFlag("0");
						itemInfoDto.setImgUrl(itemInfoDto.getInterfaceImgUrl());
					}
				}else{
					if( uploadImgInfoList.size() == 0 ){
						itemInfoDto.setImgCountFlag("0");
						itemInfoDto.setImgUrl("");
					}else if( uploadImgInfoList.size() == 1 ){
						itemInfoDto.setImgCountFlag("0");
						itemInfoDto.setImgUrl(uploadImgInfoList.get(0).getUploadUrl());
					}else if( uploadImgInfoList.size() > 1 ){
						itemInfoDto.setImgCountFlag("1");
						itemInfoDto.setImgUrl(uploadImgInfoList.get(0).getUploadUrl());
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("itemInfoDtoList", itemInfoDtoList);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String requestUrl = request.getRequestURL() + (request.getQueryString() == null?"":"?"+request.getQueryString());
		String requestUrl_n = "";
		try {
			requestUrl_n = java.net.URLEncoder.encode(requestUrl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ServletActionContext.getRequest().setAttribute("requestUrl",requestUrl_n);
		
		return "auctionDetail";
	}
	
	public String auctionDetailAll(){logger.info("11111___________");
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if( auctionFlag == null )
			return "auctionDetailAll";
		String detailType = ServletActionContext.getRequest().getParameter("detailType");
		
		String returnVal = "";
		AuctionInfoDtoIndex auctionInfoDtoIndex = iAuctionInfo.getAuctionInfoIndexDto(auctionFlag);
		if( auctionInfoDtoIndex == null 
				|| ("0").equals(auctionInfoDtoIndex.getPublishFlag()) ){
			return "sessionDestory";
		}
		if( "1".equals(detailType) ){
			returnVal = auctionInfoDtoIndex.getAuctionBulletin();
		}else if( "2".equals(detailType) ){
			returnVal = auctionInfoDtoIndex.getAuctionNotice();
		}else if( "3".equals(detailType) ){
			returnVal = auctionInfoDtoIndex.getAuctionGuide();
		}else if( "4".equals(detailType) ){
			returnVal = auctionInfoDtoIndex.getAuctionDescription();
		}else{
			
		}
		ServletActionContext.getRequest().setAttribute("returnVal",returnVal);
		return "auctionDetailAll";
	}
	
	public String itemDetail(){logger.info("11111___________");
		String itemFlag = ServletActionContext.getRequest().getParameter("itemFlag");
		if( itemFlag == null )
			return "sessionDestory";
		
		ItemInfoDto itemInfoDto = iItemInfo.getItemInfoDto(itemFlag);
		if( itemInfoDto == null ){
			return "sessionDestory";
		}
		
		AuctionInfoDto auctionInfoDto = iAuctionInfo.getAuctionInfoDto(itemInfoDto.getAuctionId());
		if( auctionInfoDto == null 
				|| ("0").equals(auctionInfoDto.getPublishFlag()) ){
			return "sessionDestory";
		}
		auctionInfoDto.setCompanyName(
				iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName());
		auctionInfoDto.setCompanyInterfaceFlag(
				iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyInterfaceFlag());
		ServletActionContext.getRequest().setAttribute("auctionInfoDto",auctionInfoDto);
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		ServletActionContext.getRequest().setAttribute("itemInfoDto", itemInfoDto);
		
		String indexPrev = "" + (Long.parseLong(itemInfoDto.getItemNumber()) - 1);
		ItemInfoDto itemInfoDtoPrev = iItemInfo.getItemInfoDtoByIndexAndAuction(indexPrev, itemInfoDto.getAuctionId());
		if( itemInfoDtoPrev != null ){
			ServletActionContext.getRequest().setAttribute("prevFlag", ("" + itemInfoDtoPrev.getId()));
		}else{
			ServletActionContext.getRequest().setAttribute("prevFlag", "-1");
		}
		String indexNext = "" + (Long.parseLong(itemInfoDto.getItemNumber()) + 1);
		ItemInfoDto itemInfoDtoNext = iItemInfo.getItemInfoDtoByIndexAndAuction(indexNext, itemInfoDto.getAuctionId());
		if( itemInfoDtoNext != null ){
			ServletActionContext.getRequest().setAttribute("nextFlag", ("" + itemInfoDtoNext.getId()));
		}else{
			ServletActionContext.getRequest().setAttribute("nextFlag", "-1");
		}
		
		List<Object[]> itemInfoListSimilar = iItemInfo.getItemInfoListSimilar(itemInfoDto.getItemType(), "" + itemInfoDto.getId());
		ServletActionContext.getRequest().setAttribute("itemInfoListSimilar", itemInfoListSimilar);
		
		List<UploadImgInfo> uploadImgInfoList = new ArrayList<UploadImgInfo>();
		if(itemInfoDto.getInterfaceImgUrl() != null && 
				!"".equals(itemInfoDto.getInterfaceImgUrl())){  //interface
			UploadImgInfo uploadImgInfo = new UploadImgInfo();
			uploadImgInfo.setUploadUrl(itemInfoDto.getInterfaceImgUrl());
			uploadImgInfoList.add(uploadImgInfo);
		}else{
			uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
		}
		ServletActionContext.getRequest().setAttribute("uploadImgInfoList", uploadImgInfoList);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		String requestUrl = request.getRequestURL() + (request.getQueryString() == null?"":"?"+request.getQueryString());
		String requestUrl_n = "";
		try {
			requestUrl_n = java.net.URLEncoder.encode(requestUrl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ServletActionContext.getRequest().setAttribute("requestUrl",requestUrl_n);
		
		return "itemDetail";
	}
	
	public String imageDetail(){logger.info("11111___________");
		String imgUrl = ServletActionContext.getRequest().getParameter("imgUrl");
		if( imgUrl == null )
			return "sessionDestory";
		
		ServletActionContext.getRequest().setAttribute("imgUrl",imgUrl);
		return "imageDetail";
	}
	
	public String search() throws UnsupportedEncodingException{logger.info("11111___________");
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		String companyFlag = ServletActionContext.getRequest().getParameter("companyFlag");
		String auctionType = ServletActionContext.getRequest().getParameter("auctionType");
		String keyVal = ServletActionContext.getRequest().getParameter("keyVal");
		String key = java.net.URLDecoder.decode(keyVal,"UTF-8");
		if( companyFlag == null || !Tools.checkRegen("^[0-9][0-9]{0,6}$", companyFlag) ){
			return "sessionDestory";
		}
		if( auctionType == null || !Tools.checkRegen("^[0-9]{1,1}$", auctionType) ){
			return "sessionDestory";
		}
		
		String result = "";
		if( ("1").equals(searchType) ){
			result = "auctionSearch";
			String companyVal = null;
			
			String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
			if( currentPage == null || "".equals(currentPage) ){
				currentPage = "1";
			}
			ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
			String url = ServletActionContext.getActionMapping().getName() + 
					"?searchType=" + searchType + "&companyFlag="+ companyFlag + 
					"&auctionType="+ auctionType + "&keyVal="+ java.net.URLEncoder.encode(keyVal,"UTF-8") + "&";
			if(("0").equals(companyFlag)){
			}else{
				companyVal = companyFlag;
			}
			long count = Long.valueOf(iAuctionInfo.getAuctionInfoDtoCountInSearch(companyVal, auctionType, "5", ("1"), key));
			BasePage basePage = new BasePage(count, currentPage, url);
			List<AuctionInfoDto> AuctionInfoDtoList = iAuctionInfo.getAuctionInfoDtoListInSearch(companyVal, auctionType, "5", ("1"), basePage, key);
			ServletActionContext.getRequest().setAttribute("basePage", basePage);
			if( AuctionInfoDtoList != null && AuctionInfoDtoList.size() > 0){
				for(int i = 0; i < AuctionInfoDtoList.size(); i++){
					AuctionInfoDto auctionInfoDto = AuctionInfoDtoList.get(i);
					auctionInfoDto.setCompanyName(
							iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName());
					auctionInfoDto.setCompanyInterfaceFlag(
							iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyInterfaceFlag());
					String imgType = auctionInfoDto.getAuctionPicType();  //img type
					if( "1".equals(imgType) ){  
						UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", auctionInfoDto.getAuctionCompanyId());
						if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
						  auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						}
					}else if( "3".equals(imgType) ){  
						
						UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("2", "" + auctionInfoDto.getId());
						if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
						   auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						}
					}
				}
			}
			ServletActionContext.getRequest().setAttribute("auctionInfoList", AuctionInfoDtoList);
		}else if(("2").equals(searchType)){
			result = "itemSearch";
			String companyVal = null;
			
			String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
			if( currentPage == null || "".equals(currentPage) ){
				currentPage = "1";
			}
			ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
			String url = ServletActionContext.getActionMapping().getName() + 
					"?searchType=" + searchType + "&companyFlag="+ companyFlag + 
					"&auctionType="+ auctionType + "&keyVal="+ java.net.URLEncoder.encode(keyVal,"UTF-8") + "&";
			if(("0").equals(companyFlag)){
			}else{
				companyVal = companyFlag;
			}
			
			long count = Long.valueOf(iItemInfo.getItemInfoCountInSearch(companyVal, auctionType, key));
			BasePage basePage = new BasePage(count, currentPage, url);
			List<Object[]> itemInfoList = iItemInfo.getItemInfoListInSearch(companyVal, auctionType, basePage, key);
			ServletActionContext.getRequest().setAttribute("basePage", basePage);
			if( itemInfoList != null && itemInfoList.size() > 0){
				for(int j = 0; j < itemInfoList.size(); j++){
					Object[] object = itemInfoList.get(j);
					String itemFlag = "";
					if("1".equals(currentPage)){
						itemFlag = object[0].toString();  //item id
					}else{
						itemFlag = object[1].toString();  //item id
						Object[] objectNew = new Object[object.length - 1];
						for(int z = 0; z < objectNew.length; z++){
							objectNew[z] = object[z+1];
						}
						object = objectNew;
					}
					List<UploadImgInfo> uploadImgInfoList = iUploadImgInfo.getUploadImgInfoList("5", itemFlag);
					if( uploadImgInfoList == null ){
						object[object.length-1] = "0";
						object[object.length-2] = "";
					}else{
						if( uploadImgInfoList.size() == 0 ){
							object[object.length-1] = "0";
							object[object.length-2] = "";
						}else if( uploadImgInfoList.size() == 1 ){
							object[object.length-1] = "0";
							object[object.length-2] = uploadImgInfoList.get(0).getUploadUrl();
						}else if( uploadImgInfoList.size() > 1 ){
							object[object.length-1] = "1";
							object[object.length-2] = uploadImgInfoList.get(0).getUploadUrl();
						}
					}
					itemInfoList.set(j,object);
				}
			}
			ServletActionContext.getRequest().setAttribute("itemInfoList", itemInfoList);
		}else{
			result = "sessionDestory";
		}
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<CompanyInfoDto> companyInfoDtoList = iCompanyInfo.getCompanyInfoDtoList();
		ServletActionContext.getRequest().setAttribute("companyInfoDtoList", companyInfoDtoList);
		
		ServletActionContext.getRequest().setAttribute("key",key);
		ServletActionContext.getRequest().setAttribute("companyFlag",companyFlag);
		ServletActionContext.getRequest().setAttribute("auctionType",auctionType);
		
		return result;
	}
	
	public String reference(){logger.info("11111___________");
		return "reference";
	}
	
	public String about(){logger.info("11111___________");
		return "about";
	}
	
	public String map(){logger.info("11111___________");
		return "map";
	}
	
	public String guide(){logger.info("11111___________");
		String searchFlag = ServletActionContext.getRequest().getParameter("searchFlag");
		if(("1").equals(searchFlag) || ("2").equals(searchFlag)
				|| ("3").equals(searchFlag) || ("4").equals(searchFlag)){
		}else{
			return "sessionDestory";
		}
		
		List<AuctionInfoDto> auctionInfoDtoListTop = iAuctionInfo.getAuctionInfoDtoListTop();
		ServletActionContext.getRequest().setAttribute("auctionInfoDtoListTop", auctionInfoDtoListTop);
		
		List<AuctionGuide> auctionGuideList = iAuctionGuide.getAuctionGuideList(searchFlag);
		ServletActionContext.getRequest().setAttribute("auctionGuideList", auctionGuideList);
		ServletActionContext.getRequest().setAttribute("guideSearchType", searchFlag);
		
		return "guide";
	}
					
	public String guideDetail(){logger.info("11111___________");
		String guideFlag = ServletActionContext.getRequest().getParameter("guideFlag");
		if(guideFlag == null){
			return "sessionDestory";
		}
		AuctionGuide auctionGuide = iAuctionGuide.getAuctionGuide(guideFlag);
		if("1".equals(auctionGuide.getDeleteFlag())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionGuide", auctionGuide);
		return "guideDetail";
	}
	
	/*
	 * 鏇村瓒呴摼鎺�
	 */
	
	public String linkmore(){
		
		
		return "linkmore";
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

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public void setiAuctionGuide(IAuctionGuideService iAuctionGuide) {
		this.iAuctionGuide = iAuctionGuide;
	}

	
	
}
