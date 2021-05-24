package com.isc.intern.cbbta.bean;

import java.util.Date;

public class UserInfoResponse extends BaseResponse{

	private static final long serialVersionUID = 1L;
	private Long recId;
    private String employeeNo;
    private String fname;
    private String lname;
    private String image;
    private String mobileNo;
    private String role;
    private String email;
    private String faceRegisStatus;
    private String faceStatus;
	
	public Long getRecId() {
		return recId;
	}
	public void setRecId(Long recId) {
		this.recId = recId;
	}
	public String getEmployeeNo() {
		return employeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String imagePath) {
		this.image = imagePath;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
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
	public String getFaceRegisStatus() {
		return faceRegisStatus;
	}
	public void setFaceRegisStatus(String faceRegisStatus) {
		this.faceRegisStatus = faceRegisStatus;
	}
	public String getFaceStatus() {
		return faceStatus;
	}
	public void setFaceStatus(String faceStatus) {
		this.faceStatus = faceStatus;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
