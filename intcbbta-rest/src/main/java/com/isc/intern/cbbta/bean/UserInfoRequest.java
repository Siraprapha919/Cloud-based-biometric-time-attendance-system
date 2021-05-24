package com.isc.intern.cbbta.bean;

public class UserInfoRequest extends BaseRequest{

	private static final long serialVersionUID = 1L;
	private String id;
	private String mobileNo;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	
}
