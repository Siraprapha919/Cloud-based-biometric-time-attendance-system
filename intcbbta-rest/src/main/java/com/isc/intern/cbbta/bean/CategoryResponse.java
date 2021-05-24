package com.isc.intern.cbbta.bean;

import java.util.List;

import com.isc.intern.cbbta.config.CategoryDevice;

public class CategoryResponse extends BaseResponse{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<CategoryDevice> category;
	
	public List<CategoryDevice> getCategory() {
		return category;
	}

	public void setCategory(List<CategoryDevice> category) {
		this.category = category;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
