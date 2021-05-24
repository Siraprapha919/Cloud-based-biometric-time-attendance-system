package com.isc.intern.cbbta.bean;

public class LoginResponse extends BaseResponse {
	private static final long serialVersionUID = 1L;
	private String customerNo;
	private String token;
	private String mobileNo;
	private String level;
	
	public LoginResponse() {

	}
		
	public LoginResponse(String customerNo, String token, String mobileNo) {
		super();
		this.customerNo = customerNo;

		this.token = token;
		this.mobileNo = mobileNo;
	}


	public String getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setEmployeeNo(Long employeeNo) {
		// TODO Auto-generated method stub
		
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	
	

}
