package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class FileTypeBean implements Bean {

	private int id;
	private String description;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public int getProgramId() {
		return 1;
	}
	
	
	
	
}
