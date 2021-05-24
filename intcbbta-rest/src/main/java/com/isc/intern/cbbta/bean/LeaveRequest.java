package com.isc.intern.cbbta.bean;

import java.util.Date;
import java.util.List;

public class LeaveRequest extends BaseRequest{

	private static final long serialVersionUID = 1L;
	private String employeeNo;
	private String firstname;
	private String lastname;
	private List<Date> leaveDate;
	private String leaveType;
	private int amount;
	public String getEmployeeNo() {
		return employeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public List<Date> getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(List<Date> leaveDate) {
		this.leaveDate = leaveDate;
	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
