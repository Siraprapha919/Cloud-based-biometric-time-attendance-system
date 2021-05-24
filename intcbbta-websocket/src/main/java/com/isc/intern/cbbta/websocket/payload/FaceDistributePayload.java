package com.isc.intern.cbbta.websocket.payload;

import java.io.Serializable;

public class FaceDistributePayload implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long user_id;
    private String username;
    private String status;//advisor,employee,blacklist
    private String image;
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    

}
