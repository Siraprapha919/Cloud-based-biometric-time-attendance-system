package com.isc.intern.cbbta.websocket.payload;

import java.io.Serializable;

public class FaceExtractionPayload implements Serializable{
  
	private static final long serialVersionUID = 1L;
	private String user_id;
	private String image;
	private String cmd;

	public FaceExtractionPayload() {
		super();
		// TODO Auto-generated constructor stub
	}


	public FaceExtractionPayload(String user_id, String image, String cmd) {
		super();
		this.user_id = user_id;
		this.image = image;
		this.cmd = cmd;
	}

	public String getCmd() {
		return cmd;
	}

	public void setCmd(String cmd) {
		this.cmd = cmd;
	}

	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
