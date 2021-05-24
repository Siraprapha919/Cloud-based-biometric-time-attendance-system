package com.isc.intern.cbbta.model;

public class DeviceModel {
	private Long rec_id;
	private String msCategory;
	private String code;
	private String name;

	
	public DeviceModel(Long rec_id, String msCategory, String code, String name) {
		super();
		this.rec_id = rec_id;
		this.msCategory = msCategory;
		this.code = code;
		this.name = name;
	}
	public DeviceModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Long getRec_id() {
		return rec_id;
	}
	public void setRec_id(Long rec_id) {
		this.rec_id = rec_id;
	}
	public String getMsCategory() {
		return msCategory;
	}
	public void setMsCategory(String msCategory) {
		this.msCategory = msCategory;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
