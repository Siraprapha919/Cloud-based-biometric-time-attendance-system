package com.isc.intern.cbbta.bean;

import java.util.List;

import com.isc.intern.cbbta.model.AttendanceModel;

public class AttendanceResponse extends BaseResponse{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<AttendanceModel> attendance;

	public List<AttendanceModel> getAttendance() {
		return attendance;
	}

	public void setAttendance(List<AttendanceModel> attendance) {
		this.attendance = attendance;
	}
	
}
