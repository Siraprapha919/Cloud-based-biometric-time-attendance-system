package com.isc.intern.cbbta.bean;

public class RegisterRequest extends BaseRequest {
	private static final long serialVersionUID = 1L;
	private String firstname;
	private String lastname;
	private String mobile;
	private String role;
	private String email;
	private String password;
	private String img64;

	public RegisterRequest(String firstname, String lastname, String mobile, String role, String email, String password,
			String img64) {
		super();
		this.firstname = firstname;
		this.lastname = lastname;
		this.mobile = mobile;
		this.role = role;
		this.email = email;
		this.password = password;
		this.img64 = img64;
	}

	public String getImg64() {
		return img64;
	}

	public void setImg64(String img64) {
		this.img64 = img64;
	}

	public RegisterRequest() {
		super();
		// TODO Auto-generated constructor stub
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

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
