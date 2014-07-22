package com.useeasy.auction.action;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

@SuppressWarnings("serial")
public class BiddingManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AuctionLoginAction.class);
    
	private IAuctionInfoService iAuctionInfo;
	private IItemInfoService iItemInfo;
	private IUploadImgInfoService iUploadImgInfo;
	
	
	public String toXml() throws FileNotFoundException, IOException{
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null  
			|| !("0").equals(auctionInfo.getAuctionStatus())
			|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			ServletActionContext.getRequest().setAttribute("xmlFlag", "5");
			return "toXml";
		}
		if(("1").equals(auctionInfo.getXmlFlag())){
			ServletActionContext.getRequest().setAttribute("xmlFlag", "3");
			return "toXml";
		}
		
		if(("0").equals(auctionInfo.getSortFlag())){
			List<ItemInfo> itemInfo_list = iItemInfo.getItemList(auctionFlag);
			if(itemInfo_list != null && itemInfo_list.size() != 0){
				for(int i = 0; i < itemInfo_list.size(); i++){
					ItemInfo itemInfo = itemInfo_list.get(i);
					itemInfo.setItemNumber("" + (i+1));
					if(i == 0)
						itemInfo.setCurrentFlag("1");
					iItemInfo.saveItemInfo(itemInfo);
				}
			}else {
				ServletActionContext.getRequest().setAttribute("xmlFlag", "2");
				return "toXml";
			}
		}
		auctionInfo.setSortFlag("1");
		
		Element root = new Element("itemList");   
        // 根节点添加到文档中  
        Document Doc = new Document(root);  
        List<ItemInfo> list = iItemInfo.getItemList(auctionFlag);
        for(int i = 0; i < list.size(); i++){
        	Element elements = new Element("item");
        	ItemInfo itemInfo = list.get(i);
        	
        	elements.addContent(new Element("id").setText("" + itemInfo.getId()));  
        	elements.addContent(new Element("indexId").setText(itemInfo.getItemNumber()));
        	elements.addContent(new Element("viewOrder").setText(itemInfo.getViewOrder()));
        	elements.addContent(new Element("itemName").setText(itemInfo.getItemName()));
        	//elements.addContent(new Element("itemPrice").setText(itemInfo.getItemPrice()));
        	//elements.addContent(new Element("itemCommissionType").setText(itemInfo.getItemCommissionType()));
        	//elements.addContent(new Element("itemCommissionPrice").setText(itemInfo.getItemCommissionValue()));
        	//elements.addContent(new Element("countNumber").setText(itemInfo.getCountNumber()));
        	elements.addContent(new Element("countUnit").setText(itemInfo.getCountUnit()));
        	elements.addContent(new Element("countContent").setText(itemInfo.getCountContent()));
        	//elements.addContent(new Element("valuationMethod").setText(itemInfo.getValuationMethod()));
        	//elements.addContent(new Element("margin").setText(itemInfo.getMargin()));
        	elements.addContent(new Element("itemDescription").setText(itemInfo.getItemDescription()));
        	
        	List<UploadImgInfo> imgList = iUploadImgInfo.getUploadImgInfoByItem("" + itemInfo.getId());
        	if(imgList == null || imgList.size() == 0){
        		elements.addContent(new Element("item_pic_url").setText(""));
        	}else{
        		UploadImgInfo uploadImgInfo = imgList.get(0);
            	if(uploadImgInfo != null && uploadImgInfo.getRelationId() != null){
            		UploadImgInfo uploadImgInfo_s = iUploadImgInfo.getUploadImgByUploadTypeAndRelationId("" + uploadImgInfo.getId(),"6");
            		if(uploadImgInfo_s != null){
            			elements.addContent(new Element("item_pic_url").setText(uploadImgInfo_s.getUploadUrl())); 
            		}else
                		elements.addContent(new Element("item_pic_url").setText(""));
            	}else
            		elements.addContent(new Element("item_pic_url").setText(""));
        	}
        	
        	root.addContent(elements);
        	
        }
        XMLOutputter XMLOut = new XMLOutputter(); 
        Format format = Format.getPrettyFormat(); 
        format.setEncoding("UTF-8"); 
        XMLOut.setFormat(format);
        //输出 xml 文件
        String path = ServletActionContext.getRequest().getSession().getServletContext().getRealPath("/");
        String uploadPath = "\\uploadFile\\xml\\";
        File uploadFile = new File(path + uploadPath);
		if (!uploadFile.exists()) {
			uploadFile.mkdirs();
		}
		
        String xmlNum = RandomStringUtils.random(20, true, true);
        XMLOut.output(Doc, new FileOutputStream(path + uploadPath + "/pmh" + xmlNum + ".xml"));
        
        String controllerNum = RandomStringUtils.random(20, true, true);
        
        auctionInfo.setXmlFlag("1");
        auctionInfo.setXmlNumFlag(xmlNum);
        auctionInfo.setControllerNumFlag(controllerNum);
        iAuctionInfo.saveAuctionInfo(auctionInfo);
        
        ServletActionContext.getRequest().setAttribute("xmlFlag", "1");
        return "toXml";
	}

	public String controller(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| "0".equals(auctionInfo.getXmlFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("userId", sessionContainer.getAuctionAccount().getId());
		ServletActionContext.getRequest().setAttribute("auctionName", auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("auctionNum", auctionInfo.getControllerNumFlag());
		ServletActionContext.getRequest().setAttribute("videoNum", auctionInfo.getAuctionNum());
		ServletActionContext.getRequest().setAttribute("xmlNum", auctionInfo.getXmlNumFlag());
		return "controller";
	}

	public String console(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| "0".equals(auctionInfo.getXmlFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("userId", sessionContainer.getAuctionAccount().getId());
		ServletActionContext.getRequest().setAttribute("auctionName", auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("auctionNum", auctionInfo.getControllerNumFlag());
		ServletActionContext.getRequest().setAttribute("xmlNum", auctionInfo.getXmlNumFlag());
		return "console";
	}
	
	public String bigConsole(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
			.getSession().get(Constants.SESEION_LISTENER);
		String company_id = "" + sessionContainer.getAuctionCompany().getId();
		
		AuctionInfo auctionInfo = iAuctionInfo.getAuctionInfo(auctionFlag);
		if(auctionInfo == null || ("1").equals(auctionInfo.getDeleteFlag())
				|| "0".equals(auctionInfo.getXmlFlag()) 
				|| ("2").equals(auctionInfo.getAuctionStatus())
				|| !(company_id).equals(auctionInfo.getAuctionCompanyId())){
			return "sessionDestory";
		}
		ServletActionContext.getRequest().setAttribute("auctionId", auctionInfo.getId());
		ServletActionContext.getRequest().setAttribute("userId", sessionContainer.getAuctionAccount().getId());
		ServletActionContext.getRequest().setAttribute("auctionName", auctionInfo.getAuctionName());
		ServletActionContext.getRequest().setAttribute("auctionNum", auctionInfo.getControllerNumFlag());
		ServletActionContext.getRequest().setAttribute("xmlNum", auctionInfo.getXmlNumFlag());
		return "bigConsole";
	}
	
	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiItemInfo(IItemInfoService iItemInfo) {
		this.iItemInfo = iItemInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}
	
	
}
