package com.useeasy.auction.notice.action;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.notice.bean.AuctionNotice;
import com.useeasy.auction.notice.dao.AuctionNoticeDao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

public class AuctionNoticeAction extends ActionSupport {
 
	private static final long serialVersionUID = 1L;
    private AuctionNoticeDao auctionNoticeDao;
    private AuctionNotice notice;
    private String cid;
    public String addUI(){
    	return "addUI";
    }
    
    public String add(){
    	if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
    	 
    	AuctionCompany company =  ((SessionContainer) ActionContext.getContext()
  				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
     
    	if(notice!=null){
    	notice.setCompany(company.getCompanyName());
    	 
    	notice.setUid(company.getId());
    	auctionNoticeDao.save(notice);
    	}
    	 try {
			ServletActionContext.getResponse().sendRedirect("noticeAction_getCPlist");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }
    
    public String delete(){
    	try {
    		if(((SessionContainer) ActionContext.getContext()
    				.getSession().get(Constants.SESEION_LISTENER))==null){
    			return "sessionDestory";
    		}
    		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
    				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
    		if(auctionAccount ==null){
    			return "sessionDestory";
    		}
    		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
    			
    		}else{
    			return "sessionDestory";	
    		}
			String id = ServletActionContext.getRequest().getParameter("id");
			 
			if(id!=null&&!"".equals(id)){
				AuctionNotice notice = auctionNoticeDao.get(Long.valueOf(id));
				if(notice!=null){
				   auctionNoticeDao.del(notice);
				}
			 
				ServletActionContext.getResponse().sendRedirect("noticeAction_getCPlist");
			 
			}
		} catch (Exception e) {
			return "sessionDestory";
		}
    	 return null;
    }
    
    public String get(){
    	try {
			String id = ServletActionContext.getRequest().getParameter("id");
			if(id!=null&&!"".equals(id.trim())){
				AuctionNotice notice = auctionNoticeDao.get(Long.valueOf(id));
				ServletActionContext.getRequest().setAttribute("notice", notice);
			}
		} catch (NumberFormatException e) {
			return "sessionDestory";
		}
    	
    	return "get";
    }
    
    /**
     * 网络拍卖行业会员单位公告
     *  getGGList公告列表
     */
    public String getGGList(){
    	try{
    	String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
       
        String pageSize_str=ServletActionContext.getRequest().getParameter("pageSize");
        if(cid!=null){
        	Integer pageSize=0;
         if(pageSize_str!=null){ 	
    	    pageSize=Integer.valueOf(pageSize_str);
         }else{
        	 pageSize=20; 
         }
    		;
    	String wheresql ="o.uid = ?";
    	Object [] queryParams ={Long.valueOf(cid)};
    	 
    	String total = auctionNoticeDao.getCount(wheresql, queryParams).toString();
    	List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf(pageNo), 20, 20, wheresql, queryParams, " order by o.createtime  desc");
    	if(total!=null){
    	 ServletActionContext.getRequest().setAttribute("total",total+""); 
    	}
        ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
    	ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
    	ServletActionContext.getRequest().setAttribute("list", list);
        }
    	}catch(Exception e){
    		e.printStackTrace();
    		return "sessionDestory";
    		
    	}
    	 return null;
    }
    
    
    /**
     * 网络拍卖行业会员单位公告
     *  左边显示的5条
     */
    public String getNoticeFive(){
    	try{
    	 
      
     
        if(cid!=null){
        System.out.println(cid);
    	String wheresql ="o.uid = ?";
    	Object [] queryParams ={Long.valueOf(cid)};
    	List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf("1"), 5, 5, wheresql, queryParams, " order by o.createtime  desc");
     	ServletActionContext.getRequest().setAttribute("list", list);
        }
    	}catch(Exception e){
    		e.printStackTrace();
    		return "sessionDestory";
    		
    	}
    	 return null;
    }
    
    /*
     *  拍卖公司列表显示所发的公告
     */
    public String getCPlist(){
    	if( ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)==null){
    		 return "sessionDestory";
		 }
    	AuctionAccount auctionAccount= ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
    	
    	  if(auctionAccount==null){
			 return "sessionDestory";
		}else if(!auctionAccount.getAccountType().equals("2")){
			 return "sessionDestory";
		}
    	String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
    	AuctionCompany company= ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
    	Integer pageSize=20;
    	String wheresql ="o.uid = ?";
    	Object [] queryParams ={company.getId()};
    	String total =auctionNoticeDao.getCount(wheresql, queryParams).toString();
    	List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf(pageNo), pageSize, 20, wheresql, queryParams, " order by o.createtime desc");
    	if(total!=null){
    	 ServletActionContext.getRequest().setAttribute("total",total+""); 
    	}
        ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
    	ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
    	ServletActionContext.getRequest().setAttribute("list", list);
    	 
    	return "cindex";
    }
    /*
     * 首页展示用
     */
    public String getlist(){
    	 
    	String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
    	Integer pageSize=20;
     
    	 
    	String total = auctionNoticeDao.getCount(null, null).toString();
    	List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf(pageNo), pageSize, 20, null, null, " order by o.createtime  desc");
    	if(total!=null){
    	 ServletActionContext.getRequest().setAttribute("total",total+""); 
    	}
        ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
    	ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
    	ServletActionContext.getRequest().setAttribute("list", list);
    	 
    	return "index";
    }
    
    public String updateUI(){
    	if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
    	  String id = ServletActionContext.getRequest().getParameter("id");
      	if(id!=null&&!"".equals(id)){
      		AuctionNotice notice = auctionNoticeDao.get(Long.valueOf(id));
      		ServletActionContext.getRequest().setAttribute("update", notice);
      	}
      	return "update";
    }
    public String update(){
    	if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
    	auctionNoticeDao.update(notice);
    	 try {
  			ServletActionContext.getResponse().sendRedirect("noticeAction_getCPlist");
  		} catch (IOException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
    	return  null;
    }
    
    /*
     * getindextop获取首页前几条公告内容
     */
    
    public String getindextop(){
    	String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
     
    	Integer pageSize=5;
       	List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf(pageNo), pageSize, 5, null, null, " order by o.createtime desc");
    	 
    	ServletActionContext.getRequest().setAttribute("list", list);
    	return null;
    }
    
    public String geAll(){
    	try {
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
    
			 
			String total = auctionNoticeDao.getCount(null, null).toString();
			List <AuctionNotice> list = auctionNoticeDao.getList(Integer.valueOf(pageNo), pageSize, 20, null, null, " order by o.createtime  desc");
			 
			 ServletActionContext.getRequest().setAttribute("total",total+""); 
			
			ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
			ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
			ServletActionContext.getRequest().setAttribute("list", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return "geAll";
    }
    
    /*
     * 公告挂接
     */
    
    public String guajieGongGao(){
    	if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		AuctionCompany company = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
		if(company ==null){
			return "sessionDestory";
		}
		String wherejpql = "  o.uid=?";
		Object [] queryParams ={company.getId()};
		List<AuctionNotice> list = auctionNoticeDao.getList(1, 20, 20, wherejpql, queryParams, "  order by o.createtime desc");
		StringBuffer sff = new StringBuffer();
		sff.append("<select id='pmhlist' name='gongGaoId'>");
		sff.append("<option >").append("请选择公告").append("</option>");
		for(AuctionNotice info : list){
			sff.append("<option value='").append(info.getId()).append("'>").append(info.getTitle()).append("</option>");
		}
		sff.append("</select>");
	    HttpServletResponse response = ServletActionContext.getResponse();
	    response.setContentType("text/html;charset=UTF-8");   
		response.setCharacterEncoding("UTF-8"); 
		PrintWriter out  =null;
		try {
			  out = response.getWriter();
			  out.print(sff.toString());
		} catch (Exception e) {
			 
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.flush();
				out.close();
			}
			
		}
    	return null;
    }
    
	public AuctionNoticeDao getAuctionNoticeDao() {
		return auctionNoticeDao;
	}
	public void setAuctionNoticeDao(AuctionNoticeDao auctionNoticeDao) {
		this.auctionNoticeDao = auctionNoticeDao;
	}

	public AuctionNotice getNotice() {
		return notice;
	}

	public void setNotice(AuctionNotice notice) {
		this.notice = notice;
	}
    
    
 
	public void validateAdd() {//notice.notice_content  notice.createtime  notice.pmhName
		if(notice.getTitle()==null){
			this.addFieldError("notice.title", "公告标题为必填且不能超过50汉字");
		}else if(notice.getTitle().trim().equals("")||notice.getTitle().length()>100){
			this.addFieldError("notice.title", "公告标题为必填且不能超过50汉字");
			 
		}if(notice.getCreatetime()==null){
			this.addFieldError("notice.createtime", "拍卖时间不为空");
		}if(notice.getPmhName()==null){
			this.addFieldError("notice.createtime", "拍卖会名称不能为空");
 		}//if(notice.getNotice_content().length()>6000){
		//	this.addFieldError("notice.notice_content", "公告内容过长");
		//}
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	 
    
}
