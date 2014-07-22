package com.useeasy.auction.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.AuctionGuide;
import com.useeasy.auction.bean.SystemPrivilege;
import com.useeasy.auction.bean.UploadImgInfo;
import com.useeasy.auction.dao.SystemPrivilegeDao;
import com.useeasy.auction.dto.AuctionInfoDto;
import com.useeasy.auction.dto.CompanyInfoDto;
import com.useeasy.auction.service.IAccountInfoService;
import com.useeasy.auction.service.IAdminInfoService;
import com.useeasy.auction.service.IAuctionGuideService;
import com.useeasy.auction.service.IAuctionInfoService;
import com.useeasy.auction.service.ICompanyInfoService;
import com.useeasy.auction.service.IUploadImgInfoService;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.BasePage;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

@SuppressWarnings("serial")
public class AdminManageAction extends ActionSupport {
	
	static final Logger logger = LoggerFactory.getLogger(AdminManageAction.class);
    
	private IAccountInfoService iAccountInfo;
	private IAuctionInfoService iAuctionInfo;
	private ICompanyInfoService  iCompanyInfo;
	private IUploadImgInfoService iUploadImgInfo;
	private IAuctionGuideService iAuctionGuide;
	private SystemPrivilegeDao privilegeDao ;
	private AuctionGuide auctionGuide;
	 private AuctionCompany  company;
	 private  IAdminInfoService  iAdminInfo;
	 
	public String passEdit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "passEdit";
	}
	
	public String passModify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		String accountPass = ServletActionContext.getRequest().getParameter("accountPass");
		String accountConfirmPass = ServletActionContext.getRequest().getParameter("accountConfirmPass");
		if(accountPass == null || accountConfirmPass == null){
			return "sessionDestory";
		}
		
		SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER);
		AuctionAccount auctionAccount = sessionContainer.getAuctionAccount();
		if(!Tools.StingToMD5(accountPass).equals(auctionAccount.getAccountPass())){  //old pass error
			ServletActionContext.getRequest().setAttribute("checkFlag", "1");
			return "passEdit";
		}
		auctionAccount.setAccountPass(Tools.StingToMD5(accountConfirmPass));
		iAccountInfo.saveAuctionAccount(auctionAccount);
		ServletActionContext.getRequest().setAttribute("checkFlag", "2");
		return "passEdit";
	}
	
	public String auctionIndex(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		ServletActionContext.getRequest().setAttribute("currentPage", currentPage);
		String url = ServletActionContext.getActionMapping().getName() + "?";
		long count = Long.valueOf(iAuctionInfo.getAuctionInfoDtoCount(null, ("1"), ("5"), ("2")));
		BasePage basePage = new BasePage(count, currentPage, url);
		List<AuctionInfoDto> AuctionInfoDtoList = iAuctionInfo.getAuctionInfoDtoList(null, ("1"), ("5"), ("2"), basePage);
		ServletActionContext.getRequest().setAttribute("basePage", basePage);
		if(AuctionInfoDtoList != null && AuctionInfoDtoList.size() > 0){
			for(int i = 0; i < AuctionInfoDtoList.size(); i++){
				AuctionInfoDto auctionInfoDto = AuctionInfoDtoList.get(i);
				auctionInfoDto.setCompanyName(
						iCompanyInfo.getCompanyInfo(auctionInfoDto.getAuctionCompanyId()).getCompanyName());
				String imgType = auctionInfoDto.getAuctionPicType();  //img type
				if(imgType!=null){
					if( "1".equals(imgType) ){  
						if(auctionInfoDto.getAuctionCompanyId()!=null){
						   UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("1", auctionInfoDto.getAuctionCompanyId());
						   if(uploadImgInfo!=null&&uploadImgInfo.getUploadUrl()!=null){
								  auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						  }
						}
					 	
					}else if( "3".equals(imgType) ){  
						if(auctionInfoDto.getId()!=null){
						   UploadImgInfo uploadImgInfo = iUploadImgInfo.getUploadImgInfo("2", "" + auctionInfoDto.getId());
						   if(uploadImgInfo!=null){
						     if(uploadImgInfo.getUploadUrl()!=null){
						       auctionInfoDto.setAuctionPicUrl(uploadImgInfo.getUploadUrl());
						     }
						   }
						}
					}
				}
			}
		}
		ServletActionContext.getRequest().setAttribute("auctionInfoList", AuctionInfoDtoList);
		
		return "auctionIndex";
	}

	public String ready(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		
		AuctionInfoDto auctionInfoDto = iAuctionInfo.getAuctionInfoDto(auctionFlag);
		if( auctionInfoDto == null 
				//|| ("0").equals(auctionInfoDto.getPublishFlag())
				|| ("0").equals(auctionInfoDto.getAuctionStatus()) ){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=1");
			return "default";
		}
		
		auctionInfoDto.setAuctionStatus("0");
		iAuctionInfo.saveAuctionInfoDto(auctionInfoDto);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=" + currentPage);
		return "default";
	}
	
	public String going(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		
		AuctionInfoDto auctionInfoDto = iAuctionInfo.getAuctionInfoDto(auctionFlag);
		if( auctionInfoDto == null 
				//|| ("0").equals(auctionInfoDto.getPublishFlag())
				|| ("1").equals(auctionInfoDto.getAuctionStatus()) ){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=1");
			return "default";
		}
		
		auctionInfoDto.setAuctionStatus("1");
		iAuctionInfo.saveAuctionInfoDto(auctionInfoDto);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=" + currentPage);
		return "default";
	}
	
	public String end(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String auctionFlag = ServletActionContext.getRequest().getParameter("auctionFlag");
		if(auctionFlag == null){
			return "sessionDestory";
		}
		String currentPage = ServletActionContext.getRequest().getParameter("currentPage");
		if(currentPage == null || ("").equals(currentPage)){
			currentPage = "1";
		}
		
		AuctionInfoDto auctionInfoDto = iAuctionInfo.getAuctionInfoDto(auctionFlag);
		if( auctionInfoDto == null 
				//|| ("0").equals(auctionInfoDto.getPublishFlag())
				|| ("2").equals(auctionInfoDto.getAuctionStatus()) ){
			ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=1");
			return "default";
		}
		
		auctionInfoDto.setAuctionStatus("2");
		iAuctionInfo.saveAuctionInfoDto(auctionInfoDto);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_auctionIndex?currentPage=" + currentPage);
		return "default";
	}
	
	public String guideIndex(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String searchType = ServletActionContext.getRequest().getParameter("searchType");
		if(("0").equals(searchType) || ("1").equals(searchType)
				|| ("2").equals(searchType) || ("3").equals(searchType) 
				|| ("4").equals(searchType) ){
		}else{
			return "sessionDestory";
		}
		List<AuctionGuide> auctionGuideList = iAuctionGuide.getAuctionGuideList(searchType);		
		ServletActionContext.getRequest().setAttribute("auctionGuideList", auctionGuideList);
		
		return "guideIndex";
	}
	
	public String guideAdd(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		return "guideAdd";
	}
	
	public String guideSave(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		auctionGuide.setId(null);
		auctionGuide.setCreateTime(new Date());
		auctionGuide.setUpdateTime(new Date());
		auctionGuide.setDeleteFlag("0");
		iAuctionGuide.saveAuctionGuide(auctionGuide);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_guideIndex?searchType=0");
		return "default";
	}
	
	public String guideEdit(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String guideFlag = ServletActionContext.getRequest().getParameter("guideFlag");
		if(guideFlag == null){
			return "sessionDestory";
		}
		auctionGuide = iAuctionGuide.getAuctionGuide(guideFlag);
		if(("1").equals(auctionGuide.getDeleteFlag())){
			return "sessionDestory";
		}
		return "guideEdit";
	}
	
	public String guideModify(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String mothed = ServletActionContext.getRequest().getMethod();
		if(!"post".equalsIgnoreCase(mothed)){
			return "sessionDestory";
		}
		
		auctionGuide.setUpdateTime(new Date());
		iAuctionGuide.saveAuctionGuide(auctionGuide);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_guideIndex?searchType=0");
		return "default";
	}
	
	public String guideDelete(){
		logger.info("" + ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount().getId());
		String guideFlag = ServletActionContext.getRequest().getParameter("guideFlag");
		if(guideFlag == null){
			return "sessionDestory";
		}
		auctionGuide = iAuctionGuide.getAuctionGuide(guideFlag);
		if(("1").equals(auctionGuide.getDeleteFlag())){
			return "sessionDestory";
		}
		auctionGuide.setDeleteFlag("1");
		iAuctionGuide.saveAuctionGuide(auctionGuide);
		
		ServletActionContext.getRequest().setAttribute("reloadUrl", "adminManage_guideIndex?searchType=0");
		return "default";
	}
	
 //后台公司列表
    
    public String companyList(){
    	SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
		.getSession().get(Constants.SESEION_LISTENER);
    	AuctionAccount account =   sessionContainer.getAuctionAccount();
    	if(sessionContainer!=null&&account!=null&&account.getAccountType().equals("1")){
    		 List<CompanyInfoDto> list= iCompanyInfo.getCompanyInfoDtoList();
        	 ServletActionContext.getRequest().setAttribute("companyList",list);
        	 String flag = ServletActionContext.getRequest().getParameter("flag");
        	 ServletActionContext.getRequest().setAttribute("flag",flag);
    	}else{
    		 return "sessionDestory";
    	}
    	

     return "companyList";	
    }
    
    //注册 公司
    
    public String addCompanyUI(){
    	SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
		.getSession().get(Constants.SESEION_LISTENER);
    	AuctionAccount account =   sessionContainer.getAuctionAccount();
    	if(sessionContainer!=null&&account!=null&&account.getAccountType().equals("1")){
    		return "addCompanyUI";
    	}else{
    		 return "sessionDestory";
    	}
    	
    }
  	 
    
    public String addCompany(){
    	SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
		.getSession().get(Constants.SESEION_LISTENER);
    	AuctionAccount account =   sessionContainer.getAuctionAccount();
    	if(sessionContainer!=null&&account!=null&&account.getAccountType().equals("1")){
    		company.setDeleteFlag("0");
        	company.setCreateTime(new Date());
        	company.setUpdateTime(new Date());
        	iCompanyInfo.saveCompanyInfo(company);
        	try {
				ServletActionContext.getResponse().sendRedirect("adminManage_companyList?flag=1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}else{
    		 return "sessionDestory";
    	}
    	
   	   	return null;
   }
   //修改公司信息UI
   public String updateCompanyUI(){
	   String cid=ServletActionContext.getRequest().getParameter("cid");
	   SessionContainer sessionContainer = (SessionContainer) ActionContext.getContext()
		.getSession().get(Constants.SESEION_LISTENER);
   	AuctionAccount account =   sessionContainer.getAuctionAccount();
   	if(sessionContainer!=null&&account!=null&&account.getAccountType().equals("1")&& (cid!=null && !"".equals(cid))){
   	   ServletActionContext.getRequest().setAttribute("auctionCompany",iCompanyInfo.getCompanyInfo(cid));
   	}else{
   		 return "sessionDestory";
   	}  
   	return "updateCompanyUI";
  }//修改公司
   public String updateCompany(){
		String companyName=ServletActionContext.getRequest().getParameter("companyName");
		String companyAddress=ServletActionContext.getRequest().getParameter("companyAddress");
		String companyLinker=ServletActionContext.getRequest().getParameter("companyLinker");
		String companyPhone=ServletActionContext.getRequest().getParameter("companyPhone");
		String companyTel=ServletActionContext.getRequest().getParameter("companyTel");
		String companyPost=ServletActionContext.getRequest().getParameter("companyPost");
		String companyEmail=ServletActionContext.getRequest().getParameter("companyEmail");
		String companyLogo=ServletActionContext.getRequest().getParameter("companyLogo");
		String companyIntro=ServletActionContext.getRequest().getParameter("companyIntro");
		String companyConnection=ServletActionContext.getRequest().getParameter("companyConnection");
	   String cid=ServletActionContext.getRequest().getParameter("cid");
	   AuctionCompany company = iCompanyInfo.getCompanyInfo(cid.trim());  
	   company.setCompanyName(companyName);
	   company.setCompanyAddress(companyAddress);
	   company.setCompanyLinker(companyLinker);
	   company.setCompanyPhone(companyPhone);
	   company.setCompanyTel(companyTel);
	   company.setCompanyPost(companyPost);
	   company.setCompanyEmail(companyEmail);
	   company.setCompanyLogo(companyLogo);
	   company.setCompanyIntro(companyIntro);
	   company.setCompanyConnection(companyConnection);
	   iCompanyInfo.update_company(company);
   try {
	ServletActionContext.getResponse().sendRedirect("adminManage_companyList?flag=1");
} catch (IOException e) {
	// TODO Auto-generated catch block
		e.printStackTrace();
	}
   
   	return null;
     }
   
  
  
   public String addAccountUI(){
     	List<CompanyInfoDto> list= iCompanyInfo.getCompanyInfoDtoList();
   	    ServletActionContext.getRequest().setAttribute("companyList",list);
       	return "addAccountUI";
   }
   @SuppressWarnings("null")
	public String addAccount(){
   	       String cid = ServletActionContext.getRequest().getParameter("cid");
           String accountName = ServletActionContext.getRequest().getParameter("account");
           String accountPass = ServletActionContext.getRequest().getParameter("password");
           AuctionAccount  account=new AuctionAccount();
           account.setAccountName(accountName);
           account.setAccountPass(Tools.StingToMD5(accountPass.trim()));
           System.out.println(Tools.StingToMD5(accountPass.trim()));
           account.setAccountStatus("1");
           account.setDeleteFlag("0");
           account.setCreateTime(new Date());
           account.setUpdateTime(new Date());
           account.setAccountType("2");
           account.setAccountRelationId(cid);
           if(iAccountInfo.isNotExistAccountName(accountName)){
        	   iAccountInfo.saveAuctionAccount(account);
           }
            
              try {
            	ServletActionContext.getResponse().sendRedirect("adminManage_accountManage?addaflag=1");
            } catch (IOException e) {
            	// TODO Auto-generated catch block
            		e.printStackTrace();
            	}
        
     	return null; 
   }
   
   public String accountManage(){
	    String addaflag =ServletActionContext.getRequest().getParameter("addaflag");
  	    ServletActionContext.getRequest().setAttribute("addaflag",addaflag);
	   return "accountManage";
   }
   
   /*
    * 公司帐号列表
    */
   public String accountList(){
	   
   	   int pageNo=1;
  	    String page=ServletActionContext.getRequest().getParameter("pageNo");
  	    if(page!=null&&!"".equals(page)){
  	    	pageNo=Integer.valueOf(page);
  	    }
  	    List<CompanyInfoDto> clist= iCompanyInfo.getCompanyInfoDtoList();
  	    List<AuctionAccount> list = iAccountInfo.getList(pageNo,15, 15, " o.accountType =? ",new Object[]{"2"},"  order by o.id  desc");
  	    List  count = iAccountInfo.getcount(" o.accountType =? ",new Object[]{"2"});
  	    if(count != null && count.size()>0){
  	    	ServletActionContext.getRequest().setAttribute("total",count.get(0).toString());
  	    }
  	
  	 	ServletActionContext.getRequest().setAttribute("clist",clist);
  	  	ServletActionContext.getRequest().setAttribute("pageNo",pageNo);
    	ServletActionContext.getRequest().setAttribute("pageSize",15);
  	   	ServletActionContext.getRequest().setAttribute("accountlist",list);
	   
  	    return "accountList";
   }
   
   /*
    * 竟买人帐号列表
    */
   public String jaccountList(){
	   
   	   int pageNo=1;
  	    String page=ServletActionContext.getRequest().getParameter("pageNo");
  	    if(page!=null&&!"".equals(page)){
  	    	pageNo=Integer.valueOf(page);
  	    }
  	    List<AuctionAccount> list = iAccountInfo.getList(pageNo,15, 15, " o.accountType =? ",new Object[]{"3"},"  order by o.id  desc");
  	    List  count = iAccountInfo.getcount(" o.accountType =? ",new Object[]{"3"});
  	    if(count != null && count.size()>0){
  	    	ServletActionContext.getRequest().setAttribute("total",count.get(0).toString());
  	    }
   	  	ServletActionContext.getRequest().setAttribute("pageNo",pageNo);
    	ServletActionContext.getRequest().setAttribute("pageSize",15);
  	   	ServletActionContext.getRequest().setAttribute("accountlist",list);
	   
  	    return "jaccountList";
   }
   
    /*
     * 查询公司帐号
     */
   
   public String getAccoutnSearch(){
	   String accountName=ServletActionContext.getRequest().getParameter("accountName");
	   String type=ServletActionContext.getRequest().getParameter("type");
	   if((accountName != null && !"".equals(accountName))&&(type != null && !"".equals(type))){
		   List<AuctionAccount> list = iAccountInfo.getAccountInfoByAccountNameList(accountName,type);
		   List<CompanyInfoDto> clist= iCompanyInfo.getCompanyInfoDtoList();
		  ServletActionContext.getRequest().setAttribute("accountlist",list);
		  ServletActionContext.getRequest().setAttribute("clist",clist);
		  if(type.trim().equals("2")){
			   return "accountSerach";
		   }else if(type.trim().equals("3")){
			   return "jaccountSerach";
		   }
		  
	   } 
	  return null;
   }
   
   //锁帐号
   public String lockaccount(){
    PrintWriter out = null ;
    ServletActionContext.getResponse().setCharacterEncoding("utf-8");
    ServletActionContext.getResponse().setContentType("text/html");
    try {
		out = ServletActionContext.getResponse().getWriter();
		String eid=ServletActionContext.getRequest().getParameter("eid");
		AuctionAccount account=iAccountInfo.getAccountInfo(eid);
		account.setDeleteFlag("1");
		iAccountInfo.saveAuctionAccount(account);
		out.print("已锁定");
	} catch (IOException e) {
		 
		e.printStackTrace();
	}finally{
		if (out !=null){
			out.flush();
			out.close();
		}
	}
    

	return null; 
   }
   
   public String updateAccount(){
   PrintWriter out = null ;
    try {
	ServletActionContext.getResponse().setCharacterEncoding("utf-8");
	ServletActionContext.getResponse().setContentType("text/html");      
   	String eid=ServletActionContext.getRequest().getParameter("eid");
   	AuctionAccount account=iAccountInfo.getAccountInfo(eid);
   	account.setAccountPass(Tools.StingToMD5("555"));
   	iAccountInfo.saveAuctionAccount(account) ;;
   	out = ServletActionContext.getResponse().getWriter();
	out.print("密码恢复成功");
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally{
		if (out !=null){
			out.flush();
			out.close();
		}
	}
		return null;  
   }
   //激活账号
   public String reloadAccount(){
    PrintWriter out = null ;
    try {
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		ServletActionContext.getResponse().setContentType("text/html");   
		String eid=ServletActionContext.getRequest().getParameter("eid");
		AuctionAccount account=iAccountInfo.getAccountInfoByID(eid);
		account.setDeleteFlag("0");
		iAccountInfo.saveAuctionAccount(account) ;;
		out = ServletActionContext.getResponse().getWriter();
		out.print("正常");
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally{
		if (out !=null){
			out.flush();
			out.close();
		}
	}
	return null; 
   }
   
   //查询帐号
   public String findListUI(){
   	
   	return "findList";
   }
   
   //判断帐号是否存在
   
   public String isNotExistAccountName(){
	   PrintWriter out = null ;
	   try {
	   out = ServletActionContext.getResponse().getWriter();
	   String accountName = ServletActionContext.getRequest().getParameter("accountName");
	   if(accountName != null && !"".equals(accountName)){
		   if(!iAccountInfo.isNotExistAccountName(accountName)){
		 		out.print("1");
		    }else{
			   out.print("0");
		   }
	   }
	   } catch (IOException e) {
			out.print("error");
			e.printStackTrace();
		}finally{
			if (out !=null){
				out.flush();
				out.close();
			}
		}
	   return null;
   }
   //根据身份证查出的结果
   public String findList(){
   	String sfzhm=ServletActionContext.getRequest().getParameter("sfzhm");
   	if(sfzhm != null && !"".equals(sfzhm.trim())){
	     List <Object []> result=iAccountInfo.findBysfz(sfzhm);
	   	if(result!=null&&result.size()>0){
	       	ServletActionContext.getRequest().setAttribute("account",result );
	    }
   	}
     	return "findList"; 
   }
   /*
    * 初始化权限值
    */
   public String init(){
		initSystemPrivilege();
		initAdmin();
		return "sucess";
	}
	/**
	 * 初始化管理员账号
	 */
	private void initAdmin() {
		if(iAccountInfo.getcount(" o.accountName=? ",new Object[]{"admin"}).get(0).toString().equals("0")){
			AuctionAccount employee = new AuctionAccount();
			AuctionAdmin admincompany = new AuctionAdmin();
			admincompany.setAdminName("超级管理员");
			admincompany.setDeleteFlag("0");
			iAdminInfo.save(admincompany);
			employee.setAccountName("admin");
		 	employee.setAccountPass(Tools.StingToMD5("555"));
		 	employee.setAccountStatus("1");
		 	employee.setAccountType("1");
		 	employee.setDeleteFlag("0");
		 	employee.setAccountRelationId(admincompany.getId().toString());
		    employee.getPrivilege().addAll(privilegeDao.getList(0,-1,-1,null,null,""));
		    iAccountInfo.saveAuctionAccount(employee) ;
		}		
	}
	
	/**
	 * 初始化权限
	 */
	private  void initSystemPrivilege() {
		if(privilegeDao.getcount(null,null).get(0).toString().equals("0")){
			List<SystemPrivilege> privileges = new ArrayList<SystemPrivilege>();
			privileges.add(new SystemPrivilege("pmh","拍卖会列表","pmhlist"));
			privileges.add(new SystemPrivilege("pmh","拍卖会管理(增，删，改)","manage"));
			privileges.add(new SystemPrivilege("pmh","拍卖会发布","pmhpub"));
			privileges.add(new SystemPrivilege("pmh","竟买人管理","pmhperson"));
			privileges.add(new SystemPrivilege("pmh","XML管理","xml"));
			privileges.add(new SystemPrivilege("pmh","帐务中心","financial"));
			privileges.add(new SystemPrivilege("pmh","竟拍屏幕","controller"));
			privileges.add(new SystemPrivilege("pmh","大屏幕","big"));
			privileges.add(new SystemPrivilege("pmh","拍卖师屏幕","pmhs"));
			privileges.add(new SystemPrivilege("pmh","拍卖会状态管理","pmhstu"));
			privileges.add(new SystemPrivilege("pmh","成交记","deal"));
			privileges.add(new SystemPrivilege("pmh","成果分析","result"));
			
			
			privileges.add(new SystemPrivilege("pmt","拍卖厅申请记录","pmtlist"));
			privileges.add(new SystemPrivilege("pmt","拍卖厅申请","save"));
			 
			
			privileges.add(new SystemPrivilege("account","帐号查询","accountlist"));
			privileges.add(new SystemPrivilege("account","帐号管理","accountmanage"));
			privileges.add(new SystemPrivilege("account","公司管理","companymanage"));
			 
			 
			privileges.add(new SystemPrivilege("other","收支明细","shouzhi"));
			privileges.add(new SystemPrivilege("other","公司注册","zhuce"));
			privileges.add(new SystemPrivilege("other","相关资料","about"));
			privileges.add(new SystemPrivilege("other","公告管理","notice"));
			privileges.add(new SystemPrivilege("other","密码管理","password"));
			
			 
			privilegeDao.batchSave(privileges);
		}		 
	}
	/*
	 * 拍卖公司分配权限列表
	 */
	public String editPrilige(){
		String uid = ServletActionContext.getRequest().getParameter("uid");
		if(uid != null  && !"".equals(uid.trim())){
			AuctionAccount account = iAccountInfo.getAccountInfoByID(uid.trim());
			List<SystemPrivilege> list = privilegeDao.getList(0, -1, -1, null, null, "");
			ServletActionContext.getRequest().setAttribute("priligelist", list);
			ServletActionContext.getRequest().setAttribute("account", account);
		}
		
	 
		return "editPrilige";
	}
	
	/*
	 * 保存用户权限
	 */
	
	public String addprilige(){
		AuctionAccount account =null;
		String uid = ServletActionContext.getRequest().getParameter("uid");
		String [] privilage = ServletActionContext.getRequest().getParameterValues("privilage");
		if((uid != null && !"".equals(uid.trim()))){
		    account = iAccountInfo.getAccountInfoByID(uid.trim());
			if(account != null){
				if(account.getPrivilege()!= null){
					account.getPrivilege().clear();
				}
				if((privilage != null && privilage.length>0)){
					StringBuffer sbf = new  StringBuffer();
					Object [] params = new Object[privilage.length];
			 		for(int i=0;i<privilage.length;i++){
			 			sbf.append("?").append(",");
			 			params[i]=Integer.valueOf(privilage[i].trim());
					}
			 		 
					List<SystemPrivilege> list = privilegeDao.getList(0, -1, -1, " o.id in("+sbf+"'')", params, "");
					Set<SystemPrivilege> systemPrivilegeSet = new HashSet<SystemPrivilege>();
					for(SystemPrivilege l :list){
						systemPrivilegeSet.add(l); 
					}
				 	account.setPrivilege(systemPrivilegeSet );
				}
				iAccountInfo.saveAuctionAccount(account);
				try {
					 
					ServletActionContext.getResponse().sendRedirect("adminManage_editPrilige?uid="+account.getId());
					return null;
				} catch ( Exception e) {
				 	e.printStackTrace();
				}
			}
			
		} 
		try {
			 
			ServletActionContext.getResponse().sendRedirect("adminManage_accountList");
			return null;
		} catch ( Exception e) {
		 	e.printStackTrace();
		}
		
		return null;
	}
	
	public void setiAccountInfo(IAccountInfoService iAccountInfo) {
		this.iAccountInfo = iAccountInfo;
	}

	public void setiAuctionInfo(IAuctionInfoService iAuctionInfo) {
		this.iAuctionInfo = iAuctionInfo;
	}

	public void setiCompanyInfo(ICompanyInfoService iCompanyInfo) {
		this.iCompanyInfo = iCompanyInfo;
	}

	public void setiUploadImgInfo(IUploadImgInfoService iUploadImgInfo) {
		this.iUploadImgInfo = iUploadImgInfo;
	}

	public void setiAuctionGuide(IAuctionGuideService iAuctionGuide) {
		this.iAuctionGuide = iAuctionGuide;
	}

	public AuctionGuide getAuctionGuide() {
		return auctionGuide;
	}

	public void setAuctionGuide(AuctionGuide auctionGuide) {
		this.auctionGuide = auctionGuide;
	}

	public SystemPrivilegeDao getPrivilegeDao() {
		return privilegeDao;
	}

	public void setPrivilegeDao(SystemPrivilegeDao privilegeDao) {
		this.privilegeDao = privilegeDao;
	}

	public AuctionCompany getCompany() {
		return company;
	}

	public void setCompany(AuctionCompany company) {
		this.company = company;
	}

	public IAdminInfoService getiAdminInfo() {
		return iAdminInfo;
	}

	public void setiAdminInfo(IAdminInfoService iAdminInfo) {
		this.iAdminInfo = iAdminInfo;
	}
    
	
}
