package com.useeasy.auction.intenetView.dao;

import java.util.List;

import com.useeasy.auction.intenetView.bean.IntenetView;

/*
 * 观摩人业务处理
 */
public interface IntenetetViewDao {
      public void add(IntenetView view); 
      public void update(IntenetView view); 
      /**
       * 
       * @param accountView帐号名称
       * @param accountPass密码
       * @return
       */
      public IntenetView findBy(String accountView ,String auctionFlag); 
      /**
       * 
       * @param pmhId拍卖会ID按照未授权的在上排序
       * @return
       */
      public List<IntenetView> getViewList(String pmhId);
}
