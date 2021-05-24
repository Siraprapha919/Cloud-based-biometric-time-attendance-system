package com.isc.intern.cbbta.bean;

public class UserLoginRequest extends BaseRequest{
	private static final long serialVersionUID = 1L;
	String mobile;
	String password;
	public UserLoginRequest() {
		
	}
	public UserLoginRequest(String mobile, String password) {
		super();
		this.mobile = mobile;
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
