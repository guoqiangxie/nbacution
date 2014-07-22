package com.useeasy.frame.util;

public class BasePage {
	
	private long cols;
	
	private long pageSize;
	
	private long currentPage;
	
	private String url;

	private String sortCol;

	private long sortType;
	
	private long pages;

	private long pageEntry;
	
	private int pageFirst;  //sql2005以上版本为1,其他为0
	
	public BasePage(){}
	
	public BasePage(long cols, String currentPageVal, String url){
		this.cols = cols;
		this.pageSize = 6;
		this.url = url;
		this.sortCol = null;
		this.sortType = 0;
		this.pages =(long) Math.ceil(((double)cols/(double)pageSize));
		this.pageEntry = 5;
		if(!Tools.checkRegen("^[1-9][0-9]{0,8}$", currentPageVal)){
			this.currentPage = 1;
		}else{
			this.currentPage = Long.parseLong(currentPageVal);
		}
		if(this.currentPage > this.pages){
			this.currentPage = 1;
		}
		this.pageFirst = 1;  //sql2005以上版本为1,其他为0
	}
	
	public BasePage(long cols, long pageSize, String currentPage, 
			String url, String sortCol, long sortType, long pageEntry){
		this.cols = cols;
		this.pageSize = pageSize;
		//this.currentPage = currentPage;
		this.url = url;
		this.sortCol = sortCol;
		this.sortType = sortType;
		this.pages =(long) Math.ceil(((double)cols/(double)pageSize));
		this.pageEntry = pageEntry;
		this.pageFirst = 1;  //sql2005以上版本为1,其他为0
		/*try{
			this.currentPage = Long.parseLong(currentPageVal);
		}catch (Exception e){
			this.currentPage = 1;
		}
		if(this.currentPageVal > this.pages){
			this.currentPage = "1";
		}*/
	}

	public long getCols() {
		return cols;
	}

	public void setCols(long cols) {
		this.cols = cols;
	}

	public long getPageSize() {
		return pageSize;
	}

	public void setPageSize(long pageSize) {
		this.pageSize = pageSize;
	}

	public long getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(long currentPage) {
		this.currentPage = currentPage;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSortCol() {
		return sortCol;
	}

	public void setSortCol(String sortCol) {
		this.sortCol = sortCol;
	}

	public long getSortType() {
		return sortType;
	}

	public void setSortType(long sortType) {
		this.sortType = sortType;
	}

	public long getPages() {
		return pages;
	}

	public void setPages(long pages) {
		this.pages = pages;
	}

	public long getPageEntry() {
		return pageEntry;
	}

	public void setPageEntry(long pageEntry) {
		this.pageEntry = pageEntry;
	}

	public int getPageFirst() {
		return pageFirst;
	}

	public void setPageFirst(int pageFirst) {
		this.pageFirst = pageFirst;
	}
	
	

}
