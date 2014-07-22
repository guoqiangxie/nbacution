package com.useeasy.auction.util.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuthenticator extends Authenticator {

	private String strUser; 
    private String strPwd; 
    
    
    public MailAuthenticator(String user, String password) { 
    	this.strUser = user; 
    	this.strPwd = password; 
    } 

    protected PasswordAuthentication getPasswordAuthentication() { 
    	return new PasswordAuthentication(strUser, strPwd); 
    } 
}
