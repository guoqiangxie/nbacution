package com.useeasy.auction.pmhinfo.pmhinfoaction;

 

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.struts2.ServletActionContext;
 
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.pmhinfo.pmhinfoserver.AuctionIndexMessageImp;
 

public class AuctionindexmessageAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private AuctionIndexMessageImp amp;
	
	public AuctionIndexMessageImp getAmp() {
		return amp;
	}

	public void setAmp(AuctionIndexMessageImp amp) {
		this.amp = amp;
	}
	private AuctionInfo  auctionInfo;
	
	public String query(){
		// ServletActionContext.getRequest().setAttribute("all_indexm_query", amp.query_all(auctionInfo));
		return "query";
	}
	/**
     * 首页更多
     * */
	public String query_all(){
		String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
       
        String pageSize_str=ServletActionContext.getRequest().getParameter("pageSize");
      
        	Integer pageSize=0;
         if(pageSize_str!=null){ 	
    	    pageSize=Integer.valueOf(pageSize_str);
         }else{
        	 pageSize=20; 
         }
		 ServletActionContext.getRequest().setAttribute("total",amp.getCount().get(0).toString()); 
	     ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
	     ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
		ServletActionContext.getRequest().setAttribute("pageSize", "20");
		ServletActionContext.getRequest().setAttribute("all_indexm_queryall", amp.query_all(pageSize,20,Integer.valueOf(pageNo)));
		return "query_all";
		
	}
	/**
     * 首页单独查询
     * */
   public String queryid() throws Exception{
	   Long id =Long.valueOf(ServletActionContext.getRequest().getParameter("id"));


	   if(id==0){
		  return null; 
	   }else{
		   ItemInfo item = amp.query_all(id);
		   ServletActionContext.getRequest().setAttribute("item",item);
		 
		   return "query_id";
		   
	   }
	  
   }
   
   
   
   /**
    * 首页弹出单独查询
    * */
  public String queryid_show() throws Exception{
	   int id =Integer.parseInt(ServletActionContext.getRequest().getParameter("id"));


	   if(id==0){
		  return null; 
	   }else{
		   ItemInfo item = amp.query_all(id);
			UploadImgInfo uploadinfo = amp.getUploadImgByUploadTypeAndRelationId(String.valueOf(id), "5");
		   ServletActionContext.getRequest().setAttribute("item",item);
			if (!(uploadinfo == null)) {
				item.setImgUrl(uploadinfo.getUploadUrl());
			}
			 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String auctionStarttime = sdf.format(item.getAuctionStartTime());
			
		
			ServletActionContext.getRequest().setAttribute("auctionStarttime",
					auctionStarttime);
		   return "query_show";
		   
	   }
	  
  }
   
   
     /**
      * 首页按类别查询
      * */
   public String querytype(){
	   String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
   	if(pageNo==null){
   		pageNo="1";
   	}
      
       String pageSize_str=ServletActionContext.getRequest().getParameter("pageSize");
     
       	Integer pageSize=0;
        if(pageSize_str!=null){ 	
   	    pageSize=Integer.valueOf(pageSize_str);
        }else{
       	 pageSize=20; 
        }
        /**
         * 去HTML标签
         */
         String type=ServletActionContext.getRequest().getParameter("no");
         Pattern pattern = Pattern.compile("<.+?>", Pattern.DOTALL); 
         Matcher matchertype = pattern.matcher(type); 
         String typestring = matchertype.replaceAll(""); 

		 ServletActionContext.getRequest().setAttribute("total",amp.gettypeont(typestring).get(0).toString()); 
	     ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
	     ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
		ServletActionContext.getRequest().setAttribute("pageSize", "20");
	   
	    if(type.equals("")||type==null){
	    	return null;
	    }else{
	    	 ServletActionContext.getRequest().setAttribute("type_list", amp.querytype(type,pageSize,20,Integer.valueOf(pageNo)));
	  	   return "querytype";
	    }
	   
   }
   
   /*
    * 首页展示列表
    */
   
   @SuppressWarnings("unchecked")
public String getList(){
	 List<ItemInfo> list = amp.query(null, 1,10);
	 ServletActionContext.getRequest().setAttribute("list",list);
	   return null;
   }
}
