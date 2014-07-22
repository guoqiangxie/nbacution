<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@ include file="/WEB-INF/pages/useeasy/frame/base/taglib.jsp"%>
 <%@taglib uri="/struts-tags"  prefix="s"%>
 
 
     <ul>             <!-- 超级管理员 -->
                       <s:if test="#session._listener.auctionAccount.accountType==1">
                         <ul>
				                 <li><a href="adminManage_auctionIndex?currentPage=1" class="current">拍卖会管理</a></li>
				                  <li><a href="adminManage_companyList">公司管理</a> </li>
				                   <li><a href="adminManage_accountManage">帐号管理</a> </li>
				                  
				                <li><a href="adminManage_guideIndex?searchType=0">拍卖指南</a></li>
				                 <li><a href="adminManage_passEdit">密码修改</a></li>
				                 <li><a href="ShengQing_HouTaiCheXiaoSHFY">拍卖厅管理</a></li>
				                 <li><a href="ShengQing_getSQ2fy">拍卖厅申请</a></li>
				                 <li><a href="auctionLogin_frameLogout">退出登录</a></li>
			            </ul>
                       
                       
                       </s:if>
                       <!-- 会员公司 -->
						<s:elseif test="#session._listener.auctionAccount.accountType==2">
							<li>
								<a href="auctionManage_index?currentPage=1">拍卖会管理</a>
							</li>
							<li>
								<a href="ShengQing_getSQ1?s=first">拍卖厅申请</a>
							</li>
							 
						 	<li>
								<a href="companyPayment_index?currentPage=1">收支明细</a>
							</li>
							<li>
								<a href="companyManage_edit">拍卖公司注册信息</a>
							</li>
							<li>
								<a href="companyBulletin_index?currentPage=1">拍卖公告管理</a>
							</li>
							<li>
								<a href="auctionManage_fileResource">相关资料</a>
							</li>
							
							<li>
								<a href="companyManage_passEdit">密码修改</a>
							</li>
							<li>
								<a href="auctionLogin_frameLogout">退出登录</a>
							</li>
						</s:elseif>
					 
					
					</ul>
  
