package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class OptionsByProgramBean implements Bean {

	private int id;
	private String id_program;
	private String program_description;
	private String id_option;
	private String option_description;
	private String id_rol;
	
	public String getId_rol() {
		return id_rol;
	}
	public void setId_rol(String id_rol) {
		this.id_rol = id_rol;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getId_program() {
		return id_program;
	}
	public void setId_program(String id_program) {
		this.id_program = id_program;
	}
	public String getProgram_description() {
		return program_description;
	}
	public void setProgram_description(String program_description) {
		this.program_description = program_description;
	}
	public String getId_option() {
		return id_option;
	}
	public void setId_option(String id_option) {
		this.id_option = id_option;
	}
	public String getOption_description() {
		return option_description;
	}
	public void setOption_description(String option_description) {
		this.option_description = option_description;
	}
	
	@Override
	public int getProgramId() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	
	
}
