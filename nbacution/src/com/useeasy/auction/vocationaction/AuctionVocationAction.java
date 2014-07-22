package com.useeasy.auction.vocationaction;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
 
import com.useeasy.auction.vocationbean.AuctionVocationNews;
import com.useeasy.auction.vocationserver.AuctionVocationServiceImp;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;

public class AuctionVocationAction extends ActionSupport  {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static final Logger logger = LoggerFactory.getLogger(AuctionVocationAction.class);
	  private File file;
	  private String fileFileName;
	  private String fileFileContentType;
	  private AuctionVocationNews auctionVocationNews;
	  public AuctionVocationNews getAuctionVocationNews() {
		return auctionVocationNews;
	}

	public void setAuctionVocationNews(AuctionVocationNews auctionVocationNews) {
		this.auctionVocationNews = auctionVocationNews;
	}

	public static Logger getLogger() {
		return logger;
	}




	private AuctionVocationServiceImp vocationService;
	
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

    
	public AuctionVocationServiceImp getVocationService() {
		return vocationService;
	}

	public void setVocationService(AuctionVocationServiceImp vocationService) {
		this.vocationService = vocationService;
	}
	
	/**
	 *管理页行业动态
	 * */
	@SuppressWarnings("unchecked")
	public String vocationmangerindex(){
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
			     
					 ServletActionContext.getRequest().setAttribute("total",vocationService.queryvocationcont().get(0).toString()); 
				     ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
				     ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
					ServletActionContext.getRequest().setAttribute("pageSize", "20");
			 
			  List list=vocationService.queryall(pageSize,20,Integer.valueOf(pageNo));
			 ServletActionContext.getRequest().setAttribute("vocation_list_all", list);
		
		return "add";
	}
	/**
	 * 添加页面
	 * */
  public String index_add(){
	  logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "index_addvocation";
	}
	
  
  /**
	 * 管理页修改页面
	 * */
  public String update_manager(){
	  logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
	  List list=vocationService.queryid(Long.parseLong(ServletActionContext.getRequest().getParameter("id")));
	  ServletActionContext.getRequest().setAttribute("vocation_list_lone", list);
		return "update_manager";
	}
  
  
	/**
	 * 管理页添加行业信息
	 * */
	
	public String add(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		 vocationService.addvocationnews(auctionVocationNews) ;
			  try {
				ServletActionContext.getResponse().sendRedirect("auctionIndexVocationnews_vocationmangerindex");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}
	/**
	 *管理页 删除行业信息
	 * */
	public String delete(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		if(ServletActionContext.getRequest().getParameter("id")!=null||ServletActionContext.getRequest().getParameter("id")!="")
		{
		if(vocationService.deletevocationnews(vocationService.get(Long.parseLong(ServletActionContext.getRequest().getParameter("id"))))){
			//ServletActionContext.getRequest().setAttribute("vocation_list_all", vocationService.queryall(auctionVocationNews));
            try {
				ServletActionContext.getResponse().sendRedirect("auctionIndexVocationnews_vocationmangerindex");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		}
		return null;
	}
	
	/**
	 * 管理页全查
	 * */
	 public String queryall(){
		 
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
		     
				 ServletActionContext.getRequest().setAttribute("total",vocationService.queryvocationcont().get(0).toString()); 
			     ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
			     ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
				ServletActionContext.getRequest().setAttribute("pageSize", "20");
		 
		  List list=vocationService.queryall(pageSize,20,Integer.valueOf(pageNo));
		 ServletActionContext.getRequest().setAttribute("vocation_list_gall", list);
		 return "add";
	 }

	 
	 
	 
	 
	 
	 /**
	  * 首页信息全查
	  * */
	 public String indexquery(){
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
		     
				 ServletActionContext.getRequest().setAttribute("total",vocationService.queryvocationcont().get(0).toString()); 
			     ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
			     ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
				ServletActionContext.getRequest().setAttribute("pageSize", "20");
		 List list=vocationService.indexqueryall(pageSize,20,Integer.valueOf(pageNo));
		 ServletActionContext.getRequest().setAttribute("vocation_index_gall", list);
		 return "indexqueryall";
	 }
	 
	 /**
	  * 首页单独动态信息（带点击率）
	  * */
	 
	 public String indexsilgevocation(){
		 
		 List list= vocationService.queryid(Long.parseLong(ServletActionContext.getRequest().getParameter("id")));
		   Iterator iterator=list.iterator();
		   while(iterator.hasNext()){
			   AuctionVocationNews  auctionVocationNews=(AuctionVocationNews)iterator.next();
			   long count=auctionVocationNews.getVnewsviewtime();
			   count+=1;
			   auctionVocationNews.setVnewsviewtime(count);
			   String  content=auctionVocationNews.getVnewscontent().replace("<p>", "");
			   String content1=content.replace("</p>", "");
			   auctionVocationNews.setVnewscontent(content1);
			   auctionVocationNews.setVnewsid(auctionVocationNews.getVnewsid());
			   vocationService.updatevocationnews(auctionVocationNews);
		   }
		 ServletActionContext.getRequest().setAttribute("vocation_list_lone", vocationService.queryid(Long.parseLong(ServletActionContext.getRequest().getParameter("id"))));
		 return "indexsinglemessage";
	 }

	 /**
	  * 管理修改
	  * */
	 public String update(){
		 logger.info("" + ((SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
	 if(vocationService.updatevocationnews(auctionVocationNews)){
			 try {
				ServletActionContext.getResponse().sendRedirect("auctionIndexVocationnews_vocationmangerindex");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			  
		  }
		 return null;
	 }
	 
	 /**
	   * 管理修改单独信息
	   * */
	 public String queryid(){
		 logger.info("" + ((SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		 ServletActionContext.getRequest().setAttribute("vocation_list_lone", vocationService.queryid(Long.parseLong(ServletActionContext.getRequest().getParameter("id"))));
		 return "update_manager";
	 }
	 
	 /**
	   * 管理里修改单独信息
	   * */
   public String indexqueryid(){		 
		 ServletActionContext.getRequest().setAttribute("vocation_list_lone", vocationService.queryid(Long.parseLong(ServletActionContext.getRequest().getParameter("id"))));
		 return "";
	 }
	 /**
	   * 首页
	   * */
	 public String queryindex(){
		 ServletActionContext.getRequest().setAttribute("vocation_list_show", vocationService.queryshow(auctionVocationNews));
		 return "longall";
	 }
	 


/**
    * 异步上传图片
    * */
	 public String upload()   {
			
			String path = ServletActionContext.getServletContext()
			.getRealPath("/UploadImages");

			try {
				File file = new File(path);
//				if (!file.exists()){
//					file.mkdirs();
//				}
				File f = this.getFile();
//				if(this.getFileFileName().endsWith(".exe")){
//					message="对不起,你上传的文件格式不允许!!!";
//					return 	ERROR;
//				}
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
				//message= "/UploadImages/"+ this.getFileFileName();
			 
			} catch (Exception e) {
				e.printStackTrace();
				 
			 
				 
			}
			return null;
		}

	
}
