package com.useeasy.auction.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.useeasy.auction.bean.ItemProxyPrice;
import com.useeasy.auction.dao.IItemProxyPriceDAO;
import com.useeasy.auction.dto.ProxyItemInfoDto;
import com.useeasy.frame.util.Tools;

public class ItemProxyPriceHibernateDAO extends HibernateDaoSupport implements IItemProxyPriceDAO {

	@SuppressWarnings("unchecked")
	public List<ProxyItemInfoDto> getProxyItemInfoDtos(String accountId,
			String auctionId, String searchType) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		Session session = getSession();
		String sql = "";
		String baseSql = "";
		String baseOrder = " order by i.o_number";
		if("1".equals(searchType)){  
			baseSql = "select i.id_num, i.o_number, i.view_order, i.o_cname, " +
			"i.o_commission_type, i.o_commission, i.o_margin, i.proxy_price_type, " + 
			"p.id_num as p_id, p.proxy_price " +
			"from pmh.dbo.auction_item_info as i left outer join " +
			"(select * from pmh.dbo.auction_proxy_price_info where account_id = :accountId) as p on i.id_num = p.item_id " +
			"where i.delete_flag = 0 and i.pub_id = :auctionId and " +
			"(p.account_id = :accountId or p.account_id is null) ";
		}else if("2".equals(searchType)){  
			baseSql = "select i.id_num, i.o_number, i.view_order, i.o_cname, " +
			"i.o_commission_type, i.o_commission, i.o_margin, i.proxy_price_type, " + 
			"p.id_num as p_id, p.proxy_price " +
			"from pmh.dbo.auction_item_info as i left outer join " +
			"pmh.dbo.auction_proxy_price_info as p on i.id_num = p.item_id " +
			"where i.delete_flag = 0 and i.pub_id = :auctionId and " +
			"p.account_id = :accountId ";
		}
		sql = baseSql + baseOrder;
		list = session.createSQLQuery(sql).setString("auctionId", auctionId)
		.setString("accountId", accountId).list();
		session.close();
		return changeListType(list);
	}

	@SuppressWarnings({ "rawtypes" })
	private List<ProxyItemInfoDto> changeListType(List list){
		if(list == null || list.size() == 0){
			return null;
		}
		List<ProxyItemInfoDto> list_var = new ArrayList<ProxyItemInfoDto>();
		for(int i = 0; i < list.size(); i++){
			ProxyItemInfoDto proxyItemInfoDto = new ProxyItemInfoDto();
			proxyItemInfoDto.setId(Tools.getLongValue(((Object[])list.get(i))[0]));
			proxyItemInfoDto.setItemNumber(Tools.getStringValue(((Object[])list.get(i))[1]));
			proxyItemInfoDto.setViewOrder(Tools.getStringValue(((Object[])list.get(i))[2]));
			proxyItemInfoDto.setItemName(Tools.getStringValue(((Object[])list.get(i))[3]));
			proxyItemInfoDto.setItemCommissionType(Tools.getStringValue(((Object[])list.get(i))[4]));
			proxyItemInfoDto.setItemCommissionValue(Tools.getStringValue(((Object[])list.get(i))[5]));
			proxyItemInfoDto.setMargin(Tools.getStringValue(((Object[])list.get(i))[6]));
			proxyItemInfoDto.setProxyPriceFlag(Tools.getStringValue(((Object[])list.get(i))[7]));
			proxyItemInfoDto.setProxyPriceId(Tools.getLongValue(((Object[])list.get(i))[8]));
			proxyItemInfoDto.setProxyPrice(Tools.getStringValue(((Object[])list.get(i))[9]));
			list_var.add(proxyItemInfoDto);
		}
		return list_var;
	}

	public void saveItemProxyPrice(ItemProxyPrice itemProxyPrice) {
		// TODO Auto-generated method stub
		getHibernateTemplate().saveOrUpdate(itemProxyPrice);
	}

	public ItemProxyPrice getItemProxyPrice(String id) {
		// TODO Auto-generated method stub
		return getHibernateTemplate().get(ItemProxyPrice.class, Long.parseLong(id));
	}

	public void removeItemProxyPrice(ItemProxyPrice itemProxyPrice) {
		// TODO Auto-generated method stub
		getHibernateTemplate().delete(itemProxyPrice);
	}
}