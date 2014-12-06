package com.riseon.chitfund.dto;

public class AddSchemeBean 
{
	//private String schemeId;

	private String adminId;
	private String adminFName;
	private int schemeType;
	private String schemeId;
	private double schemePrice;
	private double schemeValidity;
	private String schemeStatus;
	
	
	public String getSchemeId() {
		return schemeId;
	}
	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}
	public String getSchemeStatus() {
		return schemeStatus;
	}
	public void setSchemeStatus(String schemeStatus) {
		this.schemeStatus = schemeStatus;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminFName() {
		return adminFName;
	}
	public void setAdminFName(String adminFName) {
		this.adminFName = adminFName;
	}
	public int getSchemeType() {
		return schemeType;
	}
	public void setSchemeType(int schemeType) {
		this.schemeType = schemeType;
	}
	public double getSchemePrice() {
		return schemePrice;
	}
	public void setSchemePrice(double schemePrice) {
		this.schemePrice = schemePrice;
	}
	public double getSchemeValidity() {
		return schemeValidity;
	}
	public void setSchemeValidity(double schemeValidity) {
		this.schemeValidity = schemeValidity;
	}
	
	
}
