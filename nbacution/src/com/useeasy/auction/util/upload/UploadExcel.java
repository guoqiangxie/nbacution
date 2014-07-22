package com.useeasy.auction.util.upload;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.RandomStringUtils;

import com.useeasy.frame.util.Tools;


@SuppressWarnings("serial")
public class UploadExcel extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws IOException, ServletException {
		request.getRequestDispatcher("index.jsp").forward(request,response);
	}
	
	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String auctionFlag = request.getParameter("auctionFlag");
		if(auctionFlag == null){
			request.getRequestDispatcher("index.jsp").forward(request,response);
		}
		
		String basePath = request.getSession().getServletContext().getRealPath("/");
		String PersonFlag=request.getParameter("PersonFlag");
		 
		String uploadPath=null;
		String tempPath=null;
	  
		if(PersonFlag!=null&&PersonFlag.equals("1")){
			
			  uploadPath = "\\uploadFile\\file\\imPerson\\excel\\"; 
			  tempPath = "\\uploadFile\\file\\imPerson\\excel\\temp\\"; 
			  		   
		}else{
		     uploadPath = "\\uploadFile\\file\\excel\\"; 
		     tempPath = "\\uploadFile\\file\\excel\\temp\\"; 
		}  
		File uploadFile = new File(basePath + uploadPath);
		if (!uploadFile.exists()) {
			uploadFile.mkdirs();
		}
		File tempPathFile = new File(basePath + tempPath);
		if (!tempPathFile.exists()) {
			tempPathFile.mkdirs();
		}
		
		try {
			// Create a factory for disk-based file items
			DiskFileItemFactory factory = new DiskFileItemFactory();

			// Set factory constraints
			factory.setSizeThreshold(4096); 
			factory.setRepository(tempPathFile);
			
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("UTF-8");
			// Set overall request size constraint
			upload.setSizeMax(4194304); 

			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> i = items.iterator();
			
			String savePath = "";
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				String fileName = fi.getName();
				if (fileName != null) {
					String oldFileName = fi.getName();
					String randStr = RandomStringUtils.random(5, true, true);
					String newFileName = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + "!@" + 
						randStr + oldFileName.substring(oldFileName.indexOf("."));
					File newFile = new File(newFileName);
					File savedFile = new File(basePath + uploadPath, newFile.getName());
					fi.write(savedFile);
					savePath = uploadPath + savedFile.getName();
				}
			}
			 
			if(!("").equals(savePath)){
				if(PersonFlag!=null&&PersonFlag.equals("1")){
					
					response.sendRedirect("itemManage_uploadExcelPersonSuccess?auctionFlag=" + auctionFlag + "&excelPathFlag=" + savePath);
				   
				}else{
					
					response.sendRedirect("itemManage_uploadExcelSuccess?auctionFlag=" + auctionFlag + "&excelPathFlag=" + savePath);
				}
			}else{
				response.sendRedirect("itemManage_uploadExcelFailure?auctionFlag=" + auctionFlag);
			}
		}catch (Exception e) {
			response.sendRedirect("itemManage_uploadExcelFailure?auctionFlag=" + auctionFlag);
			e.printStackTrace();
		}
	}

	public void init() throws ServletException {
	}
	
}