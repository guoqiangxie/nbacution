package com.useeasy.frame.base;

import org.springframework.context.support.*;



public class AppContext {

	private static AppContext instance;
   
	private AbstractApplicationContext appContext;

	public synchronized static AppContext getInstance() {
		if (instance == null) {
			instance = new AppContext();
		}
		return instance;
	}

	private AppContext() {
		String[] paths = { "applicationContext.xml" };  
		this.appContext = new ClassPathXmlApplicationContext(paths);
	}

	public AbstractApplicationContext getAppContext() {
		return appContext;
	}
}
