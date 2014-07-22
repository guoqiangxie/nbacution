package com.useeasy.aucton.calendar.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.useeasy.auction.bean.AuctionAccount;
import com.useeasy.auction.bean.AuctionAdmin;
import com.useeasy.auction.bean.AuctionCompany;
import com.useeasy.auction.bean.AuctionInfo;
import com.useeasy.aucton.calendar.bean.PMTSQ;
import com.useeasy.aucton.calendar.bean.PMTing;
import com.useeasy.aucton.calendar.dao.PMSQdao;
import com.useeasy.aucton.calendar.dao.PMTingdao;
import com.useeasy.aucton.calendar.dao.UserTimedao;
import com.useeasy.frame.base.SessionContainer;
import com.useeasy.frame.util.Constants;
import com.useeasy.frame.util.Tools;

/*
 * 拍卖厅申请ACTION
 */
public class PMTSQAction {
	private PMTingdao	ptdao ;
	private PMSQdao  sqdao;
	private UserTimedao utdao;
	private PMTSQ tsq;
	
	
	public String updateUI(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
	   String id = ServletActionContext.getRequest().getParameter("id");
	   if(id!=null){
		  PMTSQ object = sqdao.get(Integer.valueOf(id.trim()));
		  ServletActionContext.getRequest().setAttribute("pmtsq",object);
	   }
	  
  
		return "updateUI";
	}
	
	/*
	 * 补全申请厅的资料
	 */
	
	public String update(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		if(ServletActionContext.getRequest().getParameter("id")!=null){
			    Integer id = Integer.valueOf(ServletActionContext.getRequest().getParameter("id").trim());
			    PMTSQ  sq = sqdao.get(id);
			    String pmType = ServletActionContext.getRequest().getParameter("pmType");//拍卖类别
			    String guajiepmhName = ServletActionContext.getRequest().getParameter("guajiepmhName");//拍卖会名称
			    String pmhName = ServletActionContext.getRequest().getParameter("pmhName");//拍卖会名称
				String pmCompany = ServletActionContext.getRequest().getParameter("pmCompany");//拍卖公司
				String pmTime = ServletActionContext.getRequest().getParameter("pmTime");//拍卖时间
				String pmAddress = ServletActionContext.getRequest().getParameter("pmAddress");//拍卖地址
				String person = ServletActionContext.getRequest().getParameter("person");//使用人
				String tel = ServletActionContext.getRequest().getParameter("tel");//电话
				String phone = ServletActionContext.getRequest().getParameter("phone");//手机
				String newsPaper = ServletActionContext.getRequest().getParameter("newsPaper");//刊登报纸
				String paperTime = ServletActionContext.getRequest().getParameter("paperTime");//见报日期
				String pmhId = ServletActionContext.getRequest().getParameter("pmhId");//拍卖会关联
				String gongGaoId = ServletActionContext.getRequest().getParameter("gongGaoId");//公告ID
				String internetMain =  ServletActionContext.getRequest().getParameter("internetMain");//公司网址
				AuctionCompany company = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany(); //公司帐号
			    String stu = "1";//状态，标注是否资料填写，（可先申请厅后填写资料,每次登录后如果有未填写的提示填写）
			    if(pmType!=null&&!"".equals(pmType.trim())){
			      sq.setPmType(pmType);
			    }
			    if(guajiepmhName!=null&&!"".equals(guajiepmhName.trim())){
			    	 sq.setPmhName(guajiepmhName); 
			    }
			    if(pmhName!=null&&!"".equals(pmhName.trim())){
			    sq.setPmhName(pmhName);}
			    if(pmCompany!=null&&!"".equals(pmCompany.trim())){
			    sq.setPmCompany(pmCompany);}
			    if(pmTime!=null&&!"".equals(pmTime.trim())){
			    sq.setPmTime(Tools.stringToDate(pmTime, "yyyy-MM-dd"));}
			    if(pmAddress!=null&&!"".equals(pmAddress.trim())){
			    sq.setPmAddress(pmAddress);}
			    if(person!=null&&!"".equals(person.trim())){
			    sq.setPerson(person);}
			    if(tel!=null&&!"".equals(tel.trim())){
			    sq.setTel(tel);}
			    if(phone!=null&&!"".equals(phone.trim())){
			    sq.setPhone(phone);}
			    if(newsPaper!=null&&!"".equals(newsPaper.trim())){
			    sq.setNewsPaper(newsPaper);}
			    if(paperTime!=null&&!"".equals(paperTime.trim())){
			    sq.setPaperTime(Tools.stringToDate(paperTime, "yyyy-MM-dd"));}
			    if(pmhId!=null&&!"".equals(pmhId.trim())){
			    sq.setPmhId(Long.valueOf(pmhId));}
			    if(gongGaoId!=null&&!"".equals(gongGaoId.trim())){
			    sq.setGongGaoId(Long.valueOf(gongGaoId));}
			    if(internetMain!=null&&!"".equals(internetMain.trim())){ sq.setInternetMain(internetMain);}
			    if(company!=null ){ sq.setU_id(company.getId());}
			   
			    
			    sq.setStu(stu);
			    sqdao.update(sq);
		}	
	   
		try {
			ServletActionContext.getResponse().sendRedirect("pmtsqAction_companysqGetList");
		} catch (Exception e) {
			 
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 公司申请记录查询
	 */
	
	public String companysqGetList(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String pageNo = ServletActionContext.getRequest().getParameter("pageNo");
    	if(pageNo==null){
    		pageNo="1";
    	}
       
        String pageSize_str=ServletActionContext.getRequest().getParameter("pageSize");
       
        	Integer pageSize=0;
         if(pageSize_str!=null){ 	
    	    pageSize=Integer.valueOf(pageSize_str);
         }else{
        	 pageSize=10; 
         }
		AuctionCompany company = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
		 
		String where=" o.delete !='1' and o.u_id=?";
		 
		if(auctionAccount.getAccountType().equals("1")){
		  Object [] param = {((SessionContainer) ActionContext.getContext()
					.getSession().get(Constants.SESEION_LISTENER)).getAuctionAdmin().getId()};
		  ServletActionContext.getRequest().setAttribute("list", sqdao.getList(Integer.valueOf(pageNo), pageSize, 10, where, param, " order by o.creatTime desc,stu asc"));
		  ServletActionContext.getRequest().setAttribute("total",sqdao.getCount(" o.delete_flag !='1' and o.u_id=?",param).toString());
		}else{
		  Object [] param = {company.getId()};
		  ServletActionContext.getRequest().setAttribute("list", sqdao.getList(Integer.valueOf(pageNo), pageSize, 10, where, param, " order by o.creatTime desc,stu asc"));
		  ServletActionContext.getRequest().setAttribute("total",sqdao.getCount(" o.delete_flag !='1' and o.u_id=?",param).toString());
		}
	
		
		ServletActionContext.getRequest().setAttribute("pageNo",pageNo); 
	    ServletActionContext.getRequest().setAttribute("pageSize",pageSize); 
		
		return "companysqGetList";
	}
	
	
	/*
	 * 拍卖厅列表
	 */
	
	
	public String getList(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String date = ServletActionContext.getRequest().getParameter("date");
		Date day =null;
		if(date!=null&&!"".equals(date.trim())){
			day =Tools.stringToDate(date, "yyyy-MM-dd") ;
		}else{
			
			day =Tools.stringToDate(Tools.dateToString(new Date(), "yyyy-MM-dd"), "yyyy-MM-dd") ;
		}
		//useDay
		String where ="o.useDay = ? and o.delete!=1 ";
		Object [] obj ={day};
		List<PMTSQ> userlist =  sqdao.getList(0, -1, -1, where, obj, "");
		List<PMTing> list = ptdao.getList(0, -1, -1, null, null, "");
		ServletActionContext.getRequest().setAttribute("useList", userlist);
		ServletActionContext.getRequest().setAttribute("pmtList", list);
		ServletActionContext.getRequest().setAttribute("day", day);
		ServletActionContext.getRequest().setAttribute("month", Integer.valueOf(Tools.dateToString(day, "MM"))-1);
		return "getList";
	}
	
	
 
	public String add(){
		
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		  
		AuctionCompany company = ((SessionContainer) ActionContext.getContext()
		 .getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
		  
	 	try {
			String pmtid = ServletActionContext.getRequest().getParameter("pmtid");
			String utid = ServletActionContext.getRequest().getParameter("utid");//使用厅的ID
			String day = ServletActionContext.getRequest().getParameter("day");
			PMTSQ object =null;
		 	if(pmtid!=null&&utid!=null&&day!=null){
				if(!"".equals(pmtid.trim())&&!"".equals(utid.trim()) &&!"".equals(day.trim()) ){
				 	String where = "o.useDay=? and  o.pmt=? and  o.ut=? and o.delete !=1  ";
					Object [] obj ={Tools.stringToDate(day, "yyyy-MM-dd"),Integer.valueOf(pmtid),Integer.valueOf(utid)};
					List list = sqdao.getList(0, -1, -1, where, obj, "");
					if(list.size()>0){
					  ServletActionContext.getRequest().setAttribute("flag", "0");//已存在  
					}else{
						if(auctionAccount.getAccountType().equals("1")){
							 AuctionAdmin companyAdmin =	((SessionContainer) ActionContext.getContext()
									 .getSession().get(Constants.SESEION_LISTENER)).getAuctionAdmin();
						  object = new PMTSQ(Tools.stringToDate(day, "yyyy-MM-dd"),Integer.valueOf(pmtid),Integer.valueOf(utid),companyAdmin.getId(),companyAdmin.getAdminName());
							
						}else{
						  object = new PMTSQ(Tools.stringToDate(day, "yyyy-MM-dd"),Integer.valueOf(pmtid),Integer.valueOf(utid),company.getId(),company.getCompanyName());
								
						}
					  object.setStu("0");
					  sqdao.save(object);
					  String where1 = "o.useDay=? and  o.pmt=? and  o.ut=? and o.delete !=1 ";
					  Object [] obj1 ={Tools.stringToDate(day, "yyyy-MM-dd"),Integer.valueOf(pmtid),Integer.valueOf(utid)};
					  List<PMTSQ> list1 = sqdao.getList(0, -1, -1, where, obj, "");
					  if(list1.size()>0){
						  ServletActionContext.getRequest().setAttribute("list1", list1.get(0));//已保存  
					  }
					  ServletActionContext.getRequest().setAttribute("flag", "1");//已保存  
				 	}
			 	}
		 	}
		 	
		} catch ( Exception e) {
			e.printStackTrace();
		} 
		
		return "getList";
	}
	
	public String get(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null&&!"".equals(id.trim())){
			PMTSQ pmtsqObject = sqdao.get(Integer.valueOf(id));
			ServletActionContext.getRequest().setAttribute("pmtsqObject", pmtsqObject);
		}else{
			return "sessionDestory";
		}
	
		return "get";
	}
	
	/*
	 * 拍卖公司根据拍会状态来查看只读形式申请信息
	 */
	
	public String getOnlyReady(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null&&!"".equals(id.trim())){
			PMTSQ pmtsqObject = sqdao.get(Integer.valueOf(id));
			ServletActionContext.getRequest().setAttribute("pmtsqObject", pmtsqObject);
		}else{
			return "sessionDestory";
		}
		return "getOnlyReady";
	}
	
	//日历调月
	public String tomonth(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String date = ServletActionContext.getRequest().getParameter("date");
		Date day =null;
		if(date!=null&&!"".equals(date.trim())){
			day =Tools.stringToDate(date, "yyyy-MM-dd") ;
		}else{
			
			day =Tools.stringToDate(Tools.dateToString(new Date(), "yyyy-MM-dd"), "yyyy-MM-dd") ;
		}
		//useDay
		String where ="o.useDay = ?";
		Object [] obj ={day};
		List<PMTSQ> userlist =  sqdao.getList(0, -1, -1, where, obj, "");
		List<PMTing> list = ptdao.getList(0, -1, -1, null, null, "");
		ServletActionContext.getRequest().setAttribute("useList", userlist);
		ServletActionContext.getRequest().setAttribute("pmtList", list);
		ServletActionContext.getRequest().setAttribute("day", day);
		String month = ServletActionContext.getRequest().getParameter("month");
		ServletActionContext.getRequest().setAttribute("month", month);
		return "tomonth";
	}
	//拍卖日历鼠标放上去显示情况
	public String ajaxshowrili(){
		try {
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			out.print("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			 
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * 查询挂接拍卖会列表
	 */
	
	public String guajiePmhList(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		AuctionCompany company = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
		 
		String wherejpql = " o.auctionStatus ='0' and o.auctionCompanyId=?";
		Object [] queryParams ={company.getId().toString()};
		List<AuctionInfo> list = sqdao.guajiePmhList(0, -1, -1, wherejpql, queryParams, "  order by o.createTime desc");
		StringBuffer sff = new StringBuffer();
		sff.append("<select id='pmhlist' name='pmhId' onchange =\"javascript:$('#hiddenpmhName').attr('value',this.options[this.selectedIndex].innerHTML);\" >");
		sff.append("<option >").append("请选择拍卖会").append("</option>");
		for(AuctionInfo info : list){
			sff.append("<option value='").append(info.getId()).append("'>").append(info.getAuctionName()).append("</option>");
		}
		sff.append("</select>");
	    HttpServletResponse response = ServletActionContext.getResponse();
	    response.setContentType("text/html;charset=UTF-8");   
		response.setCharacterEncoding("UTF-8"); 
		PrintWriter out  =null;
		try {
			  out = response.getWriter();
			  out.print(sff.toString());
		} catch (Exception e) {
			 
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.flush();
				out.close();
			}
			
		}
		 
		return null;
	}
	
	
	/*
	 * 查询拍卖会 
	 */
	
	public String pmh(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		AuctionCompany company = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionCompany();
		 
		String pmhid = ServletActionContext.getRequest().getParameter("id");
		if(pmhid!=null&&!"".equals(pmhid.trim())){
			
		
		String wherejpql = " o.id =?";
		Object [] queryParams ={Long.valueOf(pmhid.trim()) };
		List<AuctionInfo> list = sqdao.guajiePmhList(0, -1, -1, wherejpql, queryParams, "  ");
	 
	    HttpServletResponse response = ServletActionContext.getResponse();
	    response.setContentType("text/html;charset=UTF-8");   
		response.setCharacterEncoding("UTF-8"); 
		PrintWriter out  =null;
		try {
			 out = response.getWriter();
			  if(list.size()>0){
			   if(list.get(0).getAuctionStatus().equals("0")){ 
			   
			    out.print("0");
			   }else if(list.get(0).getAuctionStatus().equals("1")){
				   out.print("1"); 
			   }else if(list.get(0).getAuctionStatus().equals("2")){
				   out.print("2");
			   }
			  }else{
				  out.print("fail");  
			  }
		} catch (Exception e) {
			 
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.flush();
				out.close();
			}
			
		}
		}else{
			return "sessionDestory";
		}
		return null;
	}
	
	
	public String helpcenter(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")|auctionAccount.getAccountType().equals("2")){
			
		}else{
			return "sessionDestory";	
		}
		String id = ServletActionContext.getRequest().getParameter("id");
		if(id!=null&&!"".equals(id.trim())){
			PMTSQ object = sqdao.get(Integer.valueOf(id));
			String stu = ServletActionContext.getRequest().getParameter("stu");
			String note = ServletActionContext.getRequest().getParameter("note");
			object.setStu(stu);
			object.setNote(note);
			sqdao.update(object);
			 HttpServletResponse response = ServletActionContext.getResponse();
			 PrintWriter out  =null;
				try {
					 out = response.getWriter();
					 
						  out.print("success");  
					  
				} catch (Exception e) {
					 
					e.printStackTrace();
				}finally{
					if(out!=null){
						out.flush();
						out.close();
					}
		        }  
		}
		return null;
	}
	
	/*
	 * 拍协拍卖特殊申请查询
	 */
	
	public String teshusq(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			
		}else{
			return "sessionDestory";	
		}
		String wherejpql = " o.delete ='0' and o.stu in (?,?)";
		Object [] queryParams ={"2","3"};
		List<PMTSQ> list = sqdao.getList(0, -1, -1, wherejpql, queryParams, "  order by creatTime  desc");
		ServletActionContext.getRequest().setAttribute("list", list);
		return "teshusq";
	}
	/*
	 * 拍协厅申请删除
	 */
	
	public String delete(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		if(auctionAccount.getAccountType().equals("1")){
			String id = ServletActionContext.getRequest().getParameter("id");
			if(id!=null&&!"".equals(id.trim())){
				PMTSQ object = sqdao.get(Integer.valueOf(id));
				if(object!=null){
					object.setDelete("1");
				   	sqdao.update(object);
				}
				
			   	try {
					ServletActionContext.getResponse().sendRedirect("pmtsqAction_companysqGetList");
				} catch (Exception e) {
				 
					e.printStackTrace();
				}
			}else{
				return "sessionDestory";	
			}
			
		}else{
			return "sessionDestory";	
		}
		return null;
	}
	
	/*
	 * 换厅保存
	 */
	
	public String updateTing(){
		if(((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER))==null){
			return "sessionDestory";
		}
		AuctionAccount auctionAccount = ((SessionContainer) ActionContext.getContext()
				.getSession().get(Constants.SESEION_LISTENER)).getAuctionAccount();
		if(auctionAccount ==null){
			return "sessionDestory";
		}
		 PrintWriter out  =null;
		 HttpServletResponse response = ServletActionContext.getResponse();
		try {    
		   out = response.getWriter();
		String useDay = ServletActionContext.getRequest().getParameter("useDay");
		String time = ServletActionContext.getRequest().getParameter("time");
		String ting = ServletActionContext.getRequest().getParameter("ting");
		if((useDay!=null&&!"".equals(useDay.trim()))&&(time!=null&&!"".equals(time.trim()))&&(ting!=null&&!"".equals(ting.trim()))){
		  String wherejpql = "  o.useDay=? and o.pmt =? and o.ut=? ";
		  Object [] queryParams ={Tools.stringToDate(useDay, "yyyy-MM-dd"),Integer.valueOf(ting.trim()),Integer.valueOf(time.trim())};
		  List<PMTSQ> list =sqdao.getList(0, -1, -1, wherejpql, queryParams, "");
		 
			
					  if(list!=null&&list.size()>0){
						  out.print("0");
					  }else{
						String id =  ServletActionContext.getRequest().getParameter("id"); 
						if(id!=null&&!"".equals(id.trim())){
							PMTSQ object = sqdao.get(Integer.valueOf(id.trim()));
							if(object!=null){
							object.setUseDay(Tools.stringToDate(useDay, "yyyy-MM-dd"));
							object.setPmt(Integer.valueOf(ting));
							object.setUt(Integer.valueOf(time));
							object.setStu("1");
							sqdao.update(object);
							out.print("1");
							}
						}else{
							return "sessionDestory";
						}
					  }
				 
		
		}else{
			out.print("2");//更换厅条件不全，天+厅+时间段
		}
		} catch (Exception e) {
			 
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.flush();
				out.close();
			}
        }  
		return null;
	}
	
	public PMTingdao getPtdao() {
		return ptdao;
	}
	public void setPtdao(PMTingdao ptdao) {
		this.ptdao = ptdao;
	}
	public PMSQdao getSqdao() {
		return sqdao;
	}
	public void setSqdao(PMSQdao sqdao) {
		this.sqdao = sqdao;
	}
	public UserTimedao getUtdao() {
		return utdao;
	}
	public void setUtdao(UserTimedao utdao) {
		this.utdao = utdao;
	}

	public PMTSQ getTsq() {
		return tsq;
	}

	public void setTsq(PMTSQ tsq) {
		this.tsq = tsq;
	}
	 
	
	
	
}
