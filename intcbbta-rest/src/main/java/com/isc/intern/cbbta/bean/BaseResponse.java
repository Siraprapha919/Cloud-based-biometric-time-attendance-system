package com.isc.intern.cbbta.bean;

import java.io.Serializable;

public class BaseResponse implements Serializable {
	private static final long serialVersionUID = 1L;

	private String respCode;
	private String respDesc;
	private String reqRefNo;
	private String respRefNo;
	public String getRespCode() {
		return respCode;
	}
	public void setRespCode(String respCode) {
		this.respCode = respCode;
	}
	public String getRespDesc() {
		return respDesc;
	}
	public void setRespDesc(String respDesc) {
		this.respDesc = respDesc;
	}
	public String getReqRefNo() {
		return reqRefNo;
	}
	public void setReqRefNo(String reqRefNo) {
		this.reqRefNo = reqRefNo;
	}
	public String getRespRefNo() {
		return respRefNo;
	}
	public void setRespRefNo(String respRefNo) {
		this.respRefNo = respRefNo;
	}
}
