package com.yc.bean;

/**
 * @ClassName:     NewsBean.java
 * @author          POM
 * @version         V1.0  
 * @Date           2016年9月7日 上午11:09:27 
 */

public class NewsBean {
	private int nid;
	private int nTid;
	private String nTitle;
	private String nAuthor;
	private String ncreateDate;
	private String nPicPath;
	private String nContent;
	private String nModifyDate; 
	private String nSummary;
	
	
	
	public int getNid() {
		return nid;
	}
	/**
	 * @return the ncreateDate
	 */
	public String getNcreateDate() {
		return ncreateDate;
	}
	/**
	 * @param ncreateDate the ncreateDate to set
	 */
	public void setNcreateDate(String ncreateDate) {
		this.ncreateDate = ncreateDate;
	}
	/**
	 * @return the nModifyDate
	 */
	public String getnModifyDate() {
		return nModifyDate;
	}
	/**
	 * @param nModifyDate the nModifyDate to set
	 */
	public void setnModifyDate(String nModifyDate) {
		this.nModifyDate = nModifyDate;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public int getnTid() {
		return nTid;
	}

	public void setnTid(int nTid) {
		this.nTid = nTid;
	}

	public String getnTitle() {
		return nTitle;
	}

	public void setnTitle(String nTitle) {
		this.nTitle = nTitle;
	}

	public String getnAuthor() {
		return nAuthor;
	}

	public void setnAuthor(String nAuthor) {
		this.nAuthor = nAuthor;
	}
	public String getnPicPath() {
		return nPicPath;
	}
	public void setnPicPath(String nPicPath) {
		this.nPicPath = nPicPath;
	}
	public String getnContent() {
		return nContent;
	}
	public void setnContent(String nContent) {
		this.nContent = nContent;
	}
	public String getnSummary() {
		return nSummary;
	}
	public void setnSummary(String nSummary) {
		this.nSummary = nSummary;
	}



}
