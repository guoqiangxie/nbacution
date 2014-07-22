package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dao.IUploadImgInfoDAO;

public class UploadImgInfoHibernateDAO extends HibernateDaoSupport implements IUploadImgInfoDAO {

	@SuppressWarnings("unchecked")
	public UploadImgInfo getUploadImgByUploadTypeAndRelationId(String relationId, String uploadType) {
		// TODO Auto-generated method stub
		List<UploadImgInfo> list = null;
		Session session = getSession();
		String hql = "from UploadImgInfo u " +
			"where u.relationId=:relationId and u.uploadType=:uploadType ";
		list = session.createQuery(hql).setString("relationId", relationId)
			.setString("uploadType", uploadType).list();	
		session.close();
		if(list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<UploadImgInfo> getUploadImgInfoByItem(String itemId) {
		// TODO Auto-generated method stub
		Object[] objs = {itemId};
		return getHibernateTemplate().findByNamedParam("from UploadImgInfo uploadImgInfo " +
				"where uploadImgInfo.relationId=:itemId and uploadImgInfo.uploadType=5 " +
				"order by uploadImgInfo.id asc",new String[]{"itemId"},objs);
	}

	
	
	
	
	
	
	
	
	
	
	
	@SuppressWarnings("unchecked")
	public UploadImgInfo getUploadImgInfo(String uploadType, String relationId) {
		// TODO Auto-generated method stub
		List<UploadImgInfo> list = null;
		Session session = getSession();
		String hql = "from UploadImgInfo " +
			"where relationId=:relationId and uploadType=:uploadType ";
		list = session.createQuery(hql).setString("relationId", relationId)
			.setString("uploadType", uploadType).list();	
		session.close();
		if(list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<UploadImgInfo> getUploadImgInfoList(String uploadType,
			String relationId) {
		// TODO Auto-generated method stub
		List<UploadImgInfo> list = null;
		Session session = getSession();
		if( uploadType == null ){
			String hql = "from UploadImgInfo " +
				"where relationId=:relationId  ";
			list = session.createQuery(hql).setString("relationId", relationId).list();
		}else{
			String hql = "from UploadImgInfo " +
				"where relationId=:relationId and uploadType=:uploadType ";
			list = session.createQuery(hql).setString("relationId", relationId)
				.setString("uploadType", uploadType).list();
		}
		session.close();
		if(list == null || list.size() == 0)
			return null;
		else
			return list;
	}

	public UploadImgInfo getUploadImgInfo(String id) {
		// TODO Auto-generated method stub
		return (UploadImgInfo) getHibernateTemplate().get(UploadImgInfo.class, Long.parseLong(id));
	}
	
	public void saveUploadImgInfo(UploadImgInfo uploadImgInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(uploadImgInfo);
	}
	
	public void removeUploadImgInfo(UploadImgInfo uploadImgInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(uploadImgInfo);
	}
	
}