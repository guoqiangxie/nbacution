package com.useeasy.auction.dao;

import java.util.List;

import com.useeasy.auction.bean.UploadImgInfo;

public interface IUploadImgInfoDAO {
	
	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(String relationId, String uploadType);
	
	
	public List<UploadImgInfo> getUploadImgInfoByItem(String itemId);
	
	
	
	
	
	
	
	public UploadImgInfo getUploadImgInfo(String uploadType, String relationId);
	
	public List<UploadImgInfo> getUploadImgInfoList(String uploadType, String relationId);

	public UploadImgInfo getUploadImgInfo(String id);
	
	public void saveUploadImgInfo(UploadImgInfo uploadImgInfo);
	
	public void removeUploadImgInfo(UploadImgInfo uploadImgInfo);
	
}

