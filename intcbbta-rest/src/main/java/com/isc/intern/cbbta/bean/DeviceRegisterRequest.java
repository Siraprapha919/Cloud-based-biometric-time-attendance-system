package com.isc.intern.cbbta.bean;

public class DeviceRegisterRequest extends BaseRequest{
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long rec_id;
	
	private String msCategory;
//	private String msProvinceCode;
//	private String msDistrictCode;
//	private String msSubdistrictCode;
//	private String address;
	private String code;
	private String name;
//	  String license;
	  
	public String getMsCategory() {
		return msCategory;
	}
	public void setMsCategory(String msCategory) {
		this.msCategory = msCategory;
	}
	public Long getRec_id() {
		return rec_id;
	}
	public void setRec_id(Long rec_id) {
		this.rec_id = rec_id;
	}
//	public String getMsProvinceCode() {
//		return msProvinceCode;
//	}
//	public void setMsProvinceCode(String msProvinceCode) {
//		this.msProvinceCode = msProvinceCode;
//	}
//	public String getMsDistrictCode() {
//		return msDistrictCode;
//	}
//	public void setMsDistrictCode(String msDistrictCode) {
//		this.msDistrictCode = msDistrictCode;
//	}
//	public String getMsSubdistrictCode() {
//		return msSubdistrictCode;
//	}
//	public void setMsSubdistrictCode(String msSubdistrictCode) {
//		this.msSubdistrictCode = msSubdistrictCode;
//	}
//	public String getAddress() {
//		return address;
//	}
//	public void setAddress(String address) {
//		this.address = address;
//	}
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
//	public String getLicense() {
//		return license;
//	}
//	public void setLicense(String license) {
//		this.license = license;
//	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	  
}
