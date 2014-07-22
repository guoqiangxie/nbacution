package com.useeasy.auction.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.dao.IAuctionInfoDAO;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.dto.AuctionInfoDtoIndex;
import com.useeasy.auction.bean.AfterBB;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.auction.bean.AuctionInfoIndexDto;
import com.useeasy.auction.bean.BeforBB;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Tools;

public class AuctionInfoHibernateDAO extends HibernateDaoSupport implements IAuctionInfoDAO {

	public String getAuctionCount(String companyId, String searchKind, 
			String searchType, String pubishType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from AuctionInfoIndexDto " +
				"where deleteFlag=0 ";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}
		if("1".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " +
						"and companyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId).uniqueResult().toString());
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " +
						"and companyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}
		}else if("3".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
						"and companyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and auctionStatus=2 ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and auctionStatus=2 " +
						"and companyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql).setString("companyId", companyId)
						.uniqueResult().toString());
			}
			
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + "";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + "and companyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId).uniqueResult().toString());
			}
		}
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<AuctionInfoIndexDto> getAuctionList(String companyId, 
			String searchKind, String searchType, String pubishType, BasePage basePage) {
		// TODO Auto-generated method stub
		List<AuctionInfoIndexDto> list = null;
		Session session = getSession();
		String baseSql = "from AuctionInfoIndexDto a " +
			"where a.deleteFlag=0 ";
		String baseOrder = " order by a.auctionStartTime desc";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and a.publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and a.publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and a.auctionDelegation=2 ";
		}else{
			baseSql = baseSql + "";
		}
		if("1".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and (a.auctionStatus=0 or a.auctionStatus=1) " + " order by a.auctionStatus desc,a.auctionStartTime asc";
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and (a.auctionStatus=0 or a.auctionStatus=1) " + 
					"and a.companyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (a.auctionStartTime>=:todayStart and a.auctionStartTime<=:todayEnd) " +   
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (a.auctionStartTime>=:todayStart and a.auctionStartTime<=:todayEnd) " + 
					"and a.companyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("3".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (a.auctionStartTime>=:todayStart and a.auctionStartTime<=:thirtyDayEnd) " +
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (a.auctionStartTime>=:todayStart and a.auctionStartTime<=:thirtyDayEnd) " +
					"and a.companyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and a.auctionStatus=2 " + baseOrder;
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and a.auctionStatus=2 " + 
					"and a.companyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + baseOrder;
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + "and a.companyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}
		session.close();
		return list;
	}

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getAuctionInfoDtoCount(String companyId, String searchKind, 
			String searchType, String pubishType) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from AuctionInfoDto " +
				"where deleteFlag=0 ";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}
		if("1".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId).uniqueResult().toString());
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}
		}else if("3".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and auctionStatus=2 ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and auctionStatus=2 " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql).setString("companyId", companyId)
						.uniqueResult().toString());
			}
			
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + "";
				count = Long.parseLong(session.createQuery(hql)
						.uniqueResult().toString());
			}else{
				hql = baseSql + "and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId).uniqueResult().toString());
			}
		}
		session.close();
		return "" + count;
	}
	
	@SuppressWarnings("unchecked")
	public List<AuctionInfoDto> getAuctionInfoDtoList(String companyId,
			String searchKind, String searchType, String pubishType,
			BasePage basePage) {
		// TODO Auto-generated method stub
		List<AuctionInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from AuctionInfoDto " +
			"where deleteFlag=0 ";
		String baseOrder = " order by auctionStartTime desc,id asc ";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}else{
			baseSql = baseSql + "";
		}
		if("1".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " + " order by auctionStatus desc,auctionStartTime asc,id asc ";
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " +   
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("3".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and auctionStatus=2 " + baseOrder;
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and auctionStatus=2 " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + baseOrder;
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + "and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}
		session.close();
		return list;
	}

	@SuppressWarnings("unchecked")
	public AuctionInfoDto getAuctionInfoDto(String id) {
		// TODO Auto-generated method stub
		List<AuctionInfoDto> list = null;
		Session session = getSession();
		String hql = "from AuctionInfoDto " +
			"where deleteFlag=0 and id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	public void saveAuctionInfoDto(AuctionInfoDto auctionInfoDto) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionInfoDto);
	}

	public String getAuctionInfoDtoCountInPublish(String searchKind,
			String searchTime) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from AuctionInfoDto " +
				"where deleteFlag=0 and publishFlag=1 ";
		String hql = "";
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}else{
			baseSql = baseSql + "";
		}
		if("1".equals(searchTime)){  
			hql = baseSql;
			count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
		}else if("2".equals(searchTime)){  
			hql = baseSql + " and  (auctionStartTime>=:yearStart and auctionStartTime<=:yearEnd) ";
			count = Long.parseLong(session.createQuery(hql).
					setTimestamp("yearStart", Tools.getStartTimeByYear())
					.setTimestamp("yearEnd", Tools.getEndTimeByYear()).uniqueResult().toString());
		}else if("3".equals(searchTime)){  
			hql = baseSql + " and  (auctionStartTime>=:monthStart and auctionStartTime<:monthNextStart) ";
			count = Long.parseLong(session.createQuery(hql).
					setTimestamp("monthStart", Tools.getStartTimeByMonth())
					.setTimestamp("monthNextStart", Tools.getStartTimeByNextMonth()).uniqueResult().toString());
		}
		session.close();
		return "" + count;
	}
	
	@SuppressWarnings("unchecked")
	public List<AuctionInfoDto> getAuctionInfoDtoListTop() {
		// TODO Auto-generated method stub
		List<AuctionInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from AuctionInfoDto " +
			"where deleteFlag=0 and publishFlag=1 " +
			"and (auctionStatus=0 or auctionStatus=1) ";
		String baseOrder = " order by auctionStartTime desc,id asc ";
		String hql = baseSql + baseOrder;
		list = session.createQuery(hql)
		.setFirstResult(0).setMaxResults(5).list();
		session.close();
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public AuctionInfoDtoIndex getAuctionInfoIndexDto(String id) {
		// TODO Auto-generated method stub
		List<AuctionInfoDtoIndex> list = null;
		Session session = getSession();
		String hql = "from AuctionInfoDtoIndex " +
			"where deleteFlag=0 and id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	public String getAuctionInfoDtoCountInSearch(String companyId,
			String searchKind, String searchType, String pubishType, String key) {
		// TODO Auto-generated method stub
		long count = 0;
		Session session = getSession();
		String baseSql = "select count(id) from AuctionInfoDto " +
				"where deleteFlag=0 ";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}
		if("1".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId).uniqueResult().toString());
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("todayEnd", Tools.getEndTimeByToday()).uniqueResult().toString());
			}
		}else if("3".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) ";
				count = Long.parseLong(session.createQuery(hql)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setTimestamp("todayStart", Tools.getStartTimeByToday())
						.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
						.uniqueResult().toString());
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and auctionStatus=2 ";
				count = Long.parseLong(session.createQuery(hql).uniqueResult().toString());
			}else{
				hql = baseSql + " and auctionStatus=2 " +
						"and auctionCompanyId=:companyId ";
				count = Long.parseLong(session.createQuery(hql).setString("companyId", companyId)
						.uniqueResult().toString());
			}
			
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + "and auctionName like :key ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("key", "%" + key + "%").uniqueResult().toString());
			}else{
				hql = baseSql + "and auctionCompanyId=:companyId and auctionName like :key ";
				count = Long.parseLong(session.createQuery(hql)
						.setString("companyId", companyId)
						.setString("key", "%" + key + "%")
						.uniqueResult().toString());
			}
		}
		session.close();
		return "" + count;
	}

	@SuppressWarnings("unchecked")
	public List<AuctionInfoDto> getAuctionInfoDtoListInSearch(String companyId,
			String searchKind, String searchType, String pubishType,
			BasePage basePage, String key) {
		// TODO Auto-generated method stub
		List<AuctionInfoDto> list = null;
		Session session = getSession();
		String baseSql = "from AuctionInfoDto " +
			"where deleteFlag=0 ";
		String baseOrder = " order by auctionStartTime desc,id asc ";
		String hql = "";
		if("0".equals(pubishType)){
			baseSql = baseSql + " and publishFlag=0 ";
		}else if("1".equals(pubishType)){ 
			baseSql = baseSql + " and publishFlag=1 ";
		}else if("2".equals(pubishType)){ 
			baseSql = baseSql + "";
		}
		if("1".equals(searchKind)){  
			baseSql = baseSql + "";
		}else if("2".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=1 ";
		}else if("3".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=2 ";
		}else if("4".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=3 ";
		}else if("5".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=4 ";
		}else if("6".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=5 ";
		}else if("7".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=6 ";
		}else if("8".equals(searchKind)){  
			baseSql = baseSql + " and auctionType=7 ";
		}else if("9".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=1 ";
		}else if("10".equals(searchKind)){  
			baseSql = baseSql + " and auctionNature=2 ";
		}else if("11".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=1 ";
		}else if("12".equals(searchKind)){  
			baseSql = baseSql + " and auctionDelegation=2 ";
		}else{
			baseSql = baseSql + "";
		}
		if("1".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " + " order by auctionStatus desc,auctionStartTime asc,id asc";
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and (auctionStatus=0 or auctionStatus=1) " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("2".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " +   
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:todayEnd) " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("todayEnd", Tools.getEndTimeByToday())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("3".equals(searchType)){ 
			if(companyId == null){
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
					baseOrder;
				list = session.createQuery(hql)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and  (auctionStartTime>=:todayStart and auctionStartTime<=:thirtyDayEnd) " +
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setTimestamp("todayStart", Tools.getStartTimeByToday())
					.setTimestamp("thirtyDayEnd", Tools.getEndTimeByNextThirtyDay())
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("4".equals(searchType)){  
			if(companyId == null){
				hql = baseSql + " and auctionStatus=2 " + baseOrder;
				list = session.createQuery(hql)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + " and auctionStatus=2 " + 
					"and auctionCompanyId=:companyId " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}else if("5".equals(searchType)){
			if(companyId == null){
				hql = baseSql + "and auctionName like :key  " + baseOrder;
				list = session.createQuery(hql)
					.setString("key", "%" + key + "%")
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}else{
				hql = baseSql + "and auctionCompanyId=:companyId and auctionName like :key  " + baseOrder;
				list = session.createQuery(hql)
					.setString("companyId", companyId)
					.setString("key", "%" + key + "%")
					.setFirstResult((int) (((basePage.getCurrentPage())-1) * basePage.getPageSize()) + basePage.getPageFirst())
					.setMaxResults((int)(basePage.getPageSize())).list();
			}
		}
		session.close();
		return list;
	} 
	
	public void saveAuctionInfo(AuctionInfo auctionInfo) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(auctionInfo);
	}

	@SuppressWarnings("unchecked")
	public AuctionInfo getAuctionInfo(String id) {
		// TODO Auto-generated method stub
		List<AuctionInfo> list = null;
		Session session = getSession();
		String hql = "from AuctionInfo " +
			"where deleteFlag=0 and id=:id";
		list = session.createQuery(hql).setLong("id", Long.parseLong(id)).list();	
		session.close();
		if(list == null || list.size() == 0){
			return null;
		}else{
			return list.get(0);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getAuctionAliveStatus(String auctionId) {
		// TODO Auto-generated method stub
		List<Object[]> list = null;
		Session session = getSession();
		String hql = "SELECT a.id_num, a.operate_date, a.status_content, " +
				"a.auction_id, a.item_id,b.o_number FROM pmh.dbo.auction_alive_status_info AS a " +
				"LEFT OUTER JOIN pmh.dbo.auction_item_info AS b ON a.item_id = b.id_num WHERE (a.auction_id =:auctionId) order by a.operate_date";
		list = session.createSQLQuery(hql).setString("auctionId", auctionId)
				.list();
		session.close();
		return list;
	}
	//工商后
	public void  saveAfter(AfterBB b){
		getHibernateTemplate().saveOrUpdate(b);
	}
	//工商备案前的资料保存  
	public void saveBeforBB(BeforBB  b){
		getHibernateTemplate().saveOrUpdate(b);
	}
	
}