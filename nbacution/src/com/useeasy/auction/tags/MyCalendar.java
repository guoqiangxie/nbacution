package com.useeasy.auction.tags;

import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.useeasy.aucton.calendar.dao.PMSQdao;
@Component
public class MyCalendar extends TagSupport {
	private static final long serialVersionUID = -7677534442361565504L;
	PMSQdao ting  ;
	
	@Override
	public int doStartTag() throws JspException {
		 
	ServletRequest requerst = this.pageContext.getRequest();
	Object m =  requerst.getAttribute("month");//获取request中的月
	int month;
	WebApplicationContext spring =  WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext()) ;
	ting =(PMSQdao) spring.getBean("pmtsqdao");
		
	StringBuffer   option = new StringBuffer();
	for(int i=0;i<12;i++){
	 option.append("<option value='"+i+"'>").append(i+1).append("月").append("</option>");
	}	
	JspWriter out = pageContext.getOut();
	StringBuffer sCalendar = new StringBuffer();
	GregorianCalendar gc = new GregorianCalendar();
	int today = gc.get(Calendar.DAY_OF_MONTH);
	
	int year = gc.get(Calendar.YEAR);
	String days[] = new String[42];
	for (int i = 0; i < 42; i++) {
	days[i] = "";
	}
	Calendar cal = Calendar.getInstance();
	cal.clear();
	if(m !=null){
	   month = Integer.valueOf(m.toString());
	 }else{
	   month = gc.get(Calendar.MONTH);
	}
	cal.set(Calendar.MONTH, month);  
	cal.set(Calendar.YEAR, year);  
	cal.setFirstDayOfWeek(Calendar.SUNDAY); 
	cal.set(Calendar.DAY_OF_MONTH, 1);  
	int firstIndex = cal.get(Calendar.DAY_OF_WEEK) - 1;  
	int maxIndex = cal.getActualMaximum(Calendar.DAY_OF_MONTH);  
	for (int i = 0; i < maxIndex; i++) {
	days[firstIndex + i] = String.valueOf(i + 1);
	}
	try {  
	 sCalendar.append( "<script> function tomonth(obj){ location.href='pmtsqAction_tomonth?month='+obj.value; } </script >   <table border='0' width='100%'  style=\" border:#ebf4ff 2px solid;\"  height='200' id='rili'>");
	 sCalendar.append("<tr style='background-color:#ebf4ff'><td colspan='7' height='16' align='center'>"+year 
			 + " 年" + (month + 1) + " 月" +
			 today+"日<select onchange ='tomonth(this)'>"+"<option>"+(month+1)+"月</option>"+
			 option.toString()+"</select></td></tr>");
	sCalendar.append("<tr style='background-color:#ebf4ff'><th width='25' height='16'  ><font color='red'>日</font></th>");
	sCalendar.append("<th width='25' height='16' align='center'>一</th><th align='center' width='25' height='16'>二</th>");
	sCalendar.append("<th width='25' height='16' align='center'>三</th><th align='center' width='25' height='16'>四</th>");
	sCalendar.append("<th width='25' height='16' align='center'>五</th><th align='center' width='25' height='16'><font color='red'> 六</font></th></tr>");
	for(int i=0;i<6;i++){sCalendar.append("<tr>");
	for(int j=i*7;j< (i+1)*7;j++){
	sCalendar.append("<td width='15%' height='16' valign='middle' class='show' >");
	if((j-firstIndex+1)==today){
	sCalendar.append("<font color='red'>"+days[j]+"&nbsp;&nbsp;<a href='pmtsqAction_getList?date="+ year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+today+"'>["+(ting.getCount( year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+today)==0?"":+ting.getCount(year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+(Integer.valueOf(days[j])>10?days[j]:"0"+days[j]))+"]</a></font>"));
	}else{
		
		if(!days[j].equals("")){
		 
		 sCalendar.append(days[j].equals("")?"": days[j]+(ting.getCount( year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+(Integer.valueOf(days[j])>10?days[j]:"0"+days[j]))==0?"<a       href='pmtsqAction_getList?date="+year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+(Integer.valueOf(days[j])>10?days[j]:"0"+days[j])+"'><img  style='border:none' src='/useeasy/auction/images/m_btn_kx02.gif' width='20' height='20'/></a>":"&nbsp;&nbsp; <a href='pmtsqAction_getList?date="+year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+(Integer.valueOf(days[j])>10?days[j]:"0"+days[j])+"'>  ["+ting.getCount(year+"-"+((month+1)>10?(month+1):"0"+(month+1))+"-"+(Integer.valueOf(days[j])>10?days[j]:"0"+days[j]))+"]</a> ") );
		}else{
			sCalendar.append(days[j].equals("")?"": days[j]);
		}
	}
	sCalendar.append("");
	}
     sCalendar.append("</tr>");
	}
	sCalendar.append("");
	out.print(sCalendar.toString());
	} catch (IOException e) {
	e.printStackTrace();
	}
	return TagSupport.SKIP_BODY;
	}
}
