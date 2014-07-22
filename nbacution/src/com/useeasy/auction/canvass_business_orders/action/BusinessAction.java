package com.useeasy.auction.canvass_business_orders.action;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.canvass_business_orders.bean.BusinessBean;
import com.useeasy.auction.canvass_business_orders.dao.BusinessDao;

import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
/*
 * 招商管 理
 */
public class BusinessAction   {
  private File file;
  private String fileFileName;
  private String fileFileContentType;	
  private BusinessDao businessDao;
  private BusinessBean business;
 
  /*
   * 新加界面
   */
  
  public String addUI(){
	  if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
	  return "addUI";
  }
  
  /*
   * 新加
   */
  
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
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		AuctionAdmin company =  ((SessionContainer) ActionContext.getContext().getSession().get(Constants.SESEION_LISTENER)).getAuctionAdmin();
		if(business!=null){
		   business.setCid(company.getId());
    	   business.setCompanyName(company.getAdminName());
    	   business.setCreateTime(new Date());
    	   businessDao.save(business);
		}
    	 try {
 			ServletActionContext.getResponse().sendRedirect("businessAction_getList");
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
	  return null;
  }
  /*
   * 帐号登录后查询界面,共显示20条一页
   */
  public String getList(){
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
		AuctionAdmin company =  ((SessionContainer) ActionContext.getContext().getSession().get(Constants.SESEION_LISTENER)).getAuctionAdmin();
  
	  try{
	    	String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
	    	if(pageNo==null){
	    		pageNo="1";
	    	}
	       
	        String pageSize_str=ServletActionContext.getRequest().getParameter("pageSize");
	        if(company!=null){
	        	Integer pageSize=0;
	         if(pageSize_str!=null){ 	
	    	    pageSize=Integer.valueOf(pageSize_str);
	         }else{
	        	 pageSize=20; 
	         }
	    		;
	    	String wheresql ="o.cid = ?";
	    	Object [] queryParams ={Long.valueOf(company.getId())};
	    	 
	    	String total = businessDao.getCount(wheresql, queryParams).toString();
	    	List <BusinessBean> list = businessDao.getList(Integer.valueOf(pageNo), 20, 20, wheresql, queryParams, " order by o.createTime  desc");
	    	if(total!=null){
	    	 ServletActionContext.getRequest().setAttribute("total",total); 
	    	}
	        ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
	    	ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
	    	ServletActionContext.getRequest().setAttribute("list", list);
	        }
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		return "sessionDestory";
	    		
	    	}
	 
	  return "getList";
  }
  /*
   * 首页列表显示
   */
  public String getIndexList(){
	 
	  try{
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
	    		;
	       	String total = businessDao.getCount(null, null).toString();
	    	List <BusinessBean> list = businessDao.getList(Integer.valueOf(pageNo), 20, 20, null, null, " order by o.createTime  desc");
	    	if(total!=null){
	    	 ServletActionContext.getRequest().setAttribute("total",total); 
	    	}
	        ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
	    	ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
	    	ServletActionContext.getRequest().setAttribute("list", list);
	       
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		return "sessionDestory";
	    		
	    	}
	 
	  return "getIndexList";
  }
  
  
  
  
  /*
   * 首页列表显示16条
   */
  public String getIndexListsix(){
	 
	  try{
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
	    		;
	      
	    	List <BusinessBean> list = businessDao.getList(Integer.valueOf(pageNo), 20, 20, null, null, " order by o.createTime  desc");
	    	 
	        
	    	ServletActionContext.getRequest().setAttribute("list", list);
	       
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		return "sessionDestory";
	    		
	    	}
	 
	  return null;
  }
  
  
  /*
   * 修改界面
   */

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
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
  	  String id = ServletActionContext.getRequest().getParameter("id");
    	if(id!=null&&!"".equals(id)){
    		BusinessBean notice = businessDao.get(Integer.valueOf(id));
    		ServletActionContext.getRequest().setAttribute("update", notice);
    	}
    	return "update";
  }
  /*
   * 修改
   */
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
		if(auctionAccount.getAccountType().equals("1") ){
			
		}else{
			return "sessionDestory";	
		}
	 String id = ServletActionContext.getRequest().getParameter("id");
	 String title = ServletActionContext.getRequest().getParameter("title");
	 String imgPath = ServletActionContext.getRequest().getParameter("imgPath");
	 String content =  ServletActionContext.getRequest().getParameter("content");
	  BusinessBean  bb = businessDao.get(Integer.valueOf(id));
	  bb.setTitle(title);
	  bb.setImgPath(imgPath);
	  bb.setContent(content);
	  businessDao.update(bb);
  	 try {
			ServletActionContext.getResponse().sendRedirect("businessAction_getList");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
  	return  null;
  }
  
  
  /*
   * 删除
   */
  
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
		if(auctionAccount.getAccountType().equals("1") ){
			
		}else{
			return "sessionDestory";	
		}
			String id = ServletActionContext.getRequest().getParameter("id");
			 
			if(id!=null&&!"".equals(id)){
				BusinessBean notice = businessDao.get(Integer.valueOf(id));
				if(notice!=null){
					businessDao.del(notice);
				}
			 
				ServletActionContext.getResponse().sendRedirect("businessAction_getList");
			 
			}
		} catch (Exception e) {
			return "sessionDestory";
		}
  	 return null;
  }
  
  /*
   * 获取单条信息
   */
  public String get(){
  	try {
			String id = ServletActionContext.getRequest().getParameter("id");
			if(id!=null&&!"".equals(id.trim())){
				BusinessBean notice = businessDao.get(Integer.valueOf(id));
				ServletActionContext.getRequest().setAttribute("notice", notice);
			}
		} catch (NumberFormatException e) {
			return "sessionDestory";
		}
  	
  	return "get";
  }
  
  /*
   * 首页获取单条信息
   */
  public String getIndex(){
  	try {
			String id = ServletActionContext.getRequest().getParameter("id");
			if(id!=null&&!"".equals(id.trim())){
				BusinessBean notice = businessDao.get(Integer.valueOf(id));
				ServletActionContext.getRequest().setAttribute("notice", notice);
			}
		} catch (NumberFormatException e) {
			return "sessionDestory";
		}
  	
  	return "getIndex";
  }
  
  public String upload()   {
	  if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1") ){
			
		}else{
			return "sessionDestory";	
		}
		String path = ServletActionContext.getServletContext()
		.getRealPath("/UploadImages");

		try {
			File file = new File(path);
//			if (!file.exists()){
//				file.mkdirs();
//			}
			File f = this.getFile();
//			if(this.getFileFileName().endsWith(".exe")){
//				message="对不起,你上传的文件格式不允许!!!";
//				return 	ERROR;
//			}
			FileInputStream inputStream = new FileInputStream(f);
			FileOutputStream outputStream = new FileOutputStream(path + "/"+ this.getFileFileName());
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = inputStream.read(buf)) != -1) {
				outputStream.write(buf, 0, length);
			}
			inputStream.close();
			outputStream.flush();
			outputStream.close();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");   
		response.setCharacterEncoding("UTF-8");  
		PrintWriter out =	response .getWriter();
		String msg ="{\"name\":\"/UploadImages/"+this.getFileFileName()+"\"}";
		out.print(msg.toString());
		out.flush();
		out.close();
		} catch (Exception e) {
			e.printStackTrace();
	 }
		return null;
	}

  
  
 /*
  * 点击次数
  */

  
  public String hitCount(){
	  HttpServletResponse response = ServletActionContext.getResponse();
	  response.setHeader("Cache-Control","no-store");    
	  response.setHeader("Pragma","no-cache");    
	  response.setDateHeader("Expires", 0);   

		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null&&!"".equals(id.trim())){
			BusinessBean notice = businessDao.get(Integer.valueOf(id));
			Integer count = Integer.valueOf((notice.getHitcount()));
			count=count+1;
			System.out.println(count);
			notice.setHitcount(count.toString());
			businessDao.update(notice);
		}
		
		try {
			PrintWriter out = response.getWriter();
			out.print("ok");
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  return null;
  }
 
public File getFile() {
	return file;
}

public void setFile(File file) {
	this.file = file;
}

public String getFileFileName() {
	return fileFileName;
}

public void setFileFileName(String fileFileName) {
	this.fileFileName = fileFileName;
}

public String getFileFileContentType() {
	return fileFileContentType;
}

public void setFileFileContentType(String fileFileContentType) {
	this.fileFileContentType = fileFileContentType;
}

 

public BusinessDao getBusinessDao() {
	return businessDao;
}

public void setBusinessDao(BusinessDao businessDao) {
	this.businessDao = businessDao;
}

public BusinessBean getBusiness() {
	return business;
}

public void setBusiness(BusinessBean business) {
	this.business = business;
}
  
  
  
  
}
