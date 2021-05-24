package com.isc.intern.cbbta.bean;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotBlank;

public class BaseRequest implements Serializable {
	private static final long serialVersionUID = 1L;

	@NotBlank
	private String reqRefNo;

	public String getReqRefNo() {
		return reqRefNo;
	}
	public void setReqRefNo(String reqRefNo) {
		this.reqRefNo = reqRefNo;
	}
}
