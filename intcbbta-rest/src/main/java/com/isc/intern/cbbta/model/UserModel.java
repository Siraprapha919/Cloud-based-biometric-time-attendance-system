package com.isc.intern.cbbta.model;

import java.util.Date;

public class UserModel {
	
	String id;
	String name;
	String lastname;
	String image;
	String accessibility;
	
	public UserModel(String id, String name, String lastname, String image, String accessibility) {
		super();
		this.id = id;
		this.name = name;
		this.lastname = lastname;
		this.image = image;
		this.accessibility = accessibility;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAccessibility() {
		return accessibility;
	}
	public void setAccessibility(String accessibility) {
		this.accessibility = accessibility;
	}	
}
