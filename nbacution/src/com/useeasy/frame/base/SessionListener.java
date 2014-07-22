package com.useeasy.frame.base;

import javax.servlet.http.HttpSessionEvent;

import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.useeasy.frame.util.Constants;

/*
 * 监听所有的会话
 */
public class SessionListener  implements HttpSessionListener {
	
	static final Logger logger = LoggerFactory.getLogger(SessionListener.class);
     //每创建一个会话都绑定一个对像与一个会活ID
    public void sessionCreated(HttpSessionEvent event) { 
    	event.getSession().setAttribute(Constants.SESEION_LISTENER, SessionContainer.getInstance());
    	event.getSession().setAttribute(Constants.SESSION_ID, event.getSession().getId());
    	//logger.info("session create");
    } 
     
    public void sessionDestroyed(HttpSessionEvent event) { 
    	event.getSession().removeAttribute(Constants.SESEION_LISTENER);
    	event.getSession().removeAttribute(Constants.SESSION_ID);
    	//logger.info("session destory");
   } 
}
