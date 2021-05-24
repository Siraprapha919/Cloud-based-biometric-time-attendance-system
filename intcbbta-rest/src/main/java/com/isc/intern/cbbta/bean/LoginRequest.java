package com.isc.intern.cbbta.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import com.isc.intern.cbbta.common.constant.LookupConstant;

public class LoginRequest extends BaseRequest {
	private static final long serialVersionUID = 1L;

//	@NotBlank
//	@Pattern(regexp = LookupConstant.MOBILE_NO_PATTERN)
	private String mobileNo;
	@NotBlank
	private String password;
//	@NotBlank
//	private String deviceId;
//	@NotBlank
//	private String deivceModel;
//	@NotBlank
//	private String deviceSystem;
//	@NotBlank
//	private String deviceMacAddress;
//	@NotBlank
//	private String deviceChannel;
//	@NotBlank
//	private String deviceVersion;
//	private String devicePushToken;

	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
//	public String getDeviceId() {
//		return deviceId;
//	}
//	public void setDeviceId(String deviceId) {
//		this.deviceId = deviceId;
//	}
//	public String getDeivceModel() {
//		return deivceModel;
//	}
//	public void setDeivceModel(String deivceModel) {
//		this.deivceModel = deivceModel;
//	}
//	public String getDeviceSystem() {
//		return deviceSystem;
//	}
//	public void setDeviceSystem(String deviceSystem) {
//		this.deviceSystem = deviceSystem;
//	}
//	public String getDeviceMacAddress() {
//		return deviceMacAddress;
//	}
//	public void setDeviceMacAddress(String deviceMacAddress) {
//		this.deviceMacAddress = deviceMacAddress;
//	}
//	public String getDeviceChannel() {
//		return deviceChannel;
//	}
//	public void setDeviceChannel(String deviceChannel) {
//		this.deviceChannel = deviceChannel;
//	}
//	public String getDeviceVersion() {
//		return deviceVersion;
//	}
//	public void setDeviceVersion(String deviceVersion) {
//		this.deviceVersion = deviceVersion;
//	}
//	public String getDevicePushToken() {
//		return devicePushToken;
//	}
//	public void setDevicePushToken(String deviceToken) {
//		this.devicePushToken = deviceToken;
//	}
	
}
