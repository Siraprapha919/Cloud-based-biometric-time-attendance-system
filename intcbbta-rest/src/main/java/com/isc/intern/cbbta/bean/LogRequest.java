package com.isc.intern.cbbta.bean;

public class LogRequest {
	private String id;
	private String name;
	private String role;
	private String dateTime;
	
	public LogRequest(String id, String name, String role, String dateTime) {
		super();
		this.id = id;
		this.name = name;
		this.role = role;
		this.dateTime = dateTime;
	}
	
	public LogRequest() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	

}
