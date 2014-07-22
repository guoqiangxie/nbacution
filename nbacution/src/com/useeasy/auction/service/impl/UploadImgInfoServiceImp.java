package com.useeasy.auction.service.impl;

import java.util.List;

import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dao.IUploadImgInfoDAO;
import com.useeasy.auction.service.IUploadImgInfoService;

public class UploadImgInfoServiceImp implements IUploadImgInfoService {

	private IUploadImgInfoDAO dao;

	public IUploadImgInfoDAO getDao() {
		return dao;
	}

	public void setDao(IUploadImgInfoDAO dao) {
		this.dao = dao;
	}

	
	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(String relationId, String uploadType) {
		// TODO Auto-generated method stub
		return dao.getUploadImgByUploadTypeAndRelationId(relationId, uploadType);
	}

	

	public List<UploadImgInfo> getUploadImgInfoByItem(String itemId) {
		// TODO Auto-generated method stub
		return dao.getUploadImgInfoByItem(itemId);
	}

	
	
	
	
	
	
	
	
	
	public UploadImgInfo getUploadImgInfo(String uploadType, String relationId) {
		// TODO Auto-generated method stub
		return dao.getUploadImgInfo(uploadType, relationId);
	}

	public List<UploadImgInfo> getUploadImgInfoList(String uploadType,
			String relationId) {
		// TODO Auto-generated method stub
		return dao.getUploadImgInfoList(uploadType, relationId);
	}

	public UploadImgInfo getUploadImgInfo(String id) {
		// TODO Auto-generated method stub
		return dao.getUploadImgInfo(id);
	}
	
	public void saveUploadImgInfo(UploadImgInfo uploadImgInfo) {
		// TODO Auto-generated method stub
		dao.saveUploadImgInfo(uploadImgInfo);
	}

	public void removeUploadImgInfo(UploadImgInfo uploadImgInfo) {
		// TODO Auto-generated method stub
		dao.removeUploadImgInfo(uploadImgInfo);
	}
	
}
