package com.isc.intern.cbbta.bean;

import java.util.List;

public class PositionResponse extends BaseResponse{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	List<String> position;

	public List<String> getPosition() {
		return position;
	}

	public void setPosition(List<String> position) {
		this.position = position;
	}
	
}
