package com.useeasy.auction.util.upload;

import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.RandomStringUtils;

import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.AppContext;
import com.useeasy.frame.util.Tools;


@SuppressWarnings("serial")
public class UploadImage extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws IOException, ServletException {
		request.getRequestDispatcher("index.jsp").forward(request,response);
	}
	
	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String uploadType = request.getParameter("uploadType");
		if(uploadType == null){
			request.getRequestDispatcher("index.jsp").forward(request,response);
		}
		
		if("1".equals(uploadType) || "2".equals(uploadType) || "3".equals(uploadType)){
		}else{
			request.getRequestDispatcher("index.jsp").forward(request,response);
		}
		
		IUploadImgInfoService iUploadImgInfoService = (IUploadImgInfoService)AppContext
			.getInstance().getAppContext().getBean("uploadImgInfoService");
			
		String basePath = request.getSession().getServletContext().getRealPath("/");
		
		String uploadPath = "\\uploadFile\\image\\"; 
		String tempPath = "\\uploadFile\\image\\temp\\"; 

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
			upload.setFileSizeMax(2097152);
			upload.setSizeMax(4194304); 

			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> i = items.iterator();
			
			UploadImgInfo uploadImgInfo = new UploadImgInfo();
			
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				String fileName = fi.getName();
				if (fileName != null) {
					if(fi.getSize() > 2097152){
						//System.out.println(fi.getSize());
						continue;
					}
						
					//String fileType = fi.getContentType();
					//BufferedImage bi = ImageIO.read(new File(fi.getName()));   
					// another interface such as: read(InputStream input); 
					InputStream is = new BufferedInputStream(fi.getInputStream());
					Image image = ImageIO.read(is);
					//System.out.println(fi.getSize());
					if(image == null) //use for check file type is img
						continue;
					//System.out.println("Width=" + bi.getWidth());   
					//System.out.println("Height=" + bi.getHeight()); 
					String oldFileName = fi.getName();
					String randStr = RandomStringUtils.random(5, true, true);
					String newFileName = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + "!@" + randStr 
						+ oldFileName.substring(oldFileName.indexOf("."));
					File newFile = new File(newFileName);
					File savedFile = new File(basePath + uploadPath, newFile.getName());
					fi.write(savedFile);
					
					uploadImgInfo.setId(null);
					uploadImgInfo.setCreateTime(new Date());
					uploadImgInfo.setUploadType(uploadType);
					uploadImgInfo.setUploadUrl(uploadPath.replace("\\", "/") + savedFile.getName());
					iUploadImgInfoService.saveUploadImgInfo(uploadImgInfo);
				}
			}
			if(uploadImgInfo.getId() != null){
				response.sendRedirect("uploadManage_imgUpload?imageFlag=" + uploadImgInfo.getUploadUrl() + "," + uploadImgInfo.getId());
				//request.getRequestDispatcher("/imgUpload.jsp").forward(request,response);
			}else{
				response.sendRedirect("uploadManage_imgUpload?imageFlag=-1");
			}
		}catch (Exception e) {
			response.sendRedirect("uploadManage_imgUpload?imageFlag=-2");
			e.printStackTrace();
		}
	}

	public void init() throws ServletException {
	}
	
}