package com.isc.intern.cbbta.bean;

public class ConfigInfoResponse extends BaseResponse{

	private static final long serialVersionUID = 1L;
	private String scoreFaceCompare;
	private String timeAttendanceStart;
	private String timeAttendanceBeforeLate;
	private String timeAttendanceEnd;
	private String vacationDays;
	private String casualDays;
	private String sickDays;
    private String customerNo;
    private String nameEn;
    private String position;
    
	public String getScoreFaceCompare() {
		return scoreFaceCompare;
	}
	public void setScoreFaceCompare(String scoreFaceCompare) {
		this.scoreFaceCompare = scoreFaceCompare;
	}
	public String getTimeAttendanceStart() {
		return timeAttendanceStart;
	}
	public void setTimeAttendanceStart(String timeAttendanceStart) {
		this.timeAttendanceStart = timeAttendanceStart;
	}
	public String getTimeAttendanceBeforeLate() {
		return timeAttendanceBeforeLate;
	}
	public void setTimeAttendanceBeforeLate(String timeAttendanceBeforeLate) {
		this.timeAttendanceBeforeLate = timeAttendanceBeforeLate;
	}
	public String getTimeAttendanceEnd() {
		return timeAttendanceEnd;
	}
	public void setTimeAttendanceEnd(String timeAttendanceEnd) {
		this.timeAttendanceEnd = timeAttendanceEnd;
	}
	public String getVacationDays() {
		return vacationDays;
	}
	public void setVacationDays(String vacationDays) {
		this.vacationDays = vacationDays;
	}
	public String getCasualDays() {
		return casualDays;
	}
	public void setCasualDays(String casualDays) {
		this.casualDays = casualDays;
	}
	public String getSickDays() {
		return sickDays;
	}
	public void setSickDays(String sickDays) {
		this.sickDays = sickDays;
	}
	public String getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
}
