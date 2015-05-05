package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ProgramBean implements Bean {

	private int id;
	private String description;
	private String program_name;
	
	
	
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
	public String getProgram_name() {
		return program_name;
	}
	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
	
	
	
}
