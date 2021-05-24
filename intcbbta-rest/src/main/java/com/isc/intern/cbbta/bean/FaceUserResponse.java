package com.isc.intern.cbbta.bean;

import java.util.List;

import com.isc.intern.cbbta.model.UserModel;

public class FaceUserResponse  extends BaseResponse{

	private static final long serialVersionUID = 1L;
	List<UserModel> model;
	public List<UserModel> getModel() {
		return model;
	}
	public void setModel(List<UserModel> model) {
		this.model = model;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
