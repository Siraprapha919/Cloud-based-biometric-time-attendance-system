package com.isc.intern.cbbta.bean;

public class FaceUpdateStatus extends BaseRequest{

	private static final long serialVersionUID = 1L;
	private String id;
    private String image;
    private String status;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
  
	
}
