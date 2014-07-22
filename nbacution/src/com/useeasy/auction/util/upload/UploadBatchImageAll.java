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

import com.useeasy.auction.bean.ItemInfo;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.service.IItemInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.AppContext;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class UploadBatchImageAll extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws IOException, ServletException {
		request.getRequestDispatcher("index.jsp").forward(request,response);
	}
		
	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		IUploadImgInfoService iUploadImgInfoService = 
			(IUploadImgInfoService)AppContext.getInstance().getAppContext().getBean("uploadImgInfoService");
		IItemInfoService iItemInfoService = 
			(IItemInfoService)AppContext.getInstance().getAppContext().getBean("itemInfoService");
		
		//String noId = request.getParameter("noId");
		//System.out.println("auctionFlag" + noId);
		String auctionFlag = request.getParameter("auctionFlag");
		//System.out.println("itemFlag" + pubId);
		
		String basePath = request.getSession().getServletContext().getRealPath("/");
		//String basePath = "d:";
		String uploadPath = "\\uploadFile\\image\\"; 
		String tempPath = "\\uploadFile\\image\\temp\\"; 
		
		String uploadThumbPath = "\\uploadFile\\image\\thumb\\"; 
		
		File uploadFile = new File(basePath + uploadPath);
		if (!uploadFile.exists()) {
			uploadFile.mkdirs();
		}
		File tempPathFile = new File(basePath + tempPath);
		if (!tempPathFile.exists()) {
			tempPathFile.mkdirs();
		}
		File uploadThumbFile = new File(basePath + uploadThumbPath);
		if (!uploadThumbFile.exists()) {
			uploadThumbFile.mkdirs();
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
			
			UploadImgInfo uploadImgInfo = new UploadImgInfo();
			long item_index_val = 0;
			ItemInfo itemInfo = null;
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				String fileName = fi.getName();
				if (fileName != null) {
					String oldFileName = fi.getName();
					String oldFileName_val = oldFileName.substring(0,(oldFileName.indexOf(".")));
					item_index_val = Long.parseLong(oldFileName_val.split("-")[0]);
					if( auctionFlag != null && item_index_val > 0){
						itemInfo = iItemInfoService.getItemInfoByIndexAndAuction("" + item_index_val, auctionFlag);
						if(itemInfo == null){
							continue;
						}
					}else {
						continue;
					}
					String randStr = RandomStringUtils.random(5, true, true);
					String newFileName = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + "!@" + 
						randStr + oldFileName.substring(oldFileName.indexOf("."));
					File newFile = new File(newFileName);
					//returnPath = "UploadFiles\\"+ floderName + "\\" + date() + "!@" + randStr+fileName.substring(fileName.indexOf("."));
					File savedFile = new File(basePath + uploadPath, newFile.getName());
					fi.write(savedFile);
					uploadImgInfo.setId(null);
					uploadImgInfo.setCreateTime(new Date());
					uploadImgInfo.setUploadUrl(uploadPath.replace("\\", "/") + savedFile.getName());
					uploadImgInfo.setUploadType("5");
					uploadImgInfo.setRelationId("" + itemInfo.getId());
					iUploadImgInfoService.saveUploadImgInfo(uploadImgInfo);
					
					String randStrThumb = RandomStringUtils.random(5, true, true);
					String newThumbFileName = Tools.dateToString(new Date(), "yyyyMMddhhmmss") + "!@" + 
						randStrThumb + ".jpg";
					if(Tools.createThumb(savedFile, basePath + uploadThumbPath + newThumbFileName)){
						UploadImgInfo uploadImgInfoThumb = new UploadImgInfo();
						uploadImgInfoThumb.setId(null);
						uploadImgInfoThumb.setCreateTime(new Date());
						uploadImgInfoThumb.setUploadUrl(uploadThumbPath.replace("\\", "/") + newThumbFileName);
						uploadImgInfoThumb.setUploadType("6");
						uploadImgInfoThumb.setRelationId("" + uploadImgInfo.getId());
						iUploadImgInfoService.saveUploadImgInfo(uploadImgInfoThumb);
					}
					
				}
			}
			if(itemInfo != null)
				response.getWriter().print("successed");
			else
				response.getWriter().print("failure");
			//response.sendRedirect("auctionManage_uploadSuccess?imageFlag=" + uploadImgInfo.getId());
		}catch (Exception e) {
			response.getWriter().print("failure");
			
			//response.sendRedirect("uploadFile_imageFailure?imageFlag=0");
			e.printStackTrace();
		}
	}

	public void init() throws ServletException {

	}
	
	
}