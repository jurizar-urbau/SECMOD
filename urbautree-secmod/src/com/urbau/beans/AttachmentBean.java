package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class AttachmentBean implements Bean {

	private int id;
	private int odtId;
	private String description = "";
	private String type = "";
	private String path = "";
	
	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public int getOdtId() {
		return odtId;
	}




	public void setOdtId(int odtId) {
		this.odtId = odtId;
	}




	public String getDescription() {
		return description;
	}




	public void setDescription(String description) {
		this.description = description;
	}




	public String getType() {
		return type;
	}




	public void setType(String type) {
		this.type = type;
	}




	public String getPath() {
		return path;
	}




	public void setPath(String path) {
		this.path = path;
	}




	@Override
	public int getProgramId() {
		return 300;
	}
	
}
