package com.isc.intern.cbbta.bean;

import java.io.Serializable;

public class CheckFaceRequest implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String name;
	private String image;
	private String status;
	private String refReqNo;
	private String token;

	public CheckFaceRequest(Long id, String name, String image, String status, String refReqNo, String token) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.status = status;
		this.refReqNo = refReqNo;
		this.token = token;
	}

	public CheckFaceRequest() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRefReqNo() {
		return refReqNo;
	}

	public void setRefReqNo(String refReqNo) {
		this.refReqNo = refReqNo;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
		
}
