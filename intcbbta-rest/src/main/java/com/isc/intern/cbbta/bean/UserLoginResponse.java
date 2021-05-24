package com.isc.intern.cbbta.bean;

public class UserLoginResponse extends BaseResponse {
	private static final long serialVersionUID = 1L;
	private String token;
	private String rec_id;
	private String employeeNo;
	private String firstname;
	private String lastname;
	private String email;
	private String mobileNo;
	private String role;
	private String statusFaceRegis;
	private String image;
	
	public UserLoginResponse() {

	}
	
	public UserLoginResponse(String token, String rec_id, String employeeNo, String firstname, String lastname,
			String email, String mobileNo, String role, String statusFaceRegis) {
		super();
		this.token = token;
		this.rec_id = rec_id;
		this.employeeNo = employeeNo;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.mobileNo = mobileNo;
		this.role = role;
		this.statusFaceRegis = statusFaceRegis;
	}

	public String getRec_id() {
		return rec_id;
	}

	public void setRec_id(String rec_id) {
		this.rec_id = rec_id;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatusFaceRegis() {
		return statusFaceRegis;
	}

	public void setStatusFaceRegis(String statusFaceRegis) {
		this.statusFaceRegis = statusFaceRegis;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
}
