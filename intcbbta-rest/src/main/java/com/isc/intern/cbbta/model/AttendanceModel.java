package com.isc.intern.cbbta.model;

public class AttendanceModel {
	private String rec_id;
	private String user_no;
	private String username;

	private String date_time;
	private String score;
	private String role;
	
	
	
	public AttendanceModel(String rec_id, String user_no, String username, String date_time, String score,
			String role) {
		super();
		this.rec_id = rec_id;
		this.user_no = user_no;
		this.username = username;
	
		this.date_time = date_time;
		this.score = score;
		this.role = role;
	}
	


	public String getRec_id() {
		return rec_id;
	}
	public void setRec_id(String rec_id) {
		this.rec_id = rec_id;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
//	public String getImage() {
//		return image;
//	}
//	public void setImage(String image) {
//		this.image = image;
//	}
	public String getDate_time() {
		return date_time;
	}
	public void setDate_time(String date_time) {
		this.date_time = date_time;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
}
