package com.isc.intern.cbbta.bean;

import java.util.List;

import com.isc.intern.cbbta.model.DeviceModel;

public class DeviceInfoResponse extends BaseResponse{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	List<DeviceModel> deviceAll;
	public List<DeviceModel> getDeviceAll() {
		return deviceAll;
	}
	public void setDeviceAll(List<DeviceModel> deviceAll) {
		this.deviceAll = deviceAll;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
