package com.isc.intern.cbbta.bean;

public class FaceUpdateStatusRequest extends BaseRequest{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String image;
	private String statusExtraction;
	
	public String getId() {
		return id;
	}
	public void setId(String userId) {
		this.id = userId;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	public String getStatusExtraction() {
		return statusExtraction;
	}
	public void setStatusExtraction(String statusExtraction) {
		this.statusExtraction = statusExtraction;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
