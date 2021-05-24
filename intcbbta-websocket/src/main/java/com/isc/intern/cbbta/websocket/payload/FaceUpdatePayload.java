package com.isc.intern.cbbta.websocket.payload;

public class FaceUpdatePayload {
	String id;
	String image;
	String reqRefNo;
	
	public String getReqRefNo() {
		return reqRefNo;
	}
	public void setReqRefNo(String reqRefNo) {
		this.reqRefNo = reqRefNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
