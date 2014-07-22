package com.useeasy.auction.util.mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.useeasy.frame.util.Constants;

public class MailSender  {
	
	static final Logger logger = LoggerFactory.getLogger(MailSender.class);
    
	public MailSender(){
	}
	
	public static void sendMessage(String guest, String accountName, String checkVal){
		
		Properties props = System.getProperties();
		props.put("mail.smtp.host", "smtp.163.com");
		props.put("mail.smtp.auth", "true"); 
		
		MailAuthenticator mailauth = new MailAuthenticator("xmkj56@163.com", "glayshx");  //...
		Session session = Session.getDefaultInstance(props, mailauth);
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("xmkj56@163.com", "宁波市拍卖行业协会"));
			msg.addRecipient(Message.RecipientType.TO,new InternetAddress(guest));
			msg.setSubject("【宁波市拍卖行业协会】Email用户注册验证");
			msg.setSentDate(new Date());
			
			msg.setText(accountName + "\n" + 
				"这封信是由 宁波市拍卖行业协会 发送的。\n" + 
				"\n"+
				"----------------------------------------------------------------------\n" +
				"帐号激活说明\n"+
				"----------------------------------------------------------------------\n"+
				"您是我们网站的新用户，我们需要对您的地址有效性进行验证以避免垃圾邮件或地址被滥用。\n"+
				"您只需点击下面的链接即可激活您的帐号：\n"+
				Constants.EMAIL_SEND_URL  +"/" + checkVal + "\n"+
				//"http://wangpai1.staa.com.cn/" + checkVal + "\n"+
				"(如果上面不是链接形式，请将地址手工粘贴到浏览器地址栏再访问)\n"+
				"感谢您的访问，祝您使用愉快！\n"+
				"\n"+
				"此致\n"+
				"\n"+
				"宁波市拍卖行业协会\n"+
				"www.nbpmzx.com.cn\n");
			
			msg.saveChanges(); // implicit with send() 

			Transport.send(msg);
		} catch (MessagingException mex) {
	        System.out.println("send failed, exception: " + mex);
	    } catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	
	public static void sendPassMessage(String guest, String accountName, String checkVal){
		
		Properties props = System.getProperties();
		props.put("mail.smtp.host", "smtp.163.com");
		props.put("mail.smtp.auth", "true"); 
		
		MailAuthenticator mailauth = new MailAuthenticator("xmkj56@163.com", "glayshx");  //...
		Session session = Session.getDefaultInstance(props, mailauth);
		try {

			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("xmkj56@163.com", "宁波市在线同步拍卖交易平台"));
			msg.addRecipient(Message.RecipientType.TO,new InternetAddress(guest));
			msg.setSubject("【宁波市在线同步拍卖交易平台】Email密码找回");
			msg.setSentDate(new Date());
			
			msg.setText(accountName + "\n" + 
				"这封信是由 宁波市在线同步拍卖交易平台 发送的。\n" + 
				"\n"+
				"----------------------------------------------------------------------\n" +
				"帐号密码重置说明\n"+
				"----------------------------------------------------------------------\n"+
				"您可以在：\n"+
				Constants.EMAIL_SEND_URL + "/" + "recoverPassManage_email\n\n"+
				"使用临时密码：" + checkVal + "\n\n\n"+
				"感谢您的访问，祝您使用愉快！\n"+
				"\n"+
				"此致\n"+
				"\n"+
				"宁波市拍卖行业协会\n"+
				"www.nbpmzx.com.cn\n");
			
			msg.saveChanges(); // implicit with send() 

			Transport.send(msg);
		} catch (MessagingException mex) {
	        System.out.println("send failed, exception: " + mex);
	    } catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}