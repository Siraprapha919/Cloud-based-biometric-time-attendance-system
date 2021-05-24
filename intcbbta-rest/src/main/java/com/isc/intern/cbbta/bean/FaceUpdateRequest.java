package com.isc.intern.cbbta.bean;

public class FaceUpdateRequest extends BaseRequest{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String id;
	String image;
	
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
