package com.isc.intern.cbbta.bean;

public class DeviceDeleteRequest extends BaseRequest{

	private static final long serialVersionUID = 1L;
	private String deviceCode;
	private String loginNameStaff;
	public String getDeviceCode() {
		return deviceCode;
	}
	public void setDeviceCode(String deviceCode) {
		this.deviceCode = deviceCode;
	}
	public String getLoginNameStaff() {
		return loginNameStaff;
	}
	public void setLoginNameStaff(String loginNameStaff) {
		this.loginNameStaff = loginNameStaff;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
