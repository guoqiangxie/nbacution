package com.useeasy.auction.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class SystemPrivilege implements Serializable{
	private Integer id;
	private String privilageName;//权限模块
	private String privilageCName;//权限中文名
	private String privilageValue;//仅限值
	private Set<AuctionAccount>  emps = new HashSet<AuctionAccount>();
	
	
	public SystemPrivilege(String privilageName, String privilageCName,
			String privilageValue) {
		super();
		this.privilageName = privilageName;
		this.privilageCName = privilageCName;
		this.privilageValue = privilageValue;
	}
	 
	public SystemPrivilege(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPrivilageName() {
		return privilageName;
	}

	public void setPrivilageName(String privilageName) {
		this.privilageName = privilageName;
	}

	public String getPrivilageCName() {
		return privilageCName;
	}

	public void setPrivilageCName(String privilageCName) {
		this.privilageCName = privilageCName;
	}

	public String getPrivilageValue() {
		return privilageValue;
	}

	public void setPrivilageValue(String privilageValue) {
		this.privilageValue = privilageValue;
	}

	public Set<AuctionAccount> getEmps() {
		return emps;
	}

	public void setEmps(Set<AuctionAccount> emps) {
		this.emps = emps;
	}

 
	
	
	
}
